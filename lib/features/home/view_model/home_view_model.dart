import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:bongobondhu_app/core/utils/language.dart';
import 'package:bongobondhu_app/features/home/model/last_played_line_data_model.dart';
import 'package:bongobondhu_app/features/home/model/page_data_model.dart';
import 'package:bongobondhu_app/features/home/repository/get_last_played_line_repository.dart';
import 'package:bongobondhu_app/features/home/repository/get_page_repository.dart';
import 'package:bongobondhu_app/features/home/view_model/audio_player_view_model.dart';
import 'package:bongobondhu_app/features/index/model/content_data_model.dart';
import 'package:bongobondhu_app/features/language/view_model/language_view_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeViewModel with ChangeNotifier {
  static HomeViewModel read(BuildContext context) =>
      context.read<HomeViewModel>();

  static HomeViewModel watch(BuildContext context) =>
      context.watch<HomeViewModel>();

  int _selectedPage = 1;
  int? _selectedLine;

  set selectedLine(int? v) {
    _selectedLine = v;
    notifyListeners();
  }

  set selectedPage(int v) {
    _selectedPage = v;
    notifyListeners();
  }

  ContentDataModel? _selectedContent;
  LastPlayedLineDataModel? _lastPlayedLineDataModel;

  set selectedContent(ContentDataModel? v) {
    _selectedContent = v;
    notifyListeners();
  }

  bool _isPlay = false;
  bool _isSearch = false;

  List<String> _searchIndexList = [];

  set isPlay(bool v) {
    _isPlay = v;
    notifyListeners();
  }

  set isSearch(bool v) {
    _isSearch = v;
    controller.clear();
    notifyListeners();
  }

  set searchIndexList(List<String> v) {
    _searchIndexList = v;
    notifyListeners();
  }

  bool _isLoading = false;
  PageDataModel? _pageData;

  set isLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  ///stt
  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';
  final TextEditingController controller = TextEditingController();

  Future<void> listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        await requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.provisional:
        break;
    }
  }

  Future<void> initSpeech() async {
    speechEnabled = await speechToText.initialize();
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    final languageVm = LanguageViewModel.read(appNavigator.context!);
    controller.clear();
    await speechToText.listen(
      onResult: onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId:
          languageVm.languageType == LanguageType.English ? 'en_US' : 'bn_BN',
      partialResults: false,
    );
    notifyListeners();
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    notifyListeners();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    lastWords = '';
    lastWords = '$lastWords${result.recognizedWords}';
    controller.text = lastWords;
    searchWord(controller.text);
  }

  ///

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  Future<void> getLastPlayedData() async {
    // final prefs = await SharedPreferences.getInstance();
    // final languageId = prefs.getString('languageId');
    // final res = await PageRepository().getData(
    //   languageId: languageId ?? '1',
    //   chapter: _selectedContent?.content ?? '',
    //   pageNumber: _selectedPage.toString(),
    // );
    final res = await LastPlayedLineRepository().getData();
    res.fold((l) {
      _lastPlayedLineDataModel = null;
      notifyListeners();
    }, (r) {
      _lastPlayedLineDataModel = r;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> getPageData() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final languageId = prefs.getString('languageId');
    final res = await PageRepository().getData(
      languageId: languageId ?? '1',
      chapter: _selectedContent?.content ?? '',
      pageNumber: _selectedPage.toString(),
    );
    res.fold((l) {
      isLoading = false;
      _pageData = null;
      notifyListeners();
    }, (r) {
      _pageData = r;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> reloadPage() async {
    AudioPlayerViewModel.read(appNavigator.context!)
      ..disposeAudio()
      ..selectedIndex = -1;
    _isPlay = false;
    await getPageData();
    AudioPlayerViewModel.read(appNavigator.context!).generateKeys();
  }

  void searchWord(String searchValue) {
    _searchIndexList = [];
    _pageData?.pageLines?.asMap().forEach((index, element) {
      if (element.lineText!.toLowerCase().contains(searchValue.toLowerCase()) &&
          searchValue.isNotEmpty) {
        _searchIndexList.add(index.toString());
      }
    });
    notifyListeners();
  }

  bool get isPlay => _isPlay;

  bool get isSearch => _isSearch;

  bool get isLoading => _isLoading;

  PageDataModel? get pageData => _pageData;

  ContentDataModel? get selectedContent => _selectedContent;

  int get selectedPage => _selectedPage;
  int? get selectedLine => _selectedLine;

  List<String> get searchIndexList => _searchIndexList;
}
