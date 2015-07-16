//
//  BugReporter.m
//  ExceptionTest
//
//  Created by LJ on 15/7/16.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "BugReporter.h"

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


+ (NSUncaughtExceptionHandler *)uncaughtExceptionHandler{
    return &uncaughtExceptionHandler;
}

+ (void)bugReport{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    //发送报告
    senderBugReport();
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




@end
