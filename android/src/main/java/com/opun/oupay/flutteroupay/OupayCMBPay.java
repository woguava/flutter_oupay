package com.opun.oupay.flutteroupay;

import com.opun.oupay.flutteroupay.cmbapi.CmbRegister;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import cmbapi.CMBApi;
import cmbapi.CMBApiFactory;
import cmbapi.CMBEventHandler;
import cmbapi.CMBRequest;
import cmbapi.CMBResponse;
import cmbapi.CMBPayCallback;


public class OupayCMBPay  implements PluginRegistry.ActivityResultListener{
    private final Activity g_activity;

    public OupayCMBPay(Activity activity){
        g_activity = activity;
    }


    // 注册
    public void registerCMB(final String cmbAppId){
        CMBApi cmbApi = CmbRegister.getCMBApi();
        if(null == cmbApi){
            CmbRegister.registerCMB(cmbAppId,g_activity);
        }
    }

    // 调起支付
    public void starPay(String appid, String payInfo, boolean isSandbox, MethodChannel.Result result) {
        CmbRegister.setResult(result);
        registerCMB(appid);


        Log.d("OUPAY_CMB",appid);
        Log.d("OUPAY_CMB",payInfo);
        Log.d("OUPAY_CMB",""+isSandbox);

        CMBRequest request = new CMBRequest();
        request.mMethod = "pay"; //默认值 pay
        request.mRequestData = payInfo; //透传签名数据
        request.mH5Url = CmbRegister.get_mH5Url(isSandbox); //h5 url
        request.mCMBJumpUrl = CmbRegister.get_mCMBJumpUrl(isSandbox); //Jump url

        Log.d("OUPAY_CMB",request.mH5Url);
        Log.d("OUPAY_CMB",request.mCMBJumpUrl);

        try {
            CMBApi cmbApi = CmbRegister.getCMBApi();
            Log.d("OUPAY_CMB","请求开始。。。。。。。");
            cmbApi.sendReq(request);
        } catch (Exception e) {
            result.error("oupay_cmbpay_err", e.getMessage(), null);
        }
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent intent) {
        if (null == intent) {
            return false;
        }

        if(3 == requestCode && 2 == resultCode){
            Map<String, String> resultMap = new HashMap<String,String>();
            String respCode = intent.getExtras().getString("respcode");
            String respMessage = intent.getExtras().getString("respmsg");

            resultMap.put("mRespCode", respCode);
            resultMap.put("mRespMsg", respMessage);

            Log.d("OupayCMBPay", "onActivityResult: " + resultMap.toString());

            CmbRegister.getResult().success(resultMap);
            return true;
        }

        return false;
    }

}
