package com.opun.oupay.flutteroupay;

import android.app.Activity;
import android.util.Log;

import com.opun.oupay.flutteroupay.cmbapi.CmbRegister;
import io.flutter.plugin.common.MethodChannel;

import cmbapi.CMBApi;
import cmbapi.CMBApiFactory;
import cmbapi.CMBEventHandler;
import cmbapi.CMBRequest;
import cmbapi.CMBResponse;
import cmbapi.CMBPayCallback;

public class OupayCMBPay {
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

}
