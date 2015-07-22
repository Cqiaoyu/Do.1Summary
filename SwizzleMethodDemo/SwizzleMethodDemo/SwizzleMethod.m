//
//  SwizzleMethod.m
//  SwizzleMethodDemo
//
//  Created by LJ on 15/7/21.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "SwizzleMethod.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>


@interface UIViewController (SwizzleViewController)


@end

@implementation UIViewController (SwizzleViewController)



@end





@implementation SwizzleMethod


+(void)load{
    [super load];
    [SwizzleMethod shareInstance];
}

+ (instancetype)shareInstance{
    static SwizzleMethod *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (instance == nil) {
            instance = [[SwizzleMethod alloc]init];
        }
    });
    return instance;
    
}
- (instancetype)init{
    if (self = [super init]) {
        [self swizzleMethod];
    }
    return self;
}
- (void)swizzleMethod{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        /*--UIViewController--*/
        Method orgLoadViewMethod = class_getInstanceMethod([UIViewController class], @selector(loadView));
        Method swizzleLoadViewMethod = class_getInstanceMethod([self class], @selector(swizzleLoadView));
        Method dd = class_getInstanceMethod([UIViewController class], @selector(swizzleLoadView));
        BOOL addMethod = class_addMethod([UIViewController class], @selector(swizzleLoadView), method_getImplementation(swizzleLoadViewMethod), method_getTypeEncoding(swizzleLoadViewMethod));
        if (addMethod) {
//            class_replaceMethod([UIViewController class], @selector(loadView), method_getImplementation(swizzleLoadViewMethod), method_getTypeEncoding(swizzleLoadViewMethod));
            method_setImplementation(dd, method_getImplementation(swizzleLoadViewMethod));
            method_exchangeImplementations(orgLoadViewMethod, dd);
        }
        else{
            method_exchangeImplementations(orgLoadViewMethod, swizzleLoadViewMethod);
        }
        
    });
}


- (void)swizzleLoadView{//实际的run方法的实现，调用swizzleLoadView方法时实际上是调用run方法
    [self swizzleLoadView];
    //调用run方法时，实际上是调用此方法
    NSLog(@"$$再跑$$");
    
}

@end

