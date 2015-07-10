//
//  ProjectDefinition.h
//  CTDemo
//
//  Created by LJ on 15/7/2.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//
//


#ifdef DEBUG
#define DEBUG_LOG(...) NSLog(__VA_ARGS__)
#define DEBUG_LOGMETHOD() NSLog(@"file:%s\nfunction:%s\nline:%d\n",__FILE__, __func__,__LINE__)
#else
#define DEBUGLOG(...)
#define DEBUGMETHOD()
#endif

/**
 *  颜色
 */
#define RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0f]

/**
 *  版本
 */
#define IOS_VERSION [[UIDevice currentDevice].systemVersion floatValue]
/**
 *  大于等于__V 版本
 */
#define IOS_VERSION_BIGEREQUAL(__V) (IOS_VERSION > __V || IOS_VERSION == __V)?YES:NO
/**
 *  工程版本
 */
#define BUNDLE_VERSION  [[NSBundle mainBundle].infoDictionary objectForKey:(NSString *)kCFBundleVersionKey]

/**
 *  沙盒路径
 */
#define DOCUMENTPATH  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
/**
 *  __NAME 文件的路径
 */
#define PATH_FOR_FILE(__NAME) [DOCUMENTPATH stringByAppendingPathComponent:__NAME]

/**
 *  判断字符串是否为数字
 */
#define IS_NUMBER_STR(__STR) [[NSScanner scannerWithString:__STR] scanInt:nil]


// 使用ARC
#if __has_feature(objc_arc)

#else

#endif