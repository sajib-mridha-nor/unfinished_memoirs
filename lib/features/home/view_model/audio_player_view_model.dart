import 'package:audioplayers/audioplayers.dart';
import 'package:bongobondhu_app/core/utils/app_navigator.dart';
import 'package:bongobondhu_app/core/utils/auth_wrapper.dart';
import 'package:bongobondhu_app/features/home/repository/last_viewed_repository.dart';
import 'package:bongobondhu_app/features/home/view_model/home_view_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerViewModel with ChangeNotifier {
  static AudioPlayerViewModel read(BuildContext context) =>
      context.read<AudioPlayerViewModel>();

  static AudioPlayerViewModel watch(BuildContext context) =>
      context.watch<AudioPlayerViewModel>();

  AudioPlayer audioPlayer = AudioPlayer();
  bool isMute = false;

  mute() {
    audioPlayer.setVolume(0);
    isMute = true;
    notifyListeners();
  }

  unMute() {
    audioPlayer.setVolume(1);
    isMute = false;
    notifyListeners();
  }

  ScrollController _controller = ScrollController();

  List<GlobalObjectKey> _globalKeys = [];

  int _selectedIndex = -1;

  Duration _currentTime = Duration.zero;
  Duration _totalTime = const Duration(milliseconds: 1);

  set selectedIndex(int v) {
    _selectedIndex = v;
    notifyListeners();
  }

  set globalKeys(List<GlobalObjectKey> v) {
    _globalKeys = v;
    notifyListeners();
  }

  set controller(ScrollController v) {
    _controller = v;
    notifyListeners();
  }

  set totalTime(Duration v) {
    _totalTime = v;
    notifyListeners();
  }

  set currentTime(Duration v) {
    _currentTime = v;
    notifyListeners();
  }

  Future<void> playAudio(
    String audioUrl, {
    Duration duration = Duration.zero,
  }) async {
    BotToast.showLoading();

    await audioPlayer.play(
      UrlSource('https://bangabandhu.agrexcointernational.com$audioUrl'),
    );

    if (duration.inMilliseconds == 0) {
      BotToast.closeAllLoading();
    } else {
      await audioSeek(duration);
    }
  }

  Future<void> onTapPlay({
    required HomeViewModel homeVm,
    required int lineIndex,
  }) async {
    final durationString = homeVm.pageData?.pageLines?[lineIndex].startTime;
    final timeComponents = durationString?.split(':');
    final minutes = int.parse(timeComponents![0]);
    final seconds = double.parse(timeComponents[1]);
    final milliseconds = (minutes * 60 * 1000 + seconds * 1000).round();
    final duration = Duration(milliseconds: milliseconds);
    if (audioPlayer.state != PlayerState.playing ||
        audioPlayer.state != PlayerState.paused) {
      homeVm.isPlay = true;
      await playAudio(
        homeVm.pageData?.audio ?? '',
        duration: duration,
      );
      await audioSeek(duration);
      BotToast.closeAllLoading();
      selectedIndex = lineIndex;
    } else {
      BotToast.showLoading();

      await audioSeek(duration);
      selectedIndex = lineIndex;
      BotToast.closeAllLoading();
    }
  }

  void disposeAudio() {
    audioPlayer.stop();
    _totalTime = const Duration(milliseconds: 1);
    _currentTime = Duration.zero;
  }

  void pauseAudio() {
    audioPlayer.pause();
  }

  Future<void> audioSeek(Duration duration) async {
    await audioPlayer.seek(duration);
  }

  Future<void> playerDurationChange(Duration d) async {
    _totalTime = d;
    await audioPlayer.resume();
    notifyListeners();
  }

  Future<void> positionChange(
    Duration position,
  ) async {
    final homeVm = HomeViewModel.read(appNavigator.context!);

    if (position.compareTo(_totalTime) >= 0) {
    } else if (_currentTime.inMilliseconds >= _totalTime.inMilliseconds - 200) {
      _selectedIndex = -1;
      disposeAudio();
      _controller.jumpTo(0);
      HomeViewModel.read(appNavigator.context!).isPlay = false;
    } else {
      _currentTime = position;
      final durationString = homeVm.pageData?.pageLines?[selectedIndex].endTime;
      final timeComponents = durationString?.split(':');
      final minutes = int.parse(timeComponents![0]);
      final seconds = double.parse(timeComponents[1]);
      final milliseconds = (minutes * 60 * 1000 + seconds * 1000).round();
      final duration = Duration(milliseconds: milliseconds);
      if (_currentTime.inMilliseconds > duration.inMilliseconds) {
        _selectedIndex = _selectedIndex + 1;
        _getElementLocation(_globalKeys[_selectedIndex]);
        final _accessVm = await AccessTokenProvider().getToken();
        if (_accessVm != '' || _accessVm != null) {
          _updateLastView(_selectedIndex);
        }
      }
    }
    notifyListeners();
  }

  void _updateLastView(int index) {
    final homeVm = HomeViewModel.read(appNavigator.context!);
    LastViewedRepository().updateLastView(
      lineSerial: homeVm.pageData?.pageLines![index].id.toString() ?? '0',
    );
  }

  Future<void> playerStateChange(
    PlayerState s,
  ) async {
    if (s == PlayerState.completed) {
      _selectedIndex = -1;
    }
  }

  void generateKeys() {
    _globalKeys = [];
    final homeVm = HomeViewModel.read(appNavigator.context!);
    final len = homeVm.pageData?.pageLines?.length ?? 0;
    for (var index = 0; index < len; index++) {
      final _keyElement = GlobalObjectKey(index);
      _globalKeys.add(_keyElement);
    }
  }

  void _getElementLocation(GlobalKey key) {
    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    if (_controller.position.viewportDimension < position.dy) {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      } else {
        _controller.jumpTo(
          _controller.offset + position.dy - 200,
        );
      }
    }
  }

  Duration get currentTime => _currentTime;

  Duration get totalTime => _totalTime;

  int get selectedIndex => _selectedIndex;

  List<GlobalObjectKey> get globalKeys => _globalKeys;

  ScrollController get controller => _controller;
}
