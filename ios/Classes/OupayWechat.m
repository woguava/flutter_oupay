#import "OupayWechat.h"

@implementation OupayWechat

static NSString * wechat_appId = nil;
static BOOL __isRegister = NO;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (BOOL) checkInstallApp: (NSString*)appId {
    return [self isInstalled:appId];
}

+ (BOOL) isInstalled:(NSString*)appId {
    if(nil == wechat_appId)
        wechat_appId = appId;
    
    if(!__isRegister){
        [WXApi registerApp: wechat_appId];
        __isRegister = YES;
    }
    
    return [WXApi isWXAppInstalled];
}

+ (void) startPay:(NSString*)appId payInfo:(NSString*)payInfo result:(FlutterResult)result {
   
    if(![self isInstalled:appId])
    {
        NSString *resultString  = [NSString stringWithFormat:@"{\"errCode\":\"%d\",\"errStr\":\"%@\"}",-1,@"微信未安装！"];
        result( [OupayWechat dictionaryWithJsonString:resultString] );
        return ;
    }
    
    NSDictionary * payParam =  [OupayWechat dictionaryWithJsonString:payInfo];

    NSArray *requiredParams = @[@"partnerid", @"prepayid", @"timestamp", @"noncestr",@"package", @"sign"];
    for (NSString *key in requiredParams)
    {
        if (![payParam objectForKey:key])
        {
            NSString *resultString  = [NSString stringWithFormat:@"{\"errCode\":\"%d\",\"errStr\":\"%@\"}",-1,@"参数格式错误!"];
            result( [OupayWechat dictionaryWithJsonString:resultString] );
            return ;
        }
    }

    PayReq *wxReq = [[PayReq alloc] init];
    wxReq.partnerId = [payParam objectForKey:requiredParams[0]];
    wxReq.prepayId = [payParam objectForKey:requiredParams[1]];
    wxReq.timeStamp = [[payParam objectForKey:requiredParams[2]] unsignedIntValue];
    wxReq.nonceStr = [payParam objectForKey:requiredParams[3]];
    wxReq.package = [payParam objectForKey:requiredParams[4]];
    wxReq.sign = [payParam objectForKey:requiredParams[5]];

    [WXApi sendReq:wxReq];
}



- (void) onReq:(BaseReq *)req{
    NSLog(@"onReq....");
}

- (void) onResp:(BaseResp *)resp{
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *resultString;
        switch(resp.errCode){
            case 0:
                resultString= [NSString stringWithFormat:@"{\"errCode\":\"%d\",\"errStr\":\"%@\"}",resp.errCode,@"支付成功"];
                break;
            case -2:
                resultString= [NSString stringWithFormat:@"{\"errCode\":\"%d\",\"errStr\":\"%@\"}",resp.errCode,@"用户取消"];
                break;
            default:
                resultString= [NSString stringWithFormat:@"{\"errCode\":\"%d\",\"errStr\":\"%@\"}",resp.errCode,@"支付失败"];
                break;
        }
        
        NSLog(@"微信支付结果：%@", resultString);
        
        self.__result( [OupayWechat dictionaryWithJsonString:resultString] );
    }
}

//回调通知
+ (BOOL)handleOpenURL:(NSURL*)url result:(FlutterResult)result
{
    OupayWechat* instance = [[OupayWechat alloc] init];
    instance.__result = result;
    return [WXApi handleOpenURL:url delegate:instance];
}


@end
