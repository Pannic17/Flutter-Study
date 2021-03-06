import 'package:flutter/material.dart';
import './main.dart';


class KaiwuBarSetTest extends StatefulWidget {
  final ValueChanged<String> onSearch;
  final VoidCallback onTapFilter;
  final VoidCallback onTapSorter;
  final bool switchDisplay;
  const KaiwuBarSetTest({
    Key? key,
    required this.onSearch,
    required this.onTapFilter,
    required this.onTapSorter,
    this.switchDisplay = true
  }) : super(key: key);

  @override
  State<KaiwuBarSetTest> createState() => _KaiwuBarSetTestState();
}

class _KaiwuBarSetTestState extends State<KaiwuBarSetTest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant KaiwuBarSetTest oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> barRow = [];
    barRow.add(KaiwuSearchBar(
      search: widget.onSearch,
      width: widget.switchDisplay ? 520 : 560,
    ));
    if (widget.switchDisplay) {
      barRow.add(KaiwuBarButton( //Filter
          icon: "asset/icons/icon_filter.png",
          onPressed: widget.onTapFilter
      ));
    }
    barRow.add(KaiwuBarButton( //Sorter
        icon: "asset/icons/icon_sorter.png",
        onPressed: widget.onTapSorter
    ));
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.w, horizontal: 9.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: barRow,
      ),
    );
  }
}


class KaiwuSwitchTest extends StatefulWidget {
  final bool switchDisplay; // true::single | false::series
  final ValueChanged<bool> onSwitch;

  const KaiwuSwitchTest({
    Key? key,
    required this.switchDisplay,
    required this.onSwitch
  }) : super(key: key);

  @override
  State<KaiwuSwitchTest> createState() => _KaiwuSwitchTestState();
}

class _KaiwuSwitchTestState extends State<KaiwuSwitchTest> {
  final TextStyle enabledStyle = TextStyle(fontSize: 32.w, color: Color(0xFFFFFFFF));
  final TextStyle disabledStyle = TextStyle(fontSize: 30.w, color: Color(0xFF9E9E9E));

  @override
  void didUpdateWidget(covariant KaiwuSwitchTest oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              widget.onSwitch(true);
            },
            child: Text("????????????", style: widget.switchDisplay ? enabledStyle : disabledStyle),
          ),
          Container(
            color: Color(0xFF7BEEEB),
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            height: 30.w,
            width: 1.w,
          ),
          RawMaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              widget.onSwitch(false);
            },
            child: Text("????????????", style: widget.switchDisplay ? disabledStyle : enabledStyle),
          ),
        ],
      ),
    );
  }
}



class KaiwuSorterItemTest extends StatefulWidget {
  final String tag;
  final int index;
  final ValueChanged<int> onSelect;
  final TextStyle textStyle;
  final BoxDecoration decoration;

  const KaiwuSorterItemTest({
    Key? key,
    required this.tag,
    required this.index,
    required this.onSelect,
    this.textStyle = const TextStyle(color: Color(0xFFFFFFFF)),
    this.decoration = const BoxDecoration()
  }) : super(key: key);

  @override
  State<KaiwuSorterItemTest> createState() => _KaiwuSorterItemTestState();
}

class _KaiwuSorterItemTestState extends State<KaiwuSorterItemTest> {
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
        typeList: const ["??????", "??????", "3D??????"],
        saleList: const ["?????????", "?????????"],
        onFiltType: (types) => {print(types)},
        onFiltSale: (sales) => {print(sales)},
      ));
    }
    if (sorter) {
      if (_switchDisplay) {
        set.add(KaiwuSorterMenu(
          tagList: const ["??????","????????????","????????????","????????????"],
          onSort: (order) => {print(order)},
        ));
      } else {
        set.add(KaiwuSorterMenu(
          tagList: const ["??????","????????????","????????????"],
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
            padding: EdgeInsets.symmetric(horizontal: 36.w),
            child: Column(
              children: set,
            ),
          ),
        ],
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
        typeList: const ["??????", "??????", "3D??????"],
        saleList: const ["?????????", "?????????"],
        onFiltType: (types) => {print(types)},
        onFiltSale: (sales) => {print(sales)},
      ));
    }
    if (sorter) {
      if (_switchDisplay) {
        set.add(KaiwuSorterMenu(
          tagList: const ["??????","????????????","????????????","????????????"],
          onSort: (order) => {print(order)},
        ));
      } else {
        set.add(KaiwuSorterMenu(
          tagList: const ["??????","????????????","????????????"],
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