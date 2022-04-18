// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, avoid_print, no_logic_in_create_state, import_of_legacy_library_into_null_safe, slash_for_doc_comments


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
        ),
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
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(color: Color(0xFF1d1d1d)),
          child: Column(
            children: [
              SearchBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late FocusNode focus;
  int width = 520;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.addListener(() {
      print('SEARCH INPUT # ${controller.text}');
    });
    return SizedBox(
      height: 72.w,
      width: width.w,
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 30.w, color: Color(0xFFFFFFFF)),
        decoration: InputDecoration(
          hintText: "搜索 开物艺术品",
          hintStyle: TextStyle(fontSize: 27.w, color: Color(0xFF616161)),
          prefixIcon: Icon(Icons.search, color: Color(0xFF616161)),
          focusColor: Color(0xFF7BEEEB),
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF353535)),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF353535)),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF7BEEEB)),
              borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
          )
        ),
        focusNode: focus,
      ),
    );
  }
}



