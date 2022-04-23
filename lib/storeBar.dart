// ignore_for_file: avoid_print, prefer_const_constructors, prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        backgroundColor: const Color(0xFF1d1d1d),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Color(0xFFFFFFFF)),
          bodyText2: TextStyle(color: Color(0xFFFFFFFF)),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _display = true;
  bool _filter = false;
  bool _sorter = false;

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
      body: GestureDetector(
        onTap: () {
          print("###TAP###");
          FocusScope.of(context).unfocus();
          setState(() {});
        },
        child: Container(
            color: Color(0xFF1d1d1d),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                KaiwuBar(
                    display: _display,
                    filter: _filter,
                    sorter: _sorter,
                    onSwitch: (display) {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _filter = false;
                        _sorter = false;
                        _display = display;
                      });
                    },
                    onTapFilter: () {
                      setState(() {
                        _filter = !_filter;
                        _sorter = false;
                      });
                    },
                    onTapSorter: () {
                      setState(() {
                        _sorter = !_sorter;
                        _filter = false;
                      });
                    }
                ),
              ],
            )
        ),
      ),
    );
  }
}

class KaiwuBarTest extends StatefulWidget {
  const KaiwuBarTest({Key? key}) : super(key: key);

  @override
  State<KaiwuBarTest> createState() => _KaiwuBarTestState();
}

class _KaiwuBarTestState extends State<KaiwuBarTest> {
  bool filter = false;
  bool sorter = false;
  bool _switchDisplay = true;
  List<Widget> set = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filter = false;
    sorter = false;
  }

  @override
  void didUpdateWidget(covariant KaiwuBarTest oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {
      filter = false;
      sorter = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    set = [];
    set.add(KaiwuBarRow(
      switchDisplay: _switchDisplay,
      onSearch: (input) => {print("submit $input")},
      onTapFilter: () {
        setState(() {
          filter = !filter;
          sorter = false;
        });
      },
      onTapSorter: () {
        setState(() {
          sorter = !sorter;
          filter = false;
        });
      },
    ));
    if (filter) {
      set.add(KaiwuFilterMenu(
        typeList: const ["手办", "雕像", "3D插画"],
        saleList: const ["已售罄", "热销中"],
        onFiltType: (types) => {print(types)},
        onFiltSale: (sales) => {print(sales)},
      ));
    }
    if (sorter) {
      if (_switchDisplay) {
        set.add(KaiwuSorterMenu(
          tagList: const ["综合","最受欢迎","最新发布","最高热度"],
          onSort: (order) => {print(order)},
        ));
      } else {
        set.add(KaiwuSorterMenu(
          tagList: const ["综合","最新发布","最高热度"],
          onSort: (order) => {print(order)},
        ));
      }
    }
    return Container(
      decoration: const BoxDecoration(color: Color(0xDD1d1d1d)),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          KaiwuSwitch(
              switchDisplay: _switchDisplay,
              onSwitch: (switchDisplay) {
                FocusScope.of(context).unfocus();
                setState(() {
                  filter = false;
                  sorter = false;
                  _switchDisplay = switchDisplay;
                });
              }
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 36.r),
            child: Column(
              children: set,
            ),
          ),
        ],
      ),
    );
  }
}

class KaiwuBar extends StatelessWidget {
  final bool display;
  final bool filter;
  final bool sorter;
  final ValueChanged<bool> onSwitch;
  final VoidCallback onTapFilter;
  final VoidCallback onTapSorter;

  const KaiwuBar({
    Key? key,
    this.display = true,
    this.filter = false,
    this.sorter = false,
    required this.onSwitch,
    required this.onTapFilter,
    required this.onTapSorter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 36.r),
      decoration: const BoxDecoration(color: Color(0xDD1d1d1d)),
      child: Column(
        children: [
          KaiwuSwitch(
              switchDisplay: display,
              onSwitch: onSwitch
          ),
          KaiwuBarRow(
              switchDisplay: display,
              onSearch: (input) => print(input),
              onTapFilter: onTapFilter,
              onTapSorter: onTapSorter
          ),
          KaiwuMenu(
              switchDisplay: display,
              filter: filter,
              sorter: sorter,
              onFiltType: (types) => print(types),
              onFiltSale: (sales) => print(sales),
              onSort: (order) => print(order)
          ),
        ],
      ),
    );
  }
}

class KaiwuMenu extends StatelessWidget {
  final bool filter;
  final bool sorter;
  final bool switchDisplay;
  final ValueChanged<List> onFiltType;
  final ValueChanged<int> onFiltSale;
  final ValueChanged<int> onSort;
  const KaiwuMenu({
    Key? key,
    this.filter = false,
    this.sorter = false,
    required this.switchDisplay,
    required this.onFiltType,
    required this.onFiltSale,
    required this.onSort
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> set = [];
    if (filter) {
      set.add(KaiwuFilterMenu(
        typeList: const ["手办", "雕像", "3D插画"],
        saleList: const ["已售罄", "热销中"],
        onFiltType: onFiltType,
        onFiltSale: onFiltSale,
      ));
    }
    if (sorter) {
      if (switchDisplay) {
        set.add(KaiwuSorterMenu(
          tagList: const ["综合","最受欢迎","最新发布","最高热度"],
          onSort: onSort,
        ));
      } else {
        set.add(KaiwuSorterMenu(
          tagList: const ["综合","最新发布","最高热度"],
          onSort: onSort,
        ));
      }
    }
    return Column(
      children: set,
    );
  }
}


// Sub-Widgets used for Bar & Menus
class KaiwuSearchBar extends StatefulWidget {
  final ValueChanged<String> search;
  final double width;
  const KaiwuSearchBar({
    Key? key,
    required this.search,
    required this.width
  }) : super(key: key);

