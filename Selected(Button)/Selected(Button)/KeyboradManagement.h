//
//  KeyboradManagement.h
//  Selected(Button)
//
//  Created by LJ on 15/6/26.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//  键盘管理
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#define kKeyboradManagementNotificationName

@interface KeyboradManagement : NSObject
@property (strong, nonatomic) NSString *name;
+ (KeyboradManagement *)management;

@end
