//
//  TestModel.h
//  PredicateDemo
//
//  Created by LJ on 15/7/14.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *prodID;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *wight;

+ (TestModel *)getTestModelInstance;

@end
