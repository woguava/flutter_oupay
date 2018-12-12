package com.opun.oupay.flutteroupay.wxapi;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.tencent.mm.opensdk.constants.ConstantsAPI;
import com.tencent.mm.opensdk.modelbase.BaseReq;
import com.tencent.mm.opensdk.modelbase.BaseResp;
import com.tencent.mm.opensdk.modelpay.PayResp;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.IWXAPIEventHandler;

import java.util.HashMap;
import java.util.Map;

public class WXPayEntryActivity extends Activity implements IWXAPIEventHandler{
    private static final String TAG = "WXPayEntryActivity";
    //微信支付
    private IWXAPI wxApi = null;

    @Override
    protected void onCreate( Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        wxApi = WxRegister.getWxAPi();
        wxApi.handleIntent(getIntent(), this);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        wxApi.handleIntent(intent, this);
    }

    @Override
    public void onReq(BaseReq baseReq) {
        Log.e(TAG,"req");
    }

    @Override
    public void onResp(BaseResp baseResp) {
        Log.e(TAG,"微信支付回调");
        if (WxRegister.getCallback() == null) {
            Log.d(TAG, "CallbackContext 无效");
            startMainActivity();
            return ;
        }

        Map<String, String>  resultMap = new HashMap<String,String>();
        resultMap.put("errCode",""+baseResp.errCode);
        resultMap.put("errStr",baseResp.errStr);
        resultMap.put("transaction",baseResp.transaction);
        resultMap.put("openId",baseResp.openId);

        switch (baseResp.getType()){
            case ConstantsAPI.COMMAND_PAY_BY_WX: {
                PayResp wxPayResp = (PayResp) baseResp;
                resultMap.put("prepayId", wxPayResp.prepayId);
                resultMap.put("extData", wxPayResp.extData);
                resultMap.put("returnKey", wxPayResp.returnKey);
            }
            break;
        }

        Log.d(TAG,"wechat return ::" + resultMap.toString());
        WxRegister.getCallback().success(resultMap);

        finish();
    }

    protected void startMainActivity() {
        Intent intent = new Intent();
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        getApplicationContext().startActivity(intent);
    }
}
