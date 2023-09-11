import 'dart:async';

import 'package:bongobondhu_app/features/language/view/language_select_page.dart';
import 'package:bongobondhu_app/features/language/view_model/language_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _seconds = 0;
  double _timeSecond = 0;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      setState(() {
        _seconds++;

        if (_seconds == 36) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LanguageSelectPage(),
            ),
          );
          stopTimer();
        }
        _timeSecond = _seconds / 35;
      });
    });
  }

  void stopTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _timeSecond = 0.0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    LanguageViewModel.read(context).getLanguageData();
    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffd4e9c0), Color(0xffead9b4)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _logoOfBSMR(),
            const SizedBox(
              height: 80,
            ),
            Text(
              'The Unfinished Memoirs\nby\nBangabandhu Sheikh Mujibur Rahman',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: const Color(0xff644C12),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(
              height: 113,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: LinearProgressIndicator(
                value: _timeSecond,
                backgroundColor: const Color(0xff896A24),
                color: const Color(0xffD4E9C0),
                minHeight: 7,
              ),
            ),
            const SizedBox(
              height: 98,
            ),
          ],
        ),
      ),
      //child: Center(child: Image.asset("assets/splash_screen_logo.png")),
    );
  }

  Widget _logoOfBSMR() {
    return Image.asset(
      'assets/splash_screen_logo.png',
    );
  }
}
