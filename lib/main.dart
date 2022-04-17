// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, avoid_print, no_logic_in_create_state, import_of_legacy_library_into_null_safe


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
        child: SingleDetail(),
      ),
    );
  }
}

class SingleDetail extends StatefulWidget {

  const SingleDetail({
    Key? key
  }) : super(key: key);

  @override
  State<SingleDetail> createState() => _SingleDetailState();
}

class _SingleDetailState extends State<SingleDetail> {
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
            SinglePanel()
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
  final Icon collectButtonTrue = Icon(CupertinoIcons.star_fill, color: Color(0xFF7BEEEB), size: 45.w,);
  final Icon collectButtonFalse = Icon(CupertinoIcons.star, color: Color(0xFFFFFFFF), size: 45.w,);
  final Icon likeButtonTrue = Icon(CupertinoIcons.heart_fill, color: Color(0xFF7BEEEB), size: 45.w,);
  final Icon likeButtonFalse = Icon(CupertinoIcons.heart, color: Color(0xFFFFFFFF), size: 45.w,);


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
    button = widget.state ? trueIcon : falseIcon;
  }

  @override
  void didUpdateWidget(covariant SingleCountButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      if (widget.state) {
        count++;
        button = trueIcon;
      } else {
        count--;
        button = falseIcon;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.w,
      width: 72.w,
      child: TextButton(
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
        onPressed: () {
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
      margin: EdgeInsets.only(top: 900.w, left: 15.w, right: 15.w),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Color(0xFF353535)),
          borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
          color: Color(0x991d1d1d)
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SingleInfo(),
        ),
      ),
    );
  }
}

class SingleInfo extends StatefulWidget {

  const SingleInfo({Key? key}) : super(key: key);

  @override
  State<SingleInfo> createState() => _SingleInfoState();
}

class _SingleInfoState extends State<SingleInfo> {

  //TODO: REMOVE TEST STRING
  final String intro = "常年混迹于桃花源普通鸡蛋中，外壳隐约透出桃粉色，乡人视其为天降吉星。不同于普通宠物，“赤子”幼崽破壳后只与人亲近数月，之后遁入桃林，不复归家。犹如少年离开家园去闯荡天地，因此得名。";
  final displayUrl = [
    "https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/a1.png",
    "https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/a2.png",
    "https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/a3.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(36.w),
      child: Column(
        children: [
          SingleInfoMain(artworkName: "赤子", price: 598),
          SingleHorizontalLine(),
          SingleInfoIntro(introduction: intro),
          SingleHorizontalLine(),
          SingleInfoNumber(artworkNumber: "KW00101", soldAmount: 2, totalAmount: 9),
          SingleHorizontalLine(),
          SingleInfoArtist(),
          SingleHorizontalLine(),
          SingleInfoDisplay(imageUrl: displayUrl),
          SingleInfoList(),
          Text(
            "数字藏品为虚拟数字商品，而非实物，仅限实名认证中国大陆用户购买。数字藏品的版权由发行方或原创者拥有，除另行取得版权拥有者书面同意外，用户不得将数字藏品用于任何商业用途。本商品一经售出，不支持退换。请勿对数字藏品进行炒作、场外交易、欺诈，或以任何其他非法方式进行使用。",
            style: TextStyle(fontSize: 21.w, color: Color(0xFF616161)),
          ),
          //Bottom=============================
          SizedBox(height: 180.w, width: 720.w)
        ],
      ),
    );
  }
}

class SingleHorizontalLine extends StatelessWidget {
  const SingleHorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: Color(0xFF353535),
      margin: EdgeInsets.symmetric(vertical: 36.w),
    );
  }
}

class SingleInfoMain extends StatelessWidget {
  final String artworkName;
  final int price;

  const SingleInfoMain({
    Key? key,
    this.artworkName = "UNKNOWN",
    this.price = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 8.w),
              Text(artworkName, style: TextStyle(fontSize: 40.w, height: 1.2))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: "￥", style: TextStyle(fontSize: 32.w)),
                        TextSpan(text: price.toString(), style: TextStyle(fontSize: 40.w, fontWeight: FontWeight.bold))
                      ]
                  )
              ),
              SingleButtonSet(likeState: true, collectState: false, likeCount: 999, collectCount: 666)
            ],
          )
        ],
      ),
    );
  }
}

class SingleInfoIntro extends StatelessWidget {
  final String introduction;

  const SingleInfoIntro({
    Key? key,
    this.introduction = ""
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      child: Text(introduction, style: TextStyle(fontSize: 24.w)),
    );
  }
}

class SingleInfoNumber extends StatelessWidget {
  final String artworkNumber;
  final int soldAmount;
  final int totalAmount;

