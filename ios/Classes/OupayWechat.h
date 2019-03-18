#import <Flutter/Flutter.h>

#ifndef FLUTTER_OUPAY_OUPAYWECHAT_H
#define FLUTTER_OUPAY_OUPAYWECHAT_H

@interface OupayWechat : NSObject

@property (readwrite,copy,nonatomic) FlutterResult __result;

+ (BOOL) checkInstallApp: (NSString*)appId;
+ (void) startPay:(NSString*)appId payInfo:(NSString*)payInfo result:(FlutterResult)result ;
+ (BOOL) handleOpenURL: (NSURL*)url result:(FlutterResult)result;

@end


#endif //FLUTTER_OUPAY_OUPAYWECHAT_H
