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
            horizontal: 27.r
        ),
        child: homeContent(),
      ),
    );
  }
}

class homeContent extends StatelessWidget {
  const homeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.56,
          mainAxisSpacing: 24.r,
          crossAxisSpacing: 24.r
      ),
      children: <Widget>[
        homeItem("https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/s1.png",
            name: "赤子", number: "KW00101", price: 499, avlAmount: 1, totalAmount: 9),
        homeItem("https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/s1.png",
            name: "赤子", number: "KW00101", price: 499, avlAmount: 1, totalAmount: 9),
        homeItem("https://test-1308399957.cos.ap-shanghai.myqcloud.com/images/KW00101000/s1.png",
            name: "赤子", number: "KW00101", price: 499, avlAmount: 1, totalAmount: 9),
      ],
    );
  }
}

class homeItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String number;
  final int price;
  final int avlAmount;
  final int totalAmount;

  const homeItem(
      this.imageUrl,
      { Key? key,
        required this.name,
        required this.number,
        required this.price,
        required this.avlAmount,
        required this.totalAmount
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9.f),
      decoration: BoxDecoration(
          color: Color(0xFF292929),
          border: Border.all(width: 1, color: Color(0xFF353535)),
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xFF353535)),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Image.network(imageUrl),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 9.r),
            child: ItemText(name: name, number: number, price: price, avlAmount: avlAmount, totalAmount: totalAmount),
          )
        ],
      ),
    );
  }
}

class ItemText extends StatelessWidget {
  final String name;
  final String number;
  final int price;
  final int avlAmount;
  final int totalAmount;

  const ItemText({
    Key? key,
    required this.name,
    required this.number,
    required this.price,
    required this.avlAmount,
    required this.totalAmount
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 21.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, textAlign: TextAlign.left, style: TextStyle(fontSize: 27.r)),
                Text(number, textAlign: TextAlign.left, style: TextStyle(fontSize: 27.r)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Text>[
              Text("￥"+price.toString(), style: TextStyle(fontSize: 27.r, fontWeight: FontWeight.bold)),
              Text(avlAmount.toString()+"/"+totalAmount.toString(), style: TextStyle(fontSize: 27.r))
            ],
          )
        ]
    );
  }
}

