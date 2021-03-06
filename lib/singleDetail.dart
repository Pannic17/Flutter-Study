

// ignore_for_file: no_logic_in_create_state

import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(const SingleApp());
}

class SingleApp extends StatelessWidget {
  const SingleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const homePage(),
      theme: ThemeData(
          backgroundColor: const Color(0xFF1d1d1d),
          textTheme: const TextTheme(
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
        decoration: const BoxDecoration(color: Color(0xFF1d1d1d)),
        child: const SingleDetail(),
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
  final buttonLeft = Image.asset("asset/images/single_button_view.png", width: 360.w, height: 90.w);
  final buttonRight = Image.asset("asset/images/single_button_buy.png", width: 360.w, height: 90.w);



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          child: Stack(
            fit: StackFit.loose,
            clipBehavior: Clip.none,
            children: [
              SingleSwiper(swiperUrl: swiperUrl),
              const SinglePanel(),
            ],
          ),
        ),
        KaiwuFooter(buttonLeft: buttonLeft, buttonRight: buttonRight)
      ],
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
  final Icon collectButtonTrue = Icon(CupertinoIcons.star_fill, color: const Color(0xFF7BEEEB), size: 45.w,);
  final Icon collectButtonFalse = Icon(CupertinoIcons.star, color: const Color(0xFFFFFFFF), size: 45.w,);
  final Icon likeButtonTrue = Icon(CupertinoIcons.heart_fill, color: const Color(0xFF7BEEEB), size: 45.w,);
  final Icon likeButtonFalse = Icon(CupertinoIcons.heart, color: const Color(0xFFFFFFFF), size: 45.w,);


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
          onLongPress: (state) {
            setState(() {
              likeState = true;
              collectState = true;
            });
          },
          onClick: (state) {
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
          onLongPress: (state) {
            setState(() {
              likeState = true;
              collectState = true;
            });
          },
          onClick: (state) {
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
  final ValueChanged<bool> onClick;
  final ValueChanged<bool> onLongPress;

  const SingleCountButton({
    Key? key,
    required this.state,
    required this.count,
    required this.trueIcon,
    required this.falseIcon,
    required this.onClick,
    required this.onLongPress,
  }) : super(key: key);

  @override
  State<SingleCountButton> createState() => _SingleCountButtonState(trueIcon: trueIcon, falseIcon: falseIcon);
}

class _SingleCountButtonState extends State<SingleCountButton> {
  int _count = 0;
  late Icon _button;
  final Icon trueIcon;
  final Icon falseIcon;

  _SingleCountButtonState({required this.trueIcon, required this.falseIcon});

  @override
  void initState() {
    super.initState();
    _count = widget.count;
    _button = widget.state ? trueIcon : falseIcon;
  }

  @override
  void didUpdateWidget(covariant SingleCountButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      if (widget.state) {
        _count++;
        _button = trueIcon;
      } else {
        _count--;
        _button = falseIcon;
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
          widget.onClick(!widget.state);
        },
        onLongPress: () {
          widget.onLongPress(true);
        },
        child: Column(
          children: [
            _button,
            Text(_count.toString(), style: TextStyle(fontSize: 21.sp, color: const Color(0xFF9E9E9E)))
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
        autoplayDelay: 5000,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Image.network(swiperUrl[index], fit: BoxFit.fitWidth),
              Container(
                width: 750.w,
                height: 1000.w,
                decoration: const BoxDecoration(
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
          border: Border.all(width: 1, color: const Color(0xFF353535)),
          borderRadius: const BorderRadius.vertical(top: const Radius.circular(5)),
          color: const Color(0x991d1d1d)
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: const SingleInfo(),
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
  final String intro = "??????????????????????????????????????????????????????????????????????????????????????????????????????"
      "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????";
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
          const SingleInfoMain(artworkName: "??????", price: 598),
          const SingleHorizontalLine(),
          const SingleInfoNumber(artworkNumber: "KW00101", soldAmount: 2, totalAmount: 9),
          const SingleHorizontalLine(),
          SingleInfoIntro(introduction: intro),
          const SingleHorizontalLine(),
          const SingleInfoCreator(),
          const SingleHorizontalLine(),
          SingleInfoDisplay(imageUrl: displayUrl),
          const SingleInfoList(),
          Text(
            "????????????????????????????????????????????????????????????????????????????????????????????????"
                "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"
                "???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????",
            style: TextStyle(fontSize: 21.w, color: const Color(0xFF616161)),
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
      color: const Color(0xFF353535),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: "???", style: TextStyle(fontSize: 32.w)),
                        TextSpan(text: price.toString(), style: TextStyle(fontSize: 40.w, fontWeight: FontWeight.bold))
                      ]
                  )
              ),
              const SingleButtonSet(likeState: true, collectState: false, likeCount: 999, collectCount: 666)
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
              Text("????????????", style: TextStyle(fontSize: 21.w, color: const Color(0xFF9E9E9E))),
              Text(avlAmount.toString()+"/"+totalAmount.toString(), style: TextStyle(fontSize: 32.w))
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 36.w),
            width: 1,
            height: 96.w,
            color: const Color(0xFF353535)),
        SizedBox(
          width: 280.w,
          child: Column(
            children: [
              Text("????????????", style: TextStyle(fontSize: 21.w, color: const Color(0xFF9E9E9E))),
              Text(artworkNumber, style: TextStyle(fontSize: 32.w))
            ],
          ),
        )
      ],
    );
  }
}

