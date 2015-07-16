//
//  BugReporter.h
//  ExceptionTest
//
//  Created by LJ on 15/7/16.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BugReporter : NSObject

+ (NSUncaughtExceptionHandler *) uncaughtExceptionHandler;
+ (void) bugReport;

@end
