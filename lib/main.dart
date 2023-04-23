// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';
import 'package:animatedlist/images.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const OnboardingList(),
    );
  }
}

//!============================================
class OnboardingList extends StatelessWidget {
  const OnboardingList({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -10,
              left: -150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  MyImageScrool(startIndex: 3),
                  MyImageScrool(startIndex: 2),
                  MyImageScrool(startIndex: 2),
                ],
              )),
          const Positioned(
              top: 50,
              child: Text(
                "Men Fashions",
                textScaleFactor: 2.8,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          Positioned(
              bottom: 0,
              child: Container(
                height: h * 0.6,
                width: w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Colors.white38,
                    Colors.white,
                    Colors.white
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                child: Column(
                  children: const [
                    Spacer(),
                    Text(
                      'Tour Appearance\nShows Your Quality.',
                      textScaleFactor: 2.5,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Change Your Utility of Your \nAppearance',
                      textScaleFactor: 1.2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SignInButton()
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

//! scroll images section
class MyImageScrool extends StatefulWidget {
  const MyImageScrool({
    Key? key,
    required this.startIndex,
  }) : super(key: key);

  final int startIndex;

  @override
  State<MyImageScrool> createState() => _MyImageScroolState();
}

class _MyImageScroolState extends State<MyImageScrool> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.minScrollExtent) {
        _autoScrollForward();
      } else if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        _autoScrollBackForward();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _autoScrollForward() {
    final double currentPosition = _scrollController.offset;
    final double endPosition = _scrollController.position.maxScrollExtent;
    scheduleMicrotask(() {
      _scrollController.animateTo(
          currentPosition == endPosition ? 0 : endPosition,
          duration: Duration(seconds: 20 * widget.startIndex * 2),
          curve: Curves.linear);
    });
  }

  _autoScrollBackForward() {
    final double currentPosition = _scrollController.offset;
    final double endPosition = _scrollController.position.minScrollExtent;
    final bool isAtMinScrollExtent = currentPosition == endPosition;
    scheduleMicrotask(() {
      _scrollController.animateTo(
          isAtMinScrollExtent
              ? _scrollController.position.maxScrollExtent
              : endPosition,
          duration: Duration(seconds: 40 * widget.startIndex * 2),
          curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Transform.rotate(
      angle: 1.96 * pi,
      child: SizedBox(
        height: h * 0.6,
        width: w * 0.6,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: h * 0.6,
              margin: const EdgeInsets.only(right: 8, left: 8, top: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage(
                        images[(index + widget.startIndex) % images.length],
                      ),
                      fit: BoxFit.cover)),
            );
          },
        ),
      ),
    );
  }
}

//!button Section
class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    const googlePath = 'lib/assets/logo/google.png';

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        icon: Image.asset(
          googlePath,
          width: 35,
        ),
        label: const Text(
          'Continue with Google',
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
