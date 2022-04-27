

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
      home: const SingleDetailPage(),
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

class SingleDetailPage extends StatelessWidget {
  const SingleDetailPage({Key? key}) : super(key: key);

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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Color(0xFF1d1d1d)),
            child: const SingleDetail(),
          ),
          const KaiwuHeaderButton()
        ],
      )
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
  final buttonLeft = Image.asset("asset/images/single_button_view.png", width: 360.r, height: 90.r);
  final buttonRight = Image.asset("asset/images/single_button_buy.png", width: 360.r, height: 90.r);



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
        KaiwuPageFooter(buttonLeft: buttonLeft, buttonRight: buttonRight)
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
  final Icon collectButtonTrue = Icon(CupertinoIcons.star_fill, color: const Color(0xFF7BEEEB), size: 45.r,);
  final Icon collectButtonFalse = Icon(CupertinoIcons.star, color: const Color(0xFFFFFFFF), size: 45.r,);
  final Icon likeButtonTrue = Icon(CupertinoIcons.heart_fill, color: const Color(0xFF7BEEEB), size: 45.r,);
  final Icon likeButtonFalse = Icon(CupertinoIcons.heart, color: const Color(0xFFFFFFFF), size: 45.r,);


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
      height: 72.r,
      width: 72.r,
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
      width: 750.r,
      height: 1000.r,
      child: Swiper(
        itemCount: swiperUrl.length,
        autoplay: true,
        autoplayDelay: 5000,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Image.network(swiperUrl[index], fit: BoxFit.fitWidth),
              Container(
                width: 750.r,
                height: 1000.r,
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
      margin: EdgeInsets.only(top: 900.r, left: 15.r, right: 15.r),
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
  final String intro = "常年混迹于桃花源普通鸡蛋中，外壳隐约透出桃粉色，乡人视其为天降吉星。"
      "不同于普通宠物，“赤子”幼崽破壳后只与人亲近数月，之后遁入桃林，不复归家。犹如少年离开家园去闯荡天地，因此得名。";
  final displayUrl = [
    "https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/a1.png",
    "https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/a2.png",
    "https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/a3.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(36.r),
      child: Column(
        children: [
          const SingleInfoMain(artworkName: "赤子", price: 598),
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
            "数字藏品为虚拟数字商品，而非实物，仅限实名认证中国大陆用户购买。"
                "数字藏品的版权由发行方或原创者拥有，除另行取得版权拥有者书面同意外，用户不得将数字藏品用于任何商业用途。"
                "本商品一经售出，不支持退换。请勿对数字藏品进行炒作、场外交易、欺诈，或以任何其他非法方式进行使用。",
            style: TextStyle(fontSize: 21.r, color: const Color(0xFF616161)),
          ),
          //Bottom=============================
          SizedBox(height: 180.r, width: 720.r)
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
      margin: EdgeInsets.symmetric(vertical: 36.r),
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
      padding: EdgeInsets.symmetric(horizontal: 9.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 8.r),
              Text(artworkName, style: TextStyle(fontSize: 40.r, height: 1.2))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: "￥", style: TextStyle(fontSize: 32.r)),
                        TextSpan(text: price.toString(), style: TextStyle(fontSize: 40.r, fontWeight: FontWeight.bold))
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
      padding: EdgeInsets.symmetric(horizontal: 9.r),
      child: Text(introduction, style: TextStyle(fontSize: 24.r)),
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
          width: 288.r,
          child: Column(
            children: [
              Text("作品数量", style: TextStyle(fontSize: 21.r, color: const Color(0xFF9E9E9E))),
              Text(avlAmount.toString()+"/"+totalAmount.toString(), style: TextStyle(fontSize: 32.r))
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 36.r),
            width: 1,
            height: 96.r,
            color: const Color(0xFF353535)),
        SizedBox(
          width: 280.r,
          child: Column(
            children: [
              Text("作品编号", style: TextStyle(fontSize: 21.r, color: const Color(0xFF9E9E9E))),
              Text(artworkNumber, style: TextStyle(fontSize: 32.r))
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
      padding: EdgeInsets.symmetric(horizontal: 9.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 36.r),
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: const Color(0xFF353535))
                ),
                child: Image.network(artistAvatar, fit: BoxFit.cover),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("艺术家", style: TextStyle(fontSize: 21.r, color: const Color(0xFF9E9E9E))),
                  Text("JICHU", style: TextStyle(fontSize: 27.r))
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
                  Text("所属系列", style: TextStyle(fontSize: 21.r, color: const Color(0xFF9E9E9E)), textDirection: TextDirection.rtl),
                  Text("桃花源", style: TextStyle(fontSize: 27.r), textDirection: TextDirection.rtl)
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 36.r),
                width: 64.r,
                height: 64.r,
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
      Text("艺术品展示", style: TextStyle(fontSize: 32.r, fontWeight: FontWeight.bold)),
      SizedBox(height: 24.r)
    ];
    for (String url in imageUrl) {
      displayImages.add(FadeInImage.assetNetwork(
        placeholder: "asset/images/loading_image.jpg",
        image: url,
        fit: BoxFit.fitWidth),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 9.r),
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
          margin: EdgeInsets.only(top: 36.r, left: 9.r),
          child: Text("艺术品信息", style: TextStyle(fontSize: 32.r, fontWeight: FontWeight.bold)),
        ),
        const SingleListDivide(),
        const SingleListItem(listKey: "艺术品名称", listValue: "赤子"),
        const SingleListItem(listKey: "所属系列", listValue: "桃花源"),
        const SingleListItem(listKey: "艺术家", listValue: "季初"),
        const SingleListItem(listKey: "品牌方", listValue: "开物"),
        const SingleListItem(listKey: "发行方", listValue: "开物"),
        const SingleListItem(listKey: "发行时间", listValue: "2022/03/08"),
        const SingleListItem(listKey: "确权链", listValue: "至信链"),
        const SingleListItem(listKey: "作品哈希", listValue: "fc19dc74a022690"),
        const SingleListItem(listKey: "作品编号", listValue: "KW00101"),
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
              padding: EdgeInsets.only(left: 9.r),
              width: 150.r,
              child: Text(listKey, style: TextStyle(fontSize: 24.r)),
            ),
            Container(
                margin: EdgeInsets.only(right: 20.r),
                width: 1,
                height: 32.r,
                color: const Color(0xFF353535)
            ),
            Text(listValue, style: TextStyle(fontSize: 24.r))
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
      margin: EdgeInsets.symmetric(vertical: 24.r),
      height: 1,
      color: const Color(0xFF353535),
    );
  }
}


/// BELOW is the Footer Widget available for Kaiwu detail pages
class KaiwuPageFooter extends StatelessWidget {
  final Image buttonLeft;
  final Image buttonRight;

  const KaiwuPageFooter({
    Key? key,
    required this.buttonLeft,
    required this.buttonRight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        width: 750.r,
        height: 180.r,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Stack(
              children: [
                Image.asset("asset/images/single_footer.png", width: 750.r, height: 180.r),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 30.r),
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
        width: 345.r,
        height: 90.r,
        child: OverflowBox(
          maxWidth: 360.r,
          maxHeight: 90.r,
          child: button,
        ),
      ),
    );
  }
}


/// BELOW is the header Buttons
class KaiwuHeaderButton extends StatelessWidget {
  const KaiwuHeaderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.r),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.back, color: const Color(0xFFFFFFFF), size: 48.r,)
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.ellipsis_circle, color: const Color(0xFFFFFFFF), size: 48.r,)
              )
            ],
          )
        ],
      ),
    );
  }
}
