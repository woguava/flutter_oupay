package com.opun.oupay.flutteroupay;

import android.app.Activity;
import java.util.Map;
import com.alipay.sdk.app.EnvUtils;
import com.alipay.sdk.app.PayTask;

import io.flutter.plugin.common.MethodChannel;

public class OupayAlipay {
    private final Activity g_activity;

    public OupayAlipay(Activity activity){
        this.g_activity = activity;
    }

    // 调起支付
    public void startPay(final String payInfo, boolean isSandbox, final MethodChannel.Result callback) {
        // 沙箱环境
        if (isSandbox) {
            EnvUtils.setEnv(EnvUtils.EnvEnum.SANDBOX);
        }

        final Activity activity = this.g_activity;
        Runnable payRunnable = new Runnable() {
            @Override
            public void run() {
                try {
                    // 构造PayTask 对象
                    PayTask alipay = new PayTask(activity);
                    // 调用支付接口，获取支付结果
                    Map<String, String> result = alipay.payV2(payInfo, true);
                    callback.success(result);
                } catch (Exception e) {
                    callback.error("oupay_alipay_err", e.getMessage(), null);
                }
            }
        };

        Thread payThread = new Thread(payRunnable);
        payThread.start();
    }
}
