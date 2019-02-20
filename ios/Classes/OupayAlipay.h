#import <Flutter/Flutter.h>

#ifndef FLUTTER_OUPAY_OUPAYALIPAY_H
#define FLUTTER_OUPAY_OUPAYALIPAY_H


@interface OupayAlipay : NSObject

+ (BOOL) checkInstallApp: (NSString*)appId;
+ (void) startPay: (NSString*)payInfo urlScheme:(NSString*)urlScheme result:(FlutterResult)result;
+ (BOOL) handleOpenURL: (NSURL*)url result:(FlutterResult)result;

@end


#endif //FLUTTER_OUPAY_OUPAYALIPAY_H
