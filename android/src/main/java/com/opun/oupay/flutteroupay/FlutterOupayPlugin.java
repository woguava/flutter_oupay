package com.opun.oupay.flutteroupay;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterOupayPlugin */
public class FlutterOupayPlugin  implements MethodCallHandler {
  private final Registrar registrar;
  private final  PermissionManager permissionManager;
  private final OupayUnionPay oupayUnionPay;
  private final OupayAlipay oupayAlipay;
  private final OupayWechat oupayWechat;
  private final OupayCMBPay oupayCmbPay;

  private FlutterOupayPlugin(Registrar registrar){
    this.registrar = registrar;
    this.permissionManager = new PermissionManager(registrar.activity());
    registrar.addRequestPermissionsResultListener(permissionManager);
    // 注册ActivityResult回调
    oupayUnionPay = new OupayUnionPay(registrar.activity());
    registrar.addActivityResultListener(oupayUnionPay);

    oupayAlipay = new OupayAlipay(registrar.activity());
    oupayWechat = new OupayWechat(registrar.activeContext());

    oupayCmbPay = new OupayCMBPay(registrar.activity());
    registrar.addActivityResultListener(oupayCmbPay);
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_oupay");
    channel.setMethodCallHandler(new FlutterOupayPlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    //检验权限
    if( !permissionManager.requestPermission() ){
      result.error("oupay","check permission fail",null);
      return;
    }

    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if (call.method.equals("unionPay")) {
      String payInfo = call.argument("payInfo");
      boolean isSandbox = call.argument("isSandbox");

      oupayUnionPay.startPay(payInfo,isSandbox,result);
    }else if (call.method.equals("aliPay")) {
      String payInfo = call.argument("payInfo");
      boolean isSandbox = call.argument("isSandbox");

      oupayAlipay.startPay(payInfo,isSandbox,result);

    }else if (call.method.equals("wechatPay")) {
      String payInfo = call.argument("payInfo");
      String appid = call.argument("appid");

      oupayWechat.starPay(appid,payInfo,result);
    }else if (call.method.equals("cmbchinaPay")) {
      String payInfo = call.argument("payInfo");
      String appid = call.argument("appid");
      boolean isSandbox = call.argument("isSandbox");

      oupayCmbPay.starPay(appid,payInfo,isSandbox,result);
    }else {
      result.notImplemented();
    }
  }

}
