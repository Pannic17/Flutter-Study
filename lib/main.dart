// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables

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
          bodyText2: TextStyle(color: Color(0xFFFFFFFF), fontSize: 27.w),
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
        child: homeContent(),
      ),
    );
  }
}

class homeContent extends StatefulWidget {
  const homeContent({Key? key}) : super(key: key);

  @override
  State<homeContent> createState() => _homeContentState();
}

class _homeContentState extends State<homeContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [

        ],
      ),
    );
  }
}


