package com.opun.oupay.flutteroupay.cmbapi;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import java.util.HashMap;
import java.util.Map;

import cmbapi.CMBApi;
import cmbapi.CMBApiFactory;
import cmbapi.CMBEventHandler;
import cmbapi.CMBRequest;
import cmbapi.CMBResponse;

public class CMBSchemeActivity extends Activity implements CMBEventHandler{
    private static final String TAG = "CMBSchemeActivity";
    private CMBApi cmbApi = null;

    @Override
    protected void onCreate( Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        cmbApi = CmbRegister.getCMBApi();
        cmbApi.handleIntent(getIntent(),this);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        cmbApi.handleIntent(intent,this);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
        super.onActivityResult(requestCode, resultCode, intent);
        cmbApi.handleIntent(intent, this);
    }

    @Override
    public void onResp(CMBResponse response){
        Log.e(TAG,"招行一网通支付回调");

        Map<String, String> resultMap = new HashMap<String,String>();
        //错误码：0处理成功，-1普通错误， -2 结果未知
        resultMap.put("mRespCode", ""+response.mRespCode);
        resultMap.put("mRespMsg", response.mRespMsg);

        Log.d(TAG,"CMBPay return ::" + resultMap.toString());
        CmbRegister.getResult().success(resultMap);

        finish();
    }
}
