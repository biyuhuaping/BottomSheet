//
//  AppDelegate.m
//  Test
//
//  Created by ZB on 2022/6/27.
//

#import "AppDelegate.h"
#import "MapViewController.h"
#import "CountriesTableViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]) {
        NSLog(@"已越狱");
    }else{
        NSLog(@"未越狱");
    }
    
    MapViewController *mapVC = [[MapViewController alloc]init];
    CountriesTableViewController *shortcutsVC = [[CountriesTableViewController alloc]init];
    
    self.window.rootViewController = [[ViewController alloc]initWithMainViewController:mapVC sheetViewController:shortcutsVC];
    // 显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}

@end
