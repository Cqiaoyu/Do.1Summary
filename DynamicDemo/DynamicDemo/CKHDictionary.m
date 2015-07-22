//
//  CKHDictionary.m
//  DynamicDemo
//
//  Created by LJ on 15/7/22.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "CKHDictionary.h"
#import <objc/runtime.h>

@interface CKHDictionary ()
@property (nonatomic, strong) NSMutableDictionary *storeDic;
@end

@implementation CKHDictionary
@dynamic string,number,date,option;

-(instancetype)init{
    if (self = [super init]) {
        _storeDic = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *selecterStr = NSStringFromSelector(sel);
    if ([selecterStr hasPrefix:@"set"]) {
        //setter方法
        class_addMethod([self class], sel, (IMP)ckhDictionarySetter, "v@:@");
    }
    else{//非setter方法
        class_addMethod([self class], sel, (IMP)ckhDictionaryGetter, "@@:");
    }
    return YES;
}

void ckhDictionarySetter(id self, SEL _cmd,id value){//setter
    CKHDictionary *ckhDictionarySelf = (CKHDictionary *)self;
    NSMutableDictionary *storeDic = ckhDictionarySelf.storeDic;
    NSString *selecter = NSStringFromSelector(_cmd);
    NSMutableString *key = [selecter mutableCopy];
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    NSString *lowercaseFirst = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirst];
    if (value) {
        [storeDic setObject:value forKey:key];
    }else{
        [storeDic removeObjectForKey:key];
    }
}

id ckhDictionaryGetter(id self, SEL _cmd){//getter
    CKHDictionary *ckhDictionarySelf = (CKHDictionary *)self;
    NSMutableDictionary *storeDic = ckhDictionarySelf.storeDic;
    NSString *key = NSStringFromSelector(_cmd);
    return [storeDic objectForKey:key];
}


@end
