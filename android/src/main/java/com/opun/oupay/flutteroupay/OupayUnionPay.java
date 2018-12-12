package com.opun.oupay.flutteroupay;

import android.app.Activity;
import android.content.Intent;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import com.unionpay.UPPayAssistEx;
import com.unionpay.uppay.PayActivity;


public class OupayUnionPay implements PluginRegistry.ActivityResultListener{
    private final Activity g_activity;
    private MethodChannel.Result g_callback;

    public OupayUnionPay(Activity activity){
        this.g_activity = activity;
    }

    // 调起支付
    public void startPay(final String payInfo,boolean isSandbox, final MethodChannel.Result callback) {
        this.g_callback = callback;
        String upMode = "00";
        if(isSandbox) {
            upMode = "01";
        }

        try {
            UPPayAssistEx.startPay(g_activity, null, null, payInfo, upMode);
        } catch (Exception e) {
            callback.error("oupay_unionpay_err", e.getMessage(), null);
        }
    }


    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent intent) {
        if (null == intent) {
            g_callback.error("oupay_unionpay_err", "Fail to get result with intent", null);
            return false;
        }
        /*
         * 支付控件返回字符串:success、fail、cancel 分别代表支付成功，支付失败，支付取消
         */
        Map<String, String>  resultMap = new HashMap<String,String>();
        String payResult = intent.getExtras().getString("pay_result");
        resultMap.put("pay_result", payResult);

        if (payResult.equalsIgnoreCase("success")) {
            if (intent.hasExtra("result_data")) {
                String resultData = intent.getExtras().getString("result_data");
                resultMap.put("result_data", resultData);
            }
        }

        g_callback.success(resultMap);

        return true;
    }
}
