// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, avoid_print, no_logic_in_create_state, import_of_legacy_library_into_null_safe, slash_for_doc_comments


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
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
        child: KaiwuStoreBar(),
      ),
    );
  }
}

class KaiwuStoreBar extends StatefulWidget {
  const KaiwuStoreBar({Key? key}) : super(key: key);

  @override
  State<KaiwuStoreBar> createState() => _KaiwuStoreBarState();
}

class _KaiwuStoreBarState extends State<KaiwuStoreBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xDD1d1d1d)),
      child: Column(
        children: [
          KaiwuSearchBar(),
          KaiwuFilterMenu(
            typeList: ["手办", "雕像", "3D插画"],
            saleList: ["已售罄", "热销中"],
            onFiltType: (types) => {print(types)},
            onFiltSale: (sales) => {print(sales)},
          ),
          KaiwuSorterMenu(
            tagList: ["综合","最受欢迎","最新发售","最高热度"],
            onSort: (order) => {print(order)},
          )
        ],
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

class KaiwuFilterMenu extends StatefulWidget {
  final List<String> typeList;
  final List<String> saleList;
  final ValueChanged<List> onFiltType;
  final ValueChanged<int> onFiltSale;
  final List<int> typeSelected;
  final int saleSelected;
  const KaiwuFilterMenu({
    Key? key,
    required this.typeList,
    required this.saleList,
    required this.onFiltType,
    required this.onFiltSale,
    this.typeSelected = const [],
    this.saleSelected = 2
  }) : super(key: key);

  @override
  State<KaiwuFilterMenu> createState() => _KaiwuFilterMenuState();
}

class _KaiwuFilterMenuState extends State<KaiwuFilterMenu> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KaiwuFilterMulti(
          tags: widget.typeList,
          onSelect: (type) => { widget.onFiltType(type) },
          selected: widget.typeSelected,
          height: 48.w,
          margin: EdgeInsets.all(12.w),
          padding: EdgeInsets.symmetric(horizontal: 12.w)
        ),
        KaiwuFilterRadio(
          tags: widget.saleList,
          onSelect: (sale) => { widget.onFiltSale(sale) },
          selected: widget.saleSelected,
          height: 48.w,
          specific: true,
          margin: EdgeInsets.all(12.w),
          padding: EdgeInsets.symmetric(horizontal: 12.w)
        )
      ],
    );
  }
}

class KaiwuFilterMulti extends StatefulWidget {
  final List<String> tags;
  final List<int> selected;
  final ValueChanged<List> onSelect;
  final double height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const KaiwuFilterMulti({
    Key? key,
    required this.tags,
    required this.onSelect,
    this.selected = const [],
    this.height = 45,
    this.margin = const EdgeInsets.symmetric(horizontal: 12),
    this.padding = const EdgeInsets.symmetric(horizontal: 12)
  }) : super(key: key);

  @override
  State<KaiwuFilterMulti> createState() => _KaiwuFilterMultiState();
}

class _KaiwuFilterMultiState extends State<KaiwuFilterMulti> {
  List<int> _selectedList = [];
  final List<bool> _selectStatus = [];
  List<KaiwuFilterItem> _tagList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedList.addAll(widget.selected);
    _selectStatus.add(widget.selected.isEmpty ? true : false);
    for (int index = 1; index <= widget.tags.length; index++) {
      _selectStatus.add(widget.selected.contains(index) ? true : false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _tagList = [];
    _tagList.add(
      KaiwuFilterItem(
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
            print("0#$_selectStatus");
          });
        }
      )
    );
    int index = 0;
    for (String tag in widget.tags) {
      index += 1;
      _tagList.add(KaiwuFilterItem(
        tag: tag,
        index: index,
        selected: _selectStatus[index],
        height: widget.height,
        margin: widget.margin,
        padding: widget.padding,
        onSelect: (item) {
          if (item["selected"]) {
            _selectedList.add(item["index"]);
            _selectStatus[0] = false;
            _selectStatus[item["index"]] = true;
          } else {
            _selectedList.remove(item["index"]);
            if (_selectedList.isEmpty) {
              _selectStatus[0] = true;
            }
            _selectStatus[item["index"]] = false;
          }
          widget.onSelect(_selectedList);
          setState(() {
            print(item["index"].toString()+"#"+_selectStatus.toString());
          });
        }
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _tagList,
    );
  }
}

class KaiwuFilterRadio extends StatefulWidget {
  /**
   * !!! Set specific as true when /sort api didn't change, all and selling will be reverse when sending request
   */
  final List<String> tags;
  final int selected;
  final ValueChanged<int> onSelect;
  final double height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final bool specific;
  const KaiwuFilterRadio({
    Key? key,
    required this.tags,
    required this.onSelect,
    this.selected = 2,
    this.height = 45,
    this.margin = const EdgeInsets.symmetric(horizontal: 12),
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.specific = false
  }) : super(key: key);

  @override
  State<KaiwuFilterRadio> createState() => _KaiwuFilterRadioState();
}

