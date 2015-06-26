//
//  AppDelegate.m
//  ExceptionTest
//
//  Created by LJ on 15/5/13.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"bugReport"];
    [self sendBugReportWithFilePath:path];
    
    return YES;
}

void UncaughtExceptionHandler(NSException * exception){
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *callStackStr = nil;
    for (NSString *str in callStack) {
        callStackStr = [NSString stringWithFormat:@"%@%@\n",callStackStr,str];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *reporter = [NSString stringWithFormat:@"%@\n%@\n%@\n\n%@",dateStr,name,reason,callStackStr];
    NSError *error = nil;
    [reporter writeToFile:[NSTemporaryDirectory() stringByAppendingPathComponent:@"bugReport"] atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

- (void)sendBugReportWithFilePath:(NSString *)path{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //
        NSString *bug = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSString *from = @"cenkh@outlook.com";
        NSString *to = @"1250578320@qq.com";
        NSString *urlStr = [NSString stringWithFormat:@"mailto:%@?cc=%@&subject=bug报告!&body=%@",to,from,bug];
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
