package com.opun.oupay.flutteroupay.wxapi;

import android.content.Context;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import io.flutter.plugin.common.MethodChannel;

public class WxRegister {
    private static IWXAPI g_wxApi = null;
    private static MethodChannel.Result g_callback = null;

    public static void setWxApi(IWXAPI wxapi){
        WxRegister.g_wxApi = wxapi;
    }

    public static IWXAPI getWxAPi(){
        return WxRegister.g_wxApi;
    }

    //注册微信appid
    public static IWXAPI initWXAPI(String wxAppId,Context wxContext){
        WxRegister.g_wxApi = WXAPIFactory.createWXAPI(wxContext,wxAppId);
        if(!WxRegister.g_wxApi.registerApp(wxAppId)){
            WxRegister.g_wxApi = null;
        }

        return  WxRegister.g_wxApi;
    }

    public static MethodChannel.Result getCallback() {
        return WxRegister.g_callback;
    }

    public static void setCallback(MethodChannel.Result callback) {
        WxRegister.g_callback = callback;
    }
}
