#import "OupayUnionPay.h"



@implementation OupayUnionPay

+ (void) startPay: (NSString*)payInfo isSandbox:(BOOL)isSandbox urlScheme:(NSString*)urlScheme viewCtrl:(UIViewController *)viewCtrl result:(FlutterResult)result {
   //获取模式类型 00 生产 01 测试
    NSString* mode = @"00";
    if(isSandbox){
        mode = @"01";
    }
    if (payInfo != nil && [payInfo length] > 0) {
        [[UPPaymentControl defaultControl] startPay:payInfo fromScheme:urlScheme mode:mode viewController:viewCtrl];
    }else{
        result(@"payment tn invalid!");
    }
    
}


//回调通知
+ (BOOL)handleOpenURL:(NSURL*)url result:(FlutterResult)result
{
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        NSMutableDictionary * resultDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                            @"",@"pay_result",
                                            @"",@"data",
                                            @"",@"sign",nil];
        [resultDict setValue:code forKey:@"pay_result"];
        
        if([code isEqualToString:@"success"]) {
            //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
            if(data != nil){
                [resultDict addEntriesFromDictionary:data];
            }
        }
        
        result(resultDict);
        
    }];
    
    return YES;
}

@end
