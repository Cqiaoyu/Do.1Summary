//
//  SwizzleMethod.m
//  SwizzleMethodDemo
//
//  Created by LJ on 15/7/21.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "SwizzleMethod.h"
#import <objc/runtime.h>

@implementation SwizzleMethod

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


+(void)load{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        Method orgMethod = class_getInstanceMethod([Car class], @selector(run));
        Method swizzleMethod = class_getInstanceMethod([self class], @selector(swizzleRun));
//        IMP orgIMP = method_getImplementation(orgMethod);
//        method_setImplementation(swizzleMethod, orgIMP);
//        method_exchangeImplementations(orgMethod, swizzleMethod);//完全替换原有方法
//       BOOL addMethod = class_addMethod([Car class], @selector(run), method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
//        if (addMethod) {
//            NSLog(@"ww");
//        }
        
//        IMP orgimp = class_getMethodImplementation([Car class], @selector(run));
//        class_replaceMethod([self class], @selector(swizzleRun), orgimp, method_getTypeEncoding(orgMethod));
//        method_getImplementation(swizzleMethod);
//        method_setImplementation(swizzleMethod, orgimp);
        
        IMP orgIMP = method_getImplementation(orgMethod);
        method_setImplementation(class_getInstanceMethod([self class], @selector(org)), orgIMP);
        method_exchangeImplementations(swizzleMethod, orgMethod);
    });
}

- (void)orgMethod{
    
}

- (void)newMethod{

}
- (void)swizzleRun{
    SwizzleMethod *s = [SwizzleMethod  shareInstance];
    [s orgMethod];
    NSLog(@"$$再跑$$");
}

- (void)interceptMethod:(Method)orgMethod withImplementationOfMethod:(Method)newMethod withTimeType:(SwizzleMethodTimeOption)timetype{
    
}

@end
