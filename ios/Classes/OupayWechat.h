#import <Flutter/Flutter.h>
#import "WXApi.h"

#ifndef FLUTTER_OUPAY_OUPAYWECHAT_H
#define FLUTTER_OUPAY_OUPAYWECHAT_H

@interface OupayWechat : NSObject<WXApiDelegate>

@property (readwrite,copy,nonatomic) FlutterResult __result;

+ (void) startPay:(NSString*)appId payInfo:(NSString*)payInfo result:(FlutterResult)result ;
+ (BOOL) handleOpenURL: (NSURL*)url result:(FlutterResult)result;

@end


#endif //FLUTTER_OUPAY_OUPAYWECHAT_H
