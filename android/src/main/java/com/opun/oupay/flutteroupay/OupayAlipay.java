package com.opun.oupay.flutteroupay;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.annotation.SuppressLint;
import android.os.Handler;
import android.os.Message;

import java.util.Map;
import com.alipay.sdk.app.EnvUtils;
import com.alipay.sdk.app.PayTask;
import io.flutter.plugin.common.MethodChannel;

public class OupayAlipay {
    protected final Activity g_activity;
    protected MethodChannel.Result g_Alicallback;

    public OupayAlipay(Activity activity){
        this.g_activity = activity;
    }

    //检测APP是否安装
    public boolean checkInstallApp(final String appId){
        Uri uri = Uri.parse("alipays://platformapi/startApp");
        Intent intent = new Intent(Intent.ACTION_VIEW, uri);
        ComponentName componentName = intent.resolveActivity(g_activity.getPackageManager());
        return componentName != null;
    }

    @SuppressLint("HandlerLeak")
    private Handler mHandler = new Handler() {
        @SuppressWarnings("unused")
        public void handleMessage(Message msg) {
            g_Alicallback.success(msg.obj);
        };
    };

    // 调起支付
    public void startPay(final String payInfo, boolean isSandbox, final MethodChannel.Result callback) {
        g_Alicallback = callback;

        // 沙箱环境
        if (isSandbox) {
            EnvUtils.setEnv(EnvUtils.EnvEnum.SANDBOX);
        }

        final Runnable payRunnable = new Runnable() {
            @Override
            public void run() {
                PayTask alipay = new PayTask(g_activity);
                Map<String, String> result = alipay.payV2(payInfo, true);
                Log.d("AliPay","payV2 return ::" + result.toString());
                Message msg = new Message();
                msg.obj = result;
                mHandler.sendMessage(msg);
            }
        };

        Thread payThread = new Thread(payRunnable);
        payThread.start();
    }
}
