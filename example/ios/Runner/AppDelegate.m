#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <flutter_oupay/FlutterOupayPlugin.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

/**
回调通知
*/
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [FlutterOupayPlugin handleOpenURL:url];
}
// ios 9.0+
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [FlutterOupayPlugin handleOpenURL:url];
}

@end