  const SingleInfoNumber({
    Key? key,
    this.artworkNumber = "",
    this.soldAmount = 0,
    this.totalAmount = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int avlAmount = totalAmount - soldAmount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 288.w,
          child: Column(
            children: [
              Text("作品数量", style: TextStyle(fontSize: 21.w, color: Color(0xFF616161))),
              Text(avlAmount.toString()+"/"+totalAmount.toString(), style: TextStyle(fontSize: 32.w))
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 36.w),
            width: 1,
            height: 96.w,
            color: Color(0xFF353535)),
        SizedBox(
          width: 280.w,
          child: Column(
            children: [
              Text("作品编号", style: TextStyle(fontSize: 21.w, color: Color(0xFF616161))),
              Text(artworkNumber, style: TextStyle(fontSize: 32.w))
            ],
          ),
        )
      ],
    );
  }
}

class SingleInfoArtist extends StatelessWidget {
  final String artistAvatar;
  final String seriesCover;
  final String artist;
  final String series;

  const SingleInfoArtist({
    Key? key,
    this.artistAvatar = "https://test-1308399957.cos.ap-shanghai.myqcloud.com/test_image/test2.png",
    this.seriesCover = "https://kaiwu-1308399957.cos.ap-nanjing.myqcloud.com/series/KW001/cover.jpg",
    this.artist = "",
    this.series = ""
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 36.w),
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xFF353535))
                ),
                child: Image.network(artistAvatar, fit: BoxFit.cover),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("艺术家", style: TextStyle(fontSize: 21.w, color: Color(0xFF616161))),
                  Text("JICHU", style: TextStyle(fontSize: 27.w))
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("所属系列", style: TextStyle(fontSize: 21.w, color: Color(0xFF616161)), textDirection: TextDirection.rtl),
                  Text("桃花源", style: TextStyle(fontSize: 27.w), textDirection: TextDirection.rtl)
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 36.w),
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xFF353535))
                ),
                child: Image.network(seriesCover, fit: BoxFit.cover),
              )
            ],
          )
        ],
      ),
    );
  }
}

/**
 * Container(
    margin: EdgeInsets.only(right: 36.w),
    width: 64.w,
    height: 64.w,
    decoration: BoxDecoration(
    border: Border.all(width: 1, color: Color(0xFF353535))
    ),
    child: Image.network(artistAvatar, fit: BoxFit.cover),
    ),
    Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("艺术家", style: TextStyle(fontSize: 24.w)),
    Text("所属系列", style: TextStyle(fontSize: 24.w))
    ],
    ),
    SizedBox(width: 36.w),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("JICHU", style: TextStyle(fontSize: 24.w)),
    Text("桃花源", style: TextStyle(fontSize: 24.w))
    ],
    ),
 */

class SingleInfoDisplay extends StatelessWidget {
  final List<String> imageUrl;

  const SingleInfoDisplay({
    Key? key,
    required this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> displayImages = [
      Text("艺术品展示", style: TextStyle(fontSize: 32.w, fontWeight: FontWeight.bold)),
      SizedBox(height: 24.w)
    ];
    for (String url in imageUrl) {
      displayImages.add(Image.network(url, width: 630.w, fit: BoxFit.fitWidth));
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 9.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: displayImages,
      ),
    );
  }
}

class SingleInfoList extends StatelessWidget {
  const SingleInfoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 36.w, left: 9.w),
          child: Text("艺术品信息", style: TextStyle(fontSize: 32.w, fontWeight: FontWeight.bold)),
        ),
        SingleListDivide(),
        SingleListItem(listKey: "艺术品名称", listValue: "赤子"),
        SingleListItem(listKey: "所属系列", listValue: "桃花源"),
        SingleListItem(listKey: "艺术家", listValue: "季初"),
        SingleListItem(listKey: "品牌方", listValue: "开物"),
        SingleListItem(listKey: "发行方", listValue: "开物"),
        SingleListItem(listKey: "发行时间", listValue: "2022/03/08"),
        SingleListItem(listKey: "确权链", listValue: "至信链"),
        SingleListItem(listKey: "作品哈希", listValue: "fc19dc74a022690"),
        SingleListItem(listKey: "作品编号", listValue: "KW00101"),
      ],
    );
  }
}

class SingleListItem extends StatelessWidget {
  final String listKey;
  final String listValue;

  const SingleListItem({
    Key? key,
    required this.listKey,
    required this.listValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 9.w),
              width: 180.w,
              child: Text(listKey, style: TextStyle(fontSize: 24.w)),
            ),
            Container(
              margin: EdgeInsets.only(right: 20.w),
              width: 1,
              height: 32.w,
              color: Color(0xFF353535)
            ),
            Text(listValue, style: TextStyle(fontSize: 24.w))
          ],
        ),
        SingleListDivide()
      ],
    );
  }
}


class SingleListDivide extends StatelessWidget {
  const SingleListDivide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.w),
      height: 1,
      color: Color(0xFF353535),
    );
  }
}








