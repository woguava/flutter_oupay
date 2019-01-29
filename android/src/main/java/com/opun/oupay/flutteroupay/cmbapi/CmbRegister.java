package com.opun.oupay.flutteroupay.cmbapi;

import android.app.Activity;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

import cmbapi.CMBApi;
import cmbapi.CMBApiFactory;
import cmbapi.CMBEventHandler;
import cmbapi.CMBRequest;
import cmbapi.CMBResponse;

public class CmbRegister {
    private static MethodChannel.Result g_result = null;
    private static CMBApi g_cmbApi = null;

    private static final Map<String, String> sandbox;
    static
    {
        sandbox = new HashMap<String, String>();
        sandbox.put("mH5Url", "http://121.15.180.66:801/netpayment/BaseHttp.dll?H5PayJsonSDK");
        sandbox.put("mCMBJumpUrl", "cmbmobilebank://CMBLS/FunctionJump?action=gofuncid&funcid=200013&serverid=CMBEUserPay&requesttype=post&cmb_app_trans_parms_start=here");
    }

    private static final Map<String, String> production;
    static
    {
        production = new HashMap<String, String>();
        production.put("mH5Url", "https://netpay.cmbchina.com/netpayment/BaseHttp.dll?H5PayJsonS");
        production.put("mCMBJumpUrl", "cmbmobilebank://CMBLS/FunctionJump?action=gofuncid&funcid=200013&serverid=CMBEUserPay&requesttype=post&cmb_app_trans_parms_start=here");
    }

    public static String get_mH5Url(boolean isSandbox){
        if(isSandbox){
            return sandbox.get("mH5Url");
        }else{
            return production.get("mH5Url");
        }
    }

    public static String get_mCMBJumpUrl(boolean isSandbox){
        if(isSandbox){
            return sandbox.get("mCMBJumpUrl");
        }else{
            return production.get("mCMBJumpUrl");
        }
    }

    // 注册
    public static  void registerCMB(final String cmbAppId, Activity activity){
        if(null == CmbRegister.g_cmbApi){
            g_cmbApi = CMBApiFactory.createCMBAPI(activity,cmbAppId);
        }
    }

    public static CMBApi getCMBApi(){
        return g_cmbApi;
    }

    public static MethodChannel.Result getResult() {
        return g_result;
    }

    public static void setResult(MethodChannel.Result result) {
        g_result = result;
    }
}
