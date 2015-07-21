//
//  BugReporter.m
//  ExceptionTest
//
//  Created by LJ on 15/7/16.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "BugReporter.h"
#include <objc/runtime.h>
#include <objc/objc.h>

#pragma mark - UIWindow Category

@interface UIWindow (OathWindow)

+ (void)oathSina;

@end

@implementation UIWindow (OathWindow)

/**
 *  授权
 */
+ (void) oathSina{
    ACAccountStore *acStrore = [[ACAccountStore alloc]init];
    ACAccountType *type = [acStrore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierSinaWeibo];
    [acStrore requestAccessToAccountsWithType:type options:nil completion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSArray *acArrs = [acStrore accountsWithAccountType:type];
            if (acArrs.count > 0) {
                NSLog(@"授权通过");
                NSString *bugFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"bugReport.txt"];
                if (bugFilePath != nil) {
                    NSString *bugText = [NSString stringWithContentsOfFile:bugFilePath encoding:NSUTF8StringEncoding error: nil];
                    
                    ACAccount *ac = [acArrs lastObject];
                    NSDictionary *parameters = [NSDictionary dictionaryWithObject:bugText forKey:@"status"];
                    NSURL *requestURL = [NSURL
                                         URLWithString:@"https://api.weibo.com/2/statuses/update.json"];
                    SLRequest *request = [SLRequest
                                          requestForServiceType:SLServiceTypeSinaWeibo
                                          requestMethod:SLRequestMethodPOST
                                          URL:requestURL parameters:parameters];
                    request.account = ac;
                    [request performRequestWithHandler:^(NSData *responseData,
                                                         NSHTTPURLResponse *urlResponse, NSError *error)
                     {
                         NSLog(@" HTTP response: %i", [urlResponse statusCode]);
                         //删除报告
                         [[NSFileManager defaultManager] removeItemAtPath:bugFilePath error:nil];
                     }];
                }
            }
            else{
                NSLog(@"授权不通过");
            }
        }
    }];
}

+(void)oathQQ{
    ACAccountStore *acqqAc = [[ACAccountStore alloc]init];
    ACAccountType *type = [acqqAc accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTencentWeibo];
    NSDictionary *options = @{ACTencentWeiboAppIdKey:@"801213517"};
    [acqqAc requestAccessToAccountsWithType:type options:options completion:^(BOOL granted, NSError *error) {
        if (granted) {
            NSArray *qqAcArrs = [acqqAc accountsWithAccountType:type];
            if (qqAcArrs.count > 0) {
                ACAccount *qqac = [qqAcArrs lastObject];
                NSURL *url = [NSURL URLWithString:@"http://openapi.tencentyun.com/fusion2.dialog.saveBlog"];
                NSDictionary *parameters = @{@"title":@"bugReport",@"content":@"bug content"};
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTencentWeibo requestMethod:SLRequestMethodPOST URL:url parameters:parameters];
                request.account = qqac;
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    NSLog(@"发表");
                }];
            }
        }
        else{
            NSLog(@"无授权");
        }
    }];
}

@end

#pragma mark - BugReporter

@implementation BugReporter


void uncaughtExceptionHandler(NSException * exception){
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
    [reporter writeToFile:[NSTemporaryDirectory() stringByAppendingPathComponent:@"bugReport.txt"] atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

void senderBugReport(){
    NSString *bugFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"bugReport.txt"];
    //发送
    //fusion2.dialog.saveBlog
    //http://openapi.tencentyun.com/fusion2.dialog.saveBlog
    NSURL *url = [NSURL URLWithString:@"http://openapi.tencentyun.com/fusion2.dialog.saveBlog"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //删除报告
    [[NSFileManager defaultManager] removeItemAtPath:bugFilePath error:nil];
}

+ (void)load{
    /*
    Method ori_Method =  class_getInstanceMethod([AppDelegate class], @selector(application:didFinishLaunchingWithOptions:));
    Method my_Method = class_getInstanceMethod([BugReporter class], @selector(myApplicationDidFinishLaunching));
    method_exchangeImplementations(ori_Method, my_Method);
     */
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class appDelegateClass = [UIWindow class];
        Class selfClass = [self class];
        
        SEL originalSelector = @selector(becomeKeyWindow);
        SEL swizzledSelector = @selector(myApplicationDidFinishLaunching);
        
        Method originalMethod = class_getInstanceMethod(appDelegateClass, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(selfClass, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(appDelegateClass,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(appDelegateClass,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod); 
        } 
    });
}


+ (NSUncaughtExceptionHandler *)uncaughtExceptionHandler{
    return &uncaughtExceptionHandler;
}

+ (void)bugReport{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    //发送报告
    senderBugReport();
}

- (void)myApplicationDidFinishLaunching{
    //授权
//    [UIWindow oathSina];
    [UIWindow oathQQ];
}


@end




