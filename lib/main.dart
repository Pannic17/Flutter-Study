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
              KaiwuSearchBar(),
              KaiwuSorterMulti(
                tags: ["1", "2", "3"],
                onSelect: (list) => {},
                height: 45.w,
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w)
              )
            ],
          ),
        ),
      ),
    );
  }
}

class KaiwuSearchBar extends StatefulWidget {
  const KaiwuSearchBar({Key? key}) : super(key: key);

  @override
  State<KaiwuSearchBar> createState() => _KaiwuSearchBarState();
}

class _KaiwuSearchBarState extends State<KaiwuSearchBar> {
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
          hintStyle: TextStyle(fontSize: 27.w, color: Color(0xFF9E9E9E)),
          prefixIcon: Icon(Icons.search, color: Color(0xFF9E9E9E)),
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

class KaiwuSorterMenu extends StatefulWidget {
  final List<String> typeList;
  final List<String> saleList;
  const KaiwuSorterMenu({
    Key? key,
    required this.typeList,
    required this.saleList
  }) : super(key: key);

  @override
  State<KaiwuSorterMenu> createState() => _KaiwuSorterMenuState();
}

class _KaiwuSorterMenuState extends State<KaiwuSorterMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row( // Row of artwork types, multi-selectable
          children: [
            
          ],
        ),
        Row( // Row of sale status, single-select
          children: [

          ],
        )
      ],
    );
  }
}


class KaiwuSorterMulti extends StatefulWidget {
  final List<String> tags;
  final ValueChanged<List> onSelect;
  final double height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const KaiwuSorterMulti({
    Key? key,
    required this.tags,
    required this.onSelect,
    this.height = 45,
    this.margin = const EdgeInsets.symmetric(horizontal: 12),
    this.padding = const EdgeInsets.symmetric(horizontal: 12)
  }) : super(key: key);

  @override
  State<KaiwuSorterMulti> createState() => _KaiwuSorterMultiState();
}

class _KaiwuSorterMultiState extends State<KaiwuSorterMulti> {
  List<int> _selectedList = [];
  final List<bool> _selectStatus = [];
  List<KaiwuSorterItem> tagList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectStatus.add(true);
    for (int index = 0; index < widget.tags.length; index++) {
      _selectStatus.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    tagList = [];
    tagList.add(
        KaiwuSorterItem(
            tag: "全部",
            index: 0,
            selected: _selectStatus[0],
            height: widget.height,
            margin: widget.margin,
            padding: widget.padding,
            onSelect: (selected) {
              if (_selectedList.isNotEmpty && selected["selected"]) {
                for (int index in _selectedList) {
                  _selectStatus[index] = false;
                }
                _selectedList = [];
                _selectStatus[0] = true;
              }
              widget.onSelect(_selectedList);
              setState(() {
                print(_selectedList);
              });
            }
        )
    );
    int count = 0;
    for (String tag in widget.tags) {
      count += 1;
      tagList.add(KaiwuSorterItem(
          tag: tag,
          index: count,
          selected: _selectStatus[count],
          height: widget.height,
          margin: widget.margin,
          padding: widget.padding,
          onSelect: (item) {
            if (item["selected"]) {
              _selectedList.add(item["index"]);
              _selectStatus[0] = false;
              _selectStatus[item["index"]] = true;
            } else {
              _selectedList.remove(count);
              if (tagList.isEmpty) {
                _selectStatus[0] = true;
              }
              _selectStatus[item["index"]] = false;
            }
            widget.onSelect(_selectedList);
            setState(() {
              print(item["index"].toString()+"#"+_selectedList.toString());
            });
          }
      ));
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: tagList,
      ),
    );
  }
}

class KaiwuSorterRadio extends StatefulWidget {
  const KaiwuSorterRadio({Key? key}) : super(key: key);

  @override
  State<KaiwuSorterRadio> createState() => _KaiwuSorterRadioState();
}

class _KaiwuSorterRadioState extends State<KaiwuSorterRadio> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



class KaiwuSorterItem extends StatefulWidget {
  final String tag;
  final int index;
  final double height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final bool selected;
  final Color textColor;
  final Color activeTextColor;
  final Color activeItemColor;
  final ValueChanged<Map> onSelect;


  const KaiwuSorterItem({
    Key? key,
    required this.tag,
    required this.index,
    this.height = 45,
    this.margin = const EdgeInsets.symmetric(horizontal: 12),
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.selected = false,
    this.textColor = const Color(0xFF9E9E9E),
    this.activeTextColor = const Color(0xFF1D1D1D),
    this.activeItemColor = const Color(0xFF7BEEEB),
    required this.onSelect,
  }) : super(key: key);

  @override
  State<KaiwuSorterItem> createState() => _KaiwuSorterItemState();
}

class _KaiwuSorterItemState extends State<KaiwuSorterItem> {
  late Color _textColor;
  late Color _itemColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }

  @override
  void didUpdateWidget(covariant KaiwuSorterItem oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    update();
  }

  void update() {
    if (widget.selected) {
      _textColor = widget.activeTextColor;
      _itemColor = widget.activeItemColor;
    } else {
      _textColor = widget.textColor;
      _itemColor = Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Map selectedItem = {"selected": !widget.selected, "index": widget.index};
        widget.onSelect(selectedItem);
        print(widget.index);
      },
      child: Container(
        height: widget.height,
        margin: widget.margin,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: _itemColor,
          borderRadius: BorderRadius.all(Radius.circular(2.5))
        ),
        child: Text(widget.tag, style: TextStyle(color: _textColor), textAlign: TextAlign.center),
        alignment: Alignment(0,0),
      ),
    );
  }
}