class SingleInfoCreator extends StatelessWidget {
  final String artistAvatar;
  final String seriesCover;
  final String artist;
  final String series;

  const SingleInfoCreator({
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
                    border: Border.all(width: 1, color: const Color(0xFF353535))
                ),
                child: Image.network(artistAvatar, fit: BoxFit.cover),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("?????????", style: TextStyle(fontSize: 21.w, color: const Color(0xFF9E9E9E))),
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
                  Text("????????????", style: TextStyle(fontSize: 21.w, color: const Color(0xFF9E9E9E)), textDirection: TextDirection.rtl),
                  Text("?????????", style: TextStyle(fontSize: 27.w), textDirection: TextDirection.rtl)
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 36.w),
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: const Color(0xFF353535))
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

class SingleInfoDisplay extends StatelessWidget {
  // image display division
  final List<String> imageUrl;

  const SingleInfoDisplay({
    Key? key,
    required this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> displayImages = [
      Text("???????????????", style: TextStyle(fontSize: 32.w, fontWeight: FontWeight.bold)),
      SizedBox(height: 24.w)
    ];
    for (String url in imageUrl) {
      displayImages.add(FadeInImage.assetNetwork(
        placeholder: "asset/images/loading_image.jpg",
        image: url,
        fit: BoxFit.fitWidth),
      );
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
  // info list division
  const SingleInfoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 36.w, left: 9.w),
          child: Text("???????????????", style: TextStyle(fontSize: 32.w, fontWeight: FontWeight.bold)),
        ),
        const SingleListDivide(),
        const SingleListItem(listKey: "???????????????", listValue: "??????"),
        const SingleListItem(listKey: "????????????", listValue: "?????????"),
        const SingleListItem(listKey: "?????????", listValue: "??????"),
        const SingleListItem(listKey: "?????????", listValue: "??????"),
        const SingleListItem(listKey: "?????????", listValue: "??????"),
        const SingleListItem(listKey: "????????????", listValue: "2022/03/08"),
        const SingleListItem(listKey: "?????????", listValue: "?????????"),
        const SingleListItem(listKey: "????????????", listValue: "fc19dc74a022690"),
        const SingleListItem(listKey: "????????????", listValue: "KW00101"),
      ],
    );
  }
}

class SingleListItem extends StatelessWidget {
  // List Item Widget for single detail info list, represent a line of info
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
              width: 150.w,
              child: Text(listKey, style: TextStyle(fontSize: 24.w)),
            ),
            Container(
                margin: EdgeInsets.only(right: 20.w),
                width: 1,
                height: 32.w,
                color: const Color(0xFF353535)
            ),
            Text(listValue, style: TextStyle(fontSize: 24.w))
          ],
        ),
        const SingleListDivide()
      ],
    );
  }
}

class SingleListDivide extends StatelessWidget {
  // Division Line Widget for single detail info list, used as division between two lines
  const SingleListDivide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24.w),
      height: 1,
      color: const Color(0xFF353535),
    );
  }
}


/// BELOW is the Footer Widget available for Kaiwu detail pages
class KaiwuFooter extends StatelessWidget {
  final Image buttonLeft;
  final Image buttonRight;

  const KaiwuFooter({
    Key? key,
    required this.buttonLeft,
    required this.buttonRight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: 750.w,
        height: 180.w,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Stack(
              children: [
                Image.asset("asset/images/single_footer.png", width: 750.w, height: 180.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KaiwuFooterButton(buttonLeft),
                      KaiwuFooterButton(buttonRight),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    )
    );
  }
}

class KaiwuFooterButton extends StatelessWidget {
  final Image button;

  const KaiwuFooterButton(this.button, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () => {
        print("click")
      },
      child: SizedBox(
        width: 345.w,
        height: 90.w,
        child: OverflowBox(
          maxWidth: 360.w,
          maxHeight: 90.w,
          child: button,
        ),
      ),
    );
  }
}