  @override
  State<KaiwuSearchBar> createState() => _KaiwuSearchBarState();
}

class _KaiwuSearchBarState extends State<KaiwuSearchBar> {
  late FocusNode focus;

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
    return Container(
      height: 72.r,
      width: widget.width.r,
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 30.r, color: const Color(0xFFFFFFFF)),
        decoration: InputDecoration(
            hintText: "搜索 开物艺术品",
            hintStyle: TextStyle(fontSize: 27.r, color: const Color(0xFF9E9E9E)),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF9E9E9E)),
            focusColor: const Color(0xFF7BEEEB),
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF616161)),
                borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF616161)),
                borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF7BEEEB)),
                borderRadius: BorderRadius.horizontal(left: Radius.circular(100), right: Radius.circular(100))
            )
        ),
        focusNode: focus,
        onSubmitted: widget.search,
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
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.r),
      child: Column(
        children: [
          KaiwuFilterMulti(
              tags: widget.typeList,
              onSelect: (type) => { widget.onFiltType(type) },
              selected: widget.typeSelected,
              height: 48.r,
              margin: EdgeInsets.all(12.r),
              padding: EdgeInsets.symmetric(horizontal: 12.r)
          ),
          KaiwuFilterRadio(
              tags: widget.saleList,
              onSelect: (sale) => { widget.onFiltSale(sale) },
              selected: widget.saleSelected,
              height: 48.r,
              specific: true,
              margin: EdgeInsets.all(12.r),
              padding: EdgeInsets.symmetric(horizontal: 12.r)
          )
        ],
      ),
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
  /// !!! Set specific as true when /sort api didn't change, all and selling will be reverse when sending request
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
  /// 0: Selling
  /// 1: Sold
  /// 2: All
  /// 3: Pre-sale
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
            borderRadius: const BorderRadius.all(Radius.circular(2.5))
        ),
        child: Text(widget.tag, style: TextStyle(color: _textColor, fontSize: 27.r), textAlign: TextAlign.center),
        alignment: const Alignment(0,0),
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
              fontSize: 27.r
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
      padding: EdgeInsets.symmetric(vertical: 12.r),
      child: Column(
        children: _tagList,
      ),
    );
  }
}


// Stateless Sorter Item usd in Sorter Menu
class KaiwuSorterItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(index);
      },
      child: Container(
        height: 48.r,
        margin: EdgeInsets.all(12.r),
        decoration: decoration,
        child: Text(tag, style: textStyle),
      ),
    );
  }
}

// Stateless Bar Button used in Bar Row as sorter & filter button
class KaiwuBarButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const KaiwuBarButton({
    Key? key,
    required this.icon,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: onPressed,
      child: Image.asset(icon, width: 48.r, height: 48.r),
      constraints: BoxConstraints(
          minHeight: 48.r,
          minWidth: 48.r
      ),
    );
  }
}

// Stateless Switch
class KaiwuSwitch extends StatelessWidget {
  final bool switchDisplay; // true::single | false::series
  final ValueChanged<bool> onSwitch;

  const KaiwuSwitch({
    Key? key,
    required this.switchDisplay,
    required this.onSwitch
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle enabledStyle = TextStyle(fontSize: 32.r, color: Color(0xFFFFFFFF));
    final TextStyle disabledStyle = TextStyle(fontSize: 30.r, color: Color(0xFF9E9E9E));
    return Container(
      margin: EdgeInsets.all(12.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              onSwitch(true);
            },
            child: Text("艺术单品", style: switchDisplay ? enabledStyle : disabledStyle),
          ),
          Container(
            color: Color(0xFF7BEEEB),
            margin: EdgeInsets.symmetric(horizontal: 24.r),
            height: 30.r,
            width: 1.r,
          ),
          RawMaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              onSwitch(false);
            },
            child: Text("系列作品", style: switchDisplay ? disabledStyle : enabledStyle),
          ),
        ],
      ),
    );
  }
}

// Stateless Bar Row include search bar & buttons
class KaiwuBarRow extends StatelessWidget {
  final ValueChanged<String> onSearch;
  final VoidCallback onTapFilter;
  final VoidCallback onTapSorter;
  final bool switchDisplay;

  const KaiwuBarRow({
    Key? key,
    required this.onSearch,
    required this.onTapFilter,
    required this.onTapSorter,
    this.switchDisplay = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> options = [];
    if (switchDisplay) {
      options.add(KaiwuBarButton( //Filter
          icon: "asset/icons/icon_filter.png",
          onPressed: onTapFilter
      ));
    }
    options.add(SizedBox(width: 24.r));
    options.add(KaiwuBarButton( //Sorter
        icon: "asset/icons/icon_sorter.png",
        onPressed: onTapSorter
    ));
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.r, horizontal: 9.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KaiwuSearchBar(
              search: onSearch,
              width: switchDisplay ? 520 : 560
          ),
          Row(
              mainAxisSize: MainAxisSize.min,
              children: options
          )
        ],
      ),
    );
  }
}
