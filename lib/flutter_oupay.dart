import 'dart:async';

import 'package:flutter/services.dart';

import 'package:flutter_oupay/oupay_options.dart';
import 'package:flutter_oupay/oupay_result.dart';


class FlutterOupay {
  static const MethodChannel _channel =
      const MethodChannel('flutter_oupay');

  static bool  _options_init = false;
  static OupayOptions _options;

  static void setOupayOptions(final OupayOptions opt){
    _options = opt;
    _options_init = true;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /**
   * 支付
   * */
  static Future<OupayResult> ouPay(Map<String, dynamic> payOrderInfo) async {
    if(!_options_init){
      final OupayResult oupayRest = new OupayResult();
      oupayRest.setOupayRest(-1, "未初始化[ setOupayOptions ]");
      return oupayRest;
    }

    String channelId = payOrderInfo['channelId'];
    dynamic channelData = payOrderInfo['channelData'];

    if(null == channelId || null == channelData){
      final OupayResult oupayRest = new OupayResult();
      oupayRest.setOupayRest(-1, "参数无效");
      return oupayRest;
    }

    switch (channelId) {
      case "11":  //uppay
        return _unionpay(channelData);
        break;
      case "12":  //alipay
        return _alipay(channelData);
        break;
      case "13": //wechatpay
        return _wechatpay(channelData);
        break;
      case "14": //cmbchina
        return _cmbchinapay(channelData);
        break;
      default:
        {
          final OupayResult oupayRest = new OupayResult();
          oupayRest.setOupayRest(-1, "不支持的渠道:$channelId");
          return oupayRest;
        }
        break;
    }
  }

  /**
   * 银联
   */
  static Future<OupayResult> _unionpay(dynamic payInfo) async{
    try{
      var res =  await _channel.invokeMethod('unionPay',<String, dynamic>{
        'payInfo': payInfo,
        'isSandbox': _options.isSandboxByUn,
        'urlScheme': _options.unpayId
      });

      final OupayResult oupayRest = new OupayResult();
      if( res['pay_result'] == "success" ){
        oupayRest.setOupayRest(0, "支付完成",payChannel:'unionpay',channelData:res );
      }else if( res['pay_result'] == "cancel"){
        oupayRest.setOupayRest(-2, "用户取消",payChannel:'unionpay',channelData:res );
      }else{
        oupayRest.setOupayRest(-1, "支付失败",payChannel:'unionpay',channelData:res );
      }
      return oupayRest;
    } on PlatformException catch (e) {
      print(e);
      final OupayResult oupayRest = new OupayResult();
      oupayRest.setOupayRest(-1, "银联支付异常[$e]");
      return oupayRest;
    }

  }

  /**
   * 支付宝
   */
  static Future<OupayResult> _alipay(dynamic payInfo) async{
    try{
      var res =  await _channel.invokeMethod('aliPay',<String, dynamic>{
        'payInfo': payInfo,
        'isSandbox': _options.isSandboxByAli,
        'urlScheme': _options.alipayId
      });

      final OupayResult oupayRest = new OupayResult();
      if( res['resultStatus'].toString() == "9000" ){
        oupayRest.setOupayRest(0, "支付完成",payChannel:'alipay',channelData:res );
      }else if( res['resultStatus'].toString() == "6001"){
        oupayRest.setOupayRest(-2, "用户取消",payChannel:'alipay',channelData:res );
      }else{
        oupayRest.setOupayRest(-1, "支付失败",payChannel:'alipay',channelData:res );
      }
      return oupayRest;
    } on PlatformException catch (e) {
      print(e);
      final OupayResult oupayRest = new OupayResult();
      oupayRest.setOupayRest(-1, "支付宝支付异常[$e]");
      return oupayRest;
    }
  }

  /**
   * 微信
   */
  static Future<OupayResult> _wechatpay(dynamic payInfo) async{
    try{
      var res =  await _channel.invokeMethod('wechatPay',<String, dynamic>{
        'payInfo': payInfo,
        'appid': _options.wechatId
      });

      final OupayResult oupayRest = new OupayResult();
      if( res['errCode'].toString() == "0" ){
        oupayRest.setOupayRest(0, "支付完成",payChannel:'wechatpay',channelData:res );
      }else if( res['errCode'].toString() == "-2"){
        oupayRest.setOupayRest(-2, "用户取消",payChannel:'wechatpay',channelData:res );
      }else{
        oupayRest.setOupayRest(-1, "支付失败",payChannel:'wechatpay',channelData:res );
      }
      return oupayRest;
    } on PlatformException catch (e) {
      print(e);
      final OupayResult oupayRest = new OupayResult();
      oupayRest.setOupayRest(-1, "微信支付异常[$e]");
      return oupayRest;
    }
  }

  /**
   * 招行
   */
  static Future<OupayResult> _cmbchinapay(dynamic payInfo) async{
    try{
      var res =  await _channel.invokeMethod('cmbchinaPay',<String, dynamic>{
        'payInfo': payInfo,
        'appid': _options.cmbAppId,
        'isSandbox': _options.isSanboxByCmb
      });

      final OupayResult oupayRest = new OupayResult();
      if( res['mRespCode'].toString() == "0" ){
        oupayRest.setOupayRest(0, "支付完成",payChannel:'cmbchinapay',channelData:res );
      }else{
        oupayRest.setOupayRest(-1, "支付失败",payChannel:'cmbchinapay',channelData:res );
      }
      return oupayRest;
    } on PlatformException catch (e) {
      print(e);
      final OupayResult oupayRest = new OupayResult();
      oupayRest.setOupayRest(-1, "招行一网通支付异常[$e]");
      return oupayRest;
    }
  }
}
