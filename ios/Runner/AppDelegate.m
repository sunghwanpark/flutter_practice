#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
  [GMSServices provideAPIKey:@""];
  [GeneratedPluginRegistrant registerWithRegistry:self];

  if (@available(iOS 10.0, *))
  {
    [UNUserNotificationCenter currentNotificationCenter].delegate = (id<UNUserNotificationCenterDelegate>) self;
  }

  if(![[NSUserDefaults standardUserDefaults]objectForKey:@"Notification"])
  {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Notification"];
  }
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}





@end
