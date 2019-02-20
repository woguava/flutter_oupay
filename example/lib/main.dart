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
   /* try {
      platformVersion = await FlutterOupay.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }*/

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
                child: Text('检测支付渠道APP'),
                onPressed: () async {
                  Map<dynamic, dynamic>  result = await FlutterOupay.isInstallApps;
                  print(result.toString());
                  setState(() {
                    _restText = result.toString();
                  });
                }),
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
                  payInfo['channelData'] = 'charset=utf-8&jsonRequestData=%7B%22reqData%22%3A%7B%22dateTime%22%3A%2220190215164935%22%2C%22date%22%3A%2220190215%22%2C%22extendInfoEncrypType%22%3A%22RC4%22%2C%22payNoticePara%22%3A%22pay%22%2C%22riskLevel%22%3A%223%22%2C%22subMerchantNo%22%3A%22%22%2C%22lon%22%3A%2250.949506%22%2C%22userID%22%3A%2220181213135711005%22%2C%22subMerchantName%22%3A%22%22%2C%22signNoticeUrl%22%3A%22http%3A%2F%2F111.204.31.119%2Fgateway%2Fcmb%2Fnotify%22%2C%22subMerchantTPCode%22%3A%22%22%2C%22clientIP%22%3A%2299.12.43.61%22%2C%22expireTimeSpan%22%3A%2220%22%2C%22payNoticeUrl%22%3A%22http%3A%2F%2F111.204.31.119%2Fgateway%2Fcmb%2Fnotify%22%2C%22lat%22%3A%2230.949505%22%2C%22payModeType%22%3A%22%22%2C%22amount%22%3A%220.01%22%2C%22orderNo%22%3A%22119623515035156514%22%2C%22cardType%22%3A%22%22%2C%22subMerchantTPName%22%3A%22%22%2C%22mobile%22%3A%2217600046900%22%2C%22merchantSerialNo%22%3A%2220181213135711005%22%2C%22agrNo%22%3A%2220181213135711005%22%2C%22extendInfo%22%3A%221AD3638499DD5EADAC00B8242575AF12D94742F45EF6F2D458C0D5B7A8EB916B1D8D03CA0F32052EE520348965017113A267BEEC865155DDF76655769883EB0A55DBAAAD47978A080409A346E61B81384007F4C4FE972B4EB5B2BB09AEE1560860DC43DB2B7DA8F20902F052F042157D7A0C330B53D2AC670C31753D567632650BA825554DC0CF1BD991FC3B5301C5DD4DF2B4D61782E105FADD3F77843782151AC27FE223D6AE5EAB1CA13FDA6DDF24F1B46396793E1397CD93C2D3A779223F64C5B50A0EA1A6DE24BBAD251F53FD39D834E975F3A8FBBF6AC973974CBD38F7E10BD973BB61E58009D1CB804030186431%22%2C%22signNoticePara%22%3A%2212345678%7CABCDEFG%7CHIJKLM%22%2C%22branchNo%22%3A%220010%22%2C%22merchantNo%22%3A%22000516%22%7D%2C%22sign%22%3A%22D0D828747BBCF9FCEE7C59844F4AC4DC26DB4C2461760B7E354A072BC5BCAD52%22%2C%22signType%22%3A%22SHA-256%22%2C%22version%22%3A%221.0%22%7D';
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
