#import <Flutter/Flutter.h>
#import "UPPaymentControl.h"

#ifndef FLUTTER_OUPAY_OUPAYUNIONPAY_H
#define FLUTTER_OUPAY_OUPAYUNIONPAY_H

@interface OupayUnionPay : NSObject

+ (BOOL) checkInstallApp: (NSString*)appId;
+ (void) startPay: (NSString*)payInfo isSandbox:(BOOL)isSandbox urlScheme:(NSString*)urlScheme viewCtrl:(UIViewController *)viewCtrl result:(FlutterResult)result;
+ (BOOL) handleOpenURL: (NSURL*)url result:(FlutterResult)result;

@end


#endif //FLUTTER_OUPAY_OUPAYUNIONPAY_H