class _KaiwuFilterRadioState extends State<KaiwuFilterRadio> {
  int _selected = 2;
  /**
   * 0: Selling
   * 1: Sold
   * 2: All
   * 3: Pre-sale
   */
  final List<bool> _selectStatus = [];
  final List<int> _selectEnum = [2, 1, 0, 3];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selected = widget.selected;
    if (widget.specific) {
      _selectStatus.add(widget.selected == 2 ? true : false);
      for (int index = 1; index <= widget.tags.length; index++) {
        _selectStatus.add(widget.selected == _selectEnum[index] ? true : false);
      }
    } else {
      _selectStatus.add(widget.selected == 0 ? true : false);
      for (int index = 1; index <= widget.tags.length; index++) {
        _selectStatus.add(widget.selected == index ? true : false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    List<KaiwuFilterItem> _tagList = [];
    _tagList.add(
      KaiwuFilterItem(
        tag: "全部",
        index: widget.specific ? 2 : 0,
        selected: _selectStatus[0],
        height: widget.height,
        margin: widget.margin,
        padding: widget.padding,
        onSelect: (selectMap) {
          if (widget.specific) {
            _selectStatus[_selectEnum.indexOf(_selected)] = false;
          } else {
            _selectStatus[_selected] = false;
          }
          _selected = widget.specific ? _selectEnum[0] : 0;
          _selectStatus[0] = true;
          widget.onSelect(_selected);
          setState(() {
            print("0#$_selectStatus");
          });
        },
      )
    );
    int count = 0;
    for (String tag in widget.tags) {
      count += 1;
      _tagList.add(KaiwuFilterItem(
        tag: tag,
        index: count,
        selected: _selectStatus[count],
        height: widget.height,
        margin: widget.margin,
        padding: widget.padding,
        onSelect: (selectMap) {
          for (int index = 0; index < _selectStatus.length; index++) {
            _selectStatus[index] = false;
          }
          _selected = widget.specific ? _selectEnum[selectMap["index"]] : selectMap["index"];
          _selectStatus[selectMap["index"]] = true;
          widget.onSelect(_selected);
          setState(() {
            print("${selectMap["index"]}#$_selectStatus");
          });
        }
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _tagList,
    );
  }
}

class KaiwuFilterItem extends StatefulWidget {
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


  const KaiwuFilterItem({
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
  State<KaiwuFilterItem> createState() => _KaiwuFilterItemState();
}

class _KaiwuFilterItemState extends State<KaiwuFilterItem> {
  late Color _textColor;
  late Color _itemColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }

  @override
  void didUpdateWidget(covariant KaiwuFilterItem oldWidget) {
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

class KaiwuSorterMenu extends StatefulWidget {
  final List<String> tagList;
  final int selected;
  final Color textColor;
  final Color selectColor;
  final ValueChanged<int> onSort;
  const KaiwuSorterMenu({
    Key? key,
    required this.tagList,
    this.selected = 1,
    this.textColor = const Color(0xFFFFFFFF),
    this.selectColor = const Color(0xFF7BEEEB),
    required this.onSort
  }) : super(key: key);

  @override
  State<KaiwuSorterMenu> createState() => _KaiwuSorterMenuState();
}

class _KaiwuSorterMenuState extends State<KaiwuSorterMenu> {
  int _selected = 1;
  final List<bool> _selectStatus = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selected = widget.selected;
    for (int index = 1; index <= widget.tagList.length; index++) {
      _selectStatus.add(widget.selected == index ? true : false);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<KaiwuSorterItem> _tagList = [];
    int count = 0;
    for (String tag in widget.tagList) {
      count += 1;
      _tagList.add(KaiwuSorterItem(
        tag: tag,
        index: count,
        // _selectStatus[index] ? TextStyle(color: widget.selectColor) : TextStyle(color: widget.textColor),
        textStyle: TextStyle(
          color: _selectStatus[count - 1] ? widget.selectColor : widget.textColor,
          fontSize: 27.w
        ),
        onSelect: (index) {
          _selected = index;
          _selectStatus.fillRange(0, _selectStatus.length, false);
          _selectStatus[index - 1] = true;
          setState(() {
            print("$_selected#$_selectStatus");
          });
          widget.onSort(_selected);
        }
      ));
    }
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: _tagList,
      ),
    );
  }
}

class KaiwuSorterItem extends StatefulWidget {
  final String tag;
  final int index;
  final ValueChanged<int> onSelect;
  final TextStyle textStyle;
  final BoxDecoration decoration;

  const KaiwuSorterItem({
    Key? key,
    required this.tag,
    required this.index,
    required this.onSelect,
    this.textStyle = const TextStyle(color: Color(0xFFFFFFFF)),
    this.decoration = const BoxDecoration()
  }) : super(key: key);

  @override
  State<KaiwuSorterItem> createState() => _KaiwuSorterItemState();
}

class _KaiwuSorterItemState extends State<KaiwuSorterItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect(widget.index);
      },
      child: Container(
        height: 48.w,
        margin: EdgeInsets.all(12.w),
        decoration: widget.decoration,
        child: Text(widget.tag, style: widget.textStyle),
      ),
    );
  }
}

class KaiwuFilterButton extends StatefulWidget {
  const KaiwuFilterButton({Key? key}) : super(key: key);

  @override
  State<KaiwuFilterButton> createState() => _KaiwuFilterButtonState();
}

class _KaiwuFilterButtonState extends State<KaiwuFilterButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class KaiwuSorterButton extends StatefulWidget {
  const KaiwuSorterButton({Key? key}) : super(key: key);

  @override
  State<KaiwuSorterButton> createState() => _KaiwuSorterButtonState();
}

class _KaiwuSorterButtonState extends State<KaiwuSorterButton> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => {},

    );
  }
}

class KaiwuBarButton extends StatelessWidget {
  final VoidCallback onPressed;
  const KaiwuBarButton({
    Key? key,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
