#import <Flutter/Flutter.h>
#import "OupayAlipay.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation OupayAlipay

+ (void) startPay: (NSString*)payInfo urlScheme:(NSString*)urlScheme result:(FlutterResult)result {
    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:payInfo fromScheme:urlScheme callback:^(NSDictionary *resultDic) {
      NSLog(@"reslut = %@",resultDic);
      result(resultDic);
    }];
}

//回调通知
+(BOOL)handleOpenURL:(NSURL*)url result:(FlutterResult)result
{
    if ([url.host isEqualToString:@"safepay"])
    {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            result(resultDic);
        }];
        
        return YES;
    }
    return NO;
}

@end
