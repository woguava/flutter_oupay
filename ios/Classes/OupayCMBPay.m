#import "OupayCMBPay.h"


@implementation OupayCMBPay

static const NSDictionary * __sandbox = nil;
static const NSDictionary * __production = nil;

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static OupayCMBPay *instance;
    dispatch_once(&onceToken, ^{
        instance = [[OupayCMBPay alloc] init];
    });
    return instance;
}


+(void) initializeParam{
    static dispatch_once_t onceInit;
    dispatch_once(&onceInit, ^{
        __sandbox = @{@"h5Url":@"http://121.15.180.66:801/netpayment/BaseHttp.dll?H5PayJsonSDK",
                      @"CMBJumpUrl":@"cmbmobilebank://CMBLS/FunctionJump?action=gofuncid&funcid=200013&serverid=CMBEUserPay&requesttype=post&cmb_app_trans_parms_start=here"
                      };
        
        __production = @{@"h5Url":@"https://netpay.cmbchina.com/netpayment/BaseHttp.dll?H5PayJsonSDK",
                         @"CMBJumpUrl":@"cmbmobilebank://CMBLS/FunctionJump?action=gofuncid&funcid=200013&serverid=CMBEUserPay&requesttype=post&cmb_app_trans_parms_start=here"
                         };
        
    });
}


+(NSString*) get_mH5Url:(BOOL)isSandbox {
    [OupayCMBPay initializeParam];
    if(isSandbox){
        return [__sandbox objectForKey:@"h5Url"];
    }else{
        return [__production objectForKey:@"h5Url"];
    }
}

+(NSString*) get_mCMBJumpUrl:(BOOL)isSandbox {
    [OupayCMBPay initializeParam];
    if(isSandbox){
        return [__sandbox objectForKey:@"CMBJumpUrl"];
    }else{
        return [__production objectForKey:@"CMBJumpUrl"];
    }
}

+ (void) startPay:(NSString*)appId payInfo:(NSString*)payInfo isSandbox:(BOOL)isSandbox viewCtrl:(UIViewController *)viewCtrl  result:(FlutterResult)result{
    OupayCMBPay* instance = [OupayCMBPay sharedManager];
    instance.__result = result;
    
    CMBRequest *reqObj = [[CMBRequest alloc] init];
    reqObj.requestData = payInfo;
    reqObj.method = @"pay";
    reqObj.CMBJumpUrl = [self get_mCMBJumpUrl:isSandbox];
    reqObj.h5Url = [self get_mH5Url:isSandbox];
    
    [CMBApi sendRequest:reqObj appid:appId viewController:viewCtrl delegate:instance];
}

//回调通知
+ (BOOL)handleOpenURL:(NSURL*)url result:(FlutterResult)result
{
    OupayCMBPay* instance = [OupayCMBPay sharedManager];
    instance.__result = result;
    return  [CMBApi handleOpenURL:url delegate:instance];
}


#pragma mark - CMBApiDelegate

- (void)onResp:(CMBResponse *)resp {
    NSDictionary * resultString = @{@"mRespCode":[NSString stringWithFormat:@"%d",resp.respCode],@"mRespMsg":resp.respMessage};
    NSLog(@"招行返回支付结果：%@",resultString);
    self.__result( resultString );
}

@end
