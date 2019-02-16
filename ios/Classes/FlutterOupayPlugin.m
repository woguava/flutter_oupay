#import "FlutterOupayPlugin.h"
#import "OupayAlipay.h"
#import "OupayCMBPay.h"
#import "OupayUnionPay.h"
#import "OupayWechat.h"

__weak FlutterOupayPlugin* __FlutterOupayPlugin;

@interface FlutterOupayPlugin()
@property (readwrite,copy,nonatomic) FlutterResult __result;
@property (readwrite,copy,nonatomic) NSString * alipay_urlScheme;
@property (readwrite,copy,nonatomic) NSString * wechat_urlScheme;
@property (readwrite,copy,nonatomic) NSString * uppay_urlScheme;
@property (readwrite,copy,nonatomic) NSString * cmb_urlScheme;
@end

@implementation FlutterOupayPlugin{
    UIViewController *_viewController;
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _viewController = viewController;
        __FlutterOupayPlugin  = self;
    }
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_oupay"
            binaryMessenger:[registrar messenger]];
 UIViewController *viewController =
    [UIApplication sharedApplication].delegate.window.rootViewController;
    FlutterOupayPlugin* instance = [[FlutterOupayPlugin alloc] initWithViewController:viewController];
  [registrar addMethodCallDelegate:instance channel:channel];
}



- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  self.__result = result;

  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"unionPay" isEqualToString:call.method]) {
    NSString * payInfo = call.arguments[@"payInfo"];
    NSNumber * isSandbox = call.arguments[@"isSandbox"];
    NSString * urlScheme = call.arguments[@"urlScheme"];
      
    self.uppay_urlScheme = urlScheme;

    [OupayUnionPay startPay:payInfo isSandbox:[isSandbox boolValue] urlScheme:urlScheme viewCtrl:_viewController result:result ];

  } else if ([@"aliPay" isEqualToString:call.method]) {
    NSString * payInfo = call.arguments[@"payInfo"];
    NSString * urlScheme = call.arguments[@"urlScheme"];
    
    self.alipay_urlScheme = urlScheme;

    [OupayAlipay startPay:payInfo urlScheme:urlScheme result:result ];

  } else if ([@"wechatPay" isEqualToString:call.method]) {
    NSString  * payInfo = call.arguments[@"payInfo"];
    NSString *  appId = call.arguments[@"appid"];
      
    self.wechat_urlScheme = appId;

    [OupayWechat startPay:appId payInfo:payInfo result:result ];

  } else if ([@"cmbchinaPay" isEqualToString:call.method]) {
    NSString * payInfo = call.arguments[@"payInfo"];
    NSString *  appId = call.arguments[@"appid"];
    NSNumber * isSandbox = call.arguments[@"isSandbox"];
      
    self.cmb_urlScheme = appId;

    [OupayCMBPay startPay:appId payInfo:payInfo isSandbox:[isSandbox boolValue] viewCtrl:_viewController result:result ];

  } else {
    result(FlutterMethodNotImplemented);
  }

}

+(BOOL)handleOpenURL:(NSURL*)url{
    if(!__FlutterOupayPlugin)return NO;
    return [__FlutterOupayPlugin handleOpenURL:url];
}

//回调通知
- (BOOL)handleOpenURL:(NSURL*)url {
    NSLog(@"reslut = %@",url);
    if( [url.scheme isEqualToString:self.alipay_urlScheme] ){
        return [OupayAlipay handleOpenURL:url result:self.__result];
    }else if( [url.scheme isEqualToString:self.wechat_urlScheme] ){
        return [OupayWechat handleOpenURL:url result:self.__result];
    }else if( [url.scheme isEqualToString:self.uppay_urlScheme] ){
        return [OupayUnionPay handleOpenURL:url result:self.__result];
    }else if( [url.scheme isEqualToString:self.cmb_urlScheme] ){
        return [OupayCMBPay handleOpenURL:url result:self.__result];
    }
    
    return NO;
}

@end
