//
//  TestModel.m
//  PredicateDemo
//
//  Created by LJ on 15/7/14.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (NSString *)description{
    NSString *desc = [NSString stringWithFormat:@"\nname:%@\nprodID:%@\nage:%@\nheight:%@\nwight:%@\n",self.name,self.prodID,self.age,self.height,self.wight];
    return desc;
}

+ (TestModel *)getTestModelInstance{
    TestModel *instance = [[TestModel alloc]init];
    return instance;
}

@end
