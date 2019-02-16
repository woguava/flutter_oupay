#import <Flutter/Flutter.h>
#import <CMBSDK/CMBSDK.h>

#ifndef FLUTTER_OUPAY_OUPAYCMBPAY_H
#define FLUTTER_OUPAY_OUPAYCMBPAY_H

@interface OupayCMBPay : NSObject <CMBApiDelegate>

@property (readwrite,copy,nonatomic) FlutterResult __result;
+ (instancetype)sharedManager;

+ (void) startPay:(NSString*)appId payInfo:(NSString*)payInfo isSandbox:(BOOL)isSandbox viewCtrl:(UIViewController *)viewCtrl   result:(FlutterResult)result;
+ (BOOL) handleOpenURL: (NSURL*)url result:(FlutterResult)result;

@end


#endif //FLUTTER_OUPAY_OUPAYCMBPAY_H
