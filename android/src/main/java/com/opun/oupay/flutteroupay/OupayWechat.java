package com.opun.oupay.flutteroupay;

import android.app.Activity;
import android.content.Context;

import com.opun.oupay.flutteroupay.wxapi.WxRegister;
import io.flutter.plugin.common.MethodChannel;

import com.tencent.mm.opensdk.modelpay.PayReq;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import com.alibaba.fastjson.*;

public class OupayWechat {
    private final Context g_context;

    OupayWechat(Context context){
        this.g_context = context;
    }

    protected boolean isInstalled(String wxAppId) {
        IWXAPI wxApi  = WxRegister.getWxAPi();
        if(null == wxApi){
            wxApi = WxRegister.initWXAPI(wxAppId,g_context);
        }
        if(null == wxApi){
            return false;
        }

        return wxApi.isWXAppInstalled();
    }

    public void starPay(final String wxAppId,final String payInfo, final MethodChannel.Result callback){
        WxRegister.setCallback(callback);

        //判断微信是否安装
        if(!isInstalled(wxAppId)){
            callback.error("oupay_wechat_err","未安装微信!",null);
            return;
        }

        //准备支付参数
        try{
            JSONObject payParams = JSON.parseObject(payInfo);

            PayReq wxPayReq = new PayReq();
            wxPayReq.appId = payParams.getString("appid");
            wxPayReq.partnerId = payParams.getString("partnerid");
            wxPayReq.prepayId = payParams.getString("prepayid");
            wxPayReq.nonceStr = payParams.getString("noncestr");
            wxPayReq.timeStamp = payParams.getString("timestamp");
            wxPayReq.packageValue = payParams.getString("package");
            wxPayReq.sign = payParams.getString("sign");

            if(!wxPayReq.checkArgs() || !wxPayReq.appId.equals(wxAppId)){
                callback.error("oupay_wechat_err","注册的APPID与设置的不匹配!",null);
                return;
            }

            //发送请求
            IWXAPI wxApi  = WxRegister.getWxAPi();
            if (!wxApi.sendReq(wxPayReq)) {
                callback.error("oupay_wechat_err","微信支付请求失败!",null);
            }
        } catch (Exception e) {
            callback.error("oupay_wechat_err","微信支付请求参数格式错误!",null);
            return;
        }
    }
}
