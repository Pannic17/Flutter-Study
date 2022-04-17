// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, avoid_print, no_logic_in_create_state


import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  };
  runApp(const SingleApp());
}

class SingleApp extends StatelessWidget {
  const SingleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homePage(),
      theme: ThemeData(
        backgroundColor: Color(0xFF1d1d1d),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Color(0xFFFFFFFF)),
          bodyText2: TextStyle(color: Color(0xFFFFFFFF)),
        )
      ),
    );
  }
}

class homePage extends StatelessWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width
        ),
        designSize: const Size(750, 1624),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF1d1d1d)),
        child: homeContent(),
      ),
    );
  }
}

class homeContent extends StatefulWidget {

  const homeContent({
    Key? key
  }) : super(key: key);

  @override
  State<homeContent> createState() => _homeContentState();
}

class _homeContentState extends State<homeContent> {
  final swiperUrl = [
    "https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/s1.png",
    "https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/s2.png",
    "https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/s3.png"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(0),
      child:
        Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            SingleSwiper(swiperUrl: swiperUrl),
            Container(
              margin: EdgeInsets.only(top: 900.w),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: SinglePanel(),
                ),
              ),
            )
          ],
        ),
    );
  }
}

class SingleButtonSet extends StatefulWidget {
  final bool likeState;
  final bool collectState;
  final int likeCount;
  final int collectCount;

  const SingleButtonSet({
    Key? key,
    required this.likeState,
    required this.collectState,
    required this.likeCount,
    required this.collectCount
  }) : super(key: key);

  @override
  State<SingleButtonSet> createState() => _SingleButtonSetState();
}

class _SingleButtonSetState extends State<SingleButtonSet> {
  int likeCount = 0;
  int collectCount = 0;
  bool likeState = true;
  bool collectState = false;
  final Icon likeButtonTrue = Icon(CupertinoIcons.star_fill, color: Colors.blue, size: 45.w,);
  final Icon likeButtonFalse = Icon(CupertinoIcons.star, color: Colors.white, size: 45.w,);
  final Icon collectButtonTrue = Icon(CupertinoIcons.heart_fill, color: Colors.blue, size: 45.w,);
  final Icon collectButtonFalse = Icon(CupertinoIcons.heart, color: Colors.white, size: 45.w,);


  @override
  void initState() {
    super.initState();
    likeCount = widget.likeCount;
    collectCount = widget.collectCount;
    likeState = widget.likeState;
    collectState = widget.collectState;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SingleCountButton(
          state: likeState,
          count: likeCount,
          trueIcon: likeButtonTrue,
          falseIcon: likeButtonFalse,
          longPress: (state) {
            setState(() {
              likeState = true;
              collectState = true;
            });
          },
          pressButton: (state) {
            setState(() {
              likeState = state;
            });
          },
        ),
        SingleCountButton(
          state: collectState,
          count: collectCount,
          trueIcon: collectButtonTrue,
          falseIcon: collectButtonFalse,
          longPress: (state) {
            setState(() {
              likeState = true;
              collectState = true;
            });
          },
          pressButton: (state) {
            setState(() {
              collectState = state;
            });
          },
        )
      ],
    );
  }
}

class SingleCountButton extends StatefulWidget {
  final Icon trueIcon;
  final Icon falseIcon;
  final bool state;
  final int count;
  final ValueChanged<bool> longPress;
  final ValueChanged<bool> pressButton;

  const SingleCountButton({
    Key? key,
    required this.state,
    required this.count,
    required this.trueIcon,
    required this.falseIcon,
    required this.longPress,
    required this.pressButton
  }) : super(key: key);

  @override
  State<SingleCountButton> createState() => _SingleCountButtonState(trueIcon: trueIcon, falseIcon: falseIcon);
}

class _SingleCountButtonState extends State<SingleCountButton> {
  int count = 0;
  Icon button = Icon(Icons.star);
  final Icon trueIcon;
  final Icon falseIcon;

  _SingleCountButtonState({required this.trueIcon, required this.falseIcon});

  @override
  void initState() {
    super.initState();
    count = widget.count;
    if (widget.state) {
      button = trueIcon;
    } else {
      button = falseIcon;
    }
  }

  @override
  void didUpdateWidget(covariant SingleCountButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state) {
      button = trueIcon;
    } else {
      button = falseIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.w,
      width: 45.w,
      child: TextButton(
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
        onPressed: () {
          setState(() {
            if (widget.state == false) {
              count++;
              button = trueIcon;
            } else {
              count--;
              button = falseIcon;
            }
          });
          widget.pressButton(!widget.state);
        },
        onLongPress: () {
          widget.longPress(true);
        },
        child: Column(
          children: [
            button,
            Text(count.toString(), style: TextStyle(fontSize: 21.sp, color: Color(0xFF616161)))
          ],
        ),
      ),
    );
  }
}

class HomeSwiperSet extends StatefulWidget {
  const HomeSwiperSet({Key? key}) : super(key: key);

  @override
  State<HomeSwiperSet> createState() => _HomeSwiperSetState();
}

class _HomeSwiperSetState extends State<HomeSwiperSet> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SingleSwiper extends StatelessWidget {
  final List<String> swiperUrl;

  const SingleSwiper({
    Key? key,
    required this.swiperUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 750.w,
      height: 1000.w,
      child: Swiper(
        itemCount: swiperUrl.length,
        autoplay: true,
        autoplayDelay: 2000,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Image.network(swiperUrl[index], fit: BoxFit.fitWidth),
              Container(
                width: 750.w,
                height: 1000.w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.84, 0.9, 0.98],
                      colors: [Color(0x00000000), Color(0x661d1d1d), Color(0xFF1d1d1d)],
                    )
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SinglePanel extends StatelessWidget {
  const SinglePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xFF353535)),
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
        color: Color(0x991d1d1d),

      ),
      child: SizedBox(height: 8000.w, width: 720.w),
    );
  }
}

