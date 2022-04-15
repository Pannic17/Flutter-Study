// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, avoid_print, no_logic_in_create_state


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

main() => runApp(listApp());

class listApp extends StatelessWidget {
  const listApp({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: Text("List"),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xFF1d1d1d)),
        padding: EdgeInsets.symmetric(
          horizontal: 27.w
        ),
        child: homeContent(likeState: true, collectState: false, likeCount: 9, collectCount: 6),
      ),
    );
  }
}

class homeContent extends StatefulWidget {
  final bool likeState;
  final bool collectState;
  final int likeCount;
  final int collectCount;

  const homeContent({
    Key? key,
    required this.likeState,
    required this.collectState,
    required this.likeCount,
    required this.collectCount
  }) : super(key: key);

  @override
  State<homeContent> createState() => _homeContentState();
}

class _homeContentState extends State<homeContent> {
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
    return Container(
      child: Row(
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
      ),
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
          print(widget.state.toString());
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



