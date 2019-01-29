import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_oupay/flutter_oupay.dart';

import 'package:flutter_oupay/oupay_options.dart';
import 'package:flutter_oupay/oupay_result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _restText = '返回结果：';
  @override
  void initState() {
    super.initState();
    //initPlatformState();
    OupayOptions opt = new OupayOptions(isSandboxByUn:true,isSandboxByAli:true,wechatId:'wx06231605d005bcbe',isSandboxByCmb:true,cmbAppId:'0010000516');
    FlutterOupay.setOupayOptions(opt);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOupay.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Column(
          children: <Widget>[
            RaisedButton(
                child: Text('银联支付'),
                onPressed: () async {
                  Map<String, String> payInfo = new Map<String, String>();
                  payInfo['channelId'] = '11';
                  payInfo['channelData'] = '505565086600068424200';
                  OupayResult result = await FlutterOupay.ouPay(payInfo);
                  print(result.toString());
                  setState(() {
                    _restText = result.toString();
                  });
                }),
            RaisedButton(
                child: Text('支付宝支付'),
                onPressed: () async {
                  Map<String, String> payInfo = new Map<String, String>();
                  payInfo['channelId'] = '12';
                  payInfo['channelData'] = 'app_id=2017090608585042&biz_content=%7B%22body%22%3A%22%E9%97%A8%E5%BA%971%E5%8F%B7%22%2C%22out_trade_no%22%3A%2233672079746777089%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%22%E9%97%A8%E5%BA%971%E5%8F%B7%22%2C%22total_amount%22%3A%220.02%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2F111.204.31.117%3A7083%2Fgateway%2Falipay%2Fnotify&sign=AjRyTcElJcssgSB6svOxgPbKKhN8HeebAdRINuqh8dB9c1sfqqumQtV7lb5gGZazhpw7tbXUrlHaWCdLoL3gtBj4BB39w6H82%2FNDDll5XT%2BfEKsAAp98%2BlX556moqOzlGAcU4c3CrEVipyip051nInLFidnq2xjE4KRC%2BdxzALWIXEuZ3E02RKXv1nbqcfbITLLVUdFod4vvCZFssIq1x5V3IdyaxP4qQ4B5hk1eJSaoXtJeojateCEUD4%2F%2FCxcvcrRVnZ1%2F4rcpPtJQktl%2FSFrXaUMN0%2B8LnFAPzeUiQEiuH6FxTXerjMLLdjWh8aTp%2BDdxTeWd1kOh3kYn%2FgYTJw%3D%3D&sign_type=RSA2&timestamp=2018-12-03+17%3A06%3A31&version=1.0';
                  OupayResult result = await FlutterOupay.ouPay(payInfo);
                  print(result.toString());
                  setState(() {
                    _restText = result.toString();
                  });
                }),
            RaisedButton(
                child: Text('微信支付'),
                onPressed: () async {
                  Map<String, String> payInfo = new Map<String, String>();
                  payInfo['channelId'] = '13';
                  payInfo['channelData'] = '{"appid":"wxf9909bde17439ac2","partnerid":"1518469211","prepayid":"wx120649521695951d501636f91748325073","package":"Sign=WXPay","noncestr":"1541976592","timestamp":"1541976592","sign":"E760C99A1A981B9A7D8F17B08EF60FCC"}';
                  OupayResult result = await FlutterOupay.ouPay(payInfo);
                  print(result.toString());
                  setState(() {
                    _restText = result.toString();
                  });
                }),
            RaisedButton(
                child: Text('招行支付'),
                onPressed: () async {
                  Map<String, String> payInfo = new Map<String, String>();
                  payInfo['channelId'] = '14';
                  payInfo['channelData'] = '';
                  OupayResult result = await FlutterOupay.ouPay(payInfo);
                  print(result.toString());
                  setState(() {
                    _restText = result.toString();
                  });
                }),
            Text(_restText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
