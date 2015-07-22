//
//  SwizzleMethod.h
//  SwizzleMethodDemo
//
//  Created by LJ on 15/7/21.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum SwizzleMethodTimeOption {
    SwizzleMethodTimeTypeBefore = 0,
    SwizzleMethodTimeTypeAfter,
    SwizzleMethodTimeTypeReplace
    
} SwizzleMethodTimeOption;

@interface SwizzleMethod : NSObject
@end
