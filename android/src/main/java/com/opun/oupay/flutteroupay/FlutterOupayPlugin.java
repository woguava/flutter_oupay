package com.opun.oupay.flutteroupay;

import java.util.HashMap;
import java.util.Map;

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

    if (call.method.equals("checkInstallApps")) {
      String unpayAppid = call.argument("unpayAppid");
      String alipayAppid = call.argument("alipayAppid");
      String wechatAppid = call.argument("wechatAppid");
      String cmbAppid = call.argument("cmbAppid");

      Map<String, Boolean> resultMap = new HashMap<String,Boolean>();
      resultMap.put("unpayApp",oupayUnionPay.checkInstallApp(unpayAppid));
      resultMap.put("alipayApp",oupayAlipay.checkInstallApp(alipayAppid));
      resultMap.put("wechatApp",oupayWechat.checkInstallApp(wechatAppid));
      resultMap.put("cmbApp",oupayCmbPay.checkInstallApp(cmbAppid));

      result.success(resultMap);
    }else if (call.method.equals("unionPay")) {
      String payInfo = call.argument("payInfo");
      boolean isSandbox = call.argument("isSandbox");
      String urlScheme = call.argument("urlScheme");

      oupayUnionPay.startPay(payInfo,isSandbox,result);
    }else if (call.method.equals("aliPay")) {
      String payInfo = call.argument("payInfo");
      boolean isSandbox = call.argument("isSandbox");
      String urlScheme = call.argument("urlScheme");

      oupayAlipay.startPay(payInfo,isSandbox,result);

    }else if (call.method.equals("wechatPay")) {
      String payInfo = call.argument("payInfo");
      String appid = call.argument("appid");
      String urlScheme = call.argument("urlScheme");

      oupayWechat.starPay(appid,payInfo,result);
    }else if (call.method.equals("cmbchinaPay")) {
      String payInfo = call.argument("payInfo");
      String appid = call.argument("appid");
      boolean isSandbox = call.argument("isSandbox");
      String urlScheme = call.argument("urlScheme");

      oupayCmbPay.starPay(appid,payInfo,isSandbox,result);
    }else {
      result.notImplemented();
    }
  }

}
