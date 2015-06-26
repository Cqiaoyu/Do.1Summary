//
//  KeyboradManagement.m
//  Selected(Button)
//
//  Created by LJ on 15/6/26.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "KeyboradManagement.h"
#import "libkern/OSAtomic.h"
#import "execinfo.h"


@interface KeyboradManagement ()<NSCopying>

@end
@implementation KeyboradManagement
static KeyboradManagement *management = nil;

+ (KeyboradManagement *)management{
    @synchronized (self){
        if (management == nil) {
            management = [[KeyboradManagement alloc]init];
            [[NSNotificationCenter defaultCenter] addObserver:management selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
            
        }

    }
    return management;
}
- (void)keyboardDidShow:(NSNotification *)noti {
    NSLog(@"返回%@\nuserInfo:%@\n%s\n",noti.name,noti.userInfo,__PRETTY_FUNCTION__);
    NSLog(@"%@\n",NSStringFromSelector(_cmd));
    
    //获取运行栈信息
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (i = 0;i < 20 ;i++){
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
        
    }
    free(strs);
    NSLog(@"====================堆栈\n %@ \n ",backtrace);
    
}

//覆盖初始化方法和copy协议
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (management == nil) {
        management = [super allocWithZone:zone];
    }
    return management;
}
- (id)copyWithZone:(NSZone *)zone{
    return management;
}


@end
