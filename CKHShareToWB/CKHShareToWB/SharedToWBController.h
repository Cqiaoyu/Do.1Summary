//
//  SharedToWBController.h
//  ShareDemo
//
//  Created by cenkh on 14-7-13.
//  Copyright (c) 2014年 cenkh. All rights reserved.
//
/**
 *  新浪、腾讯微博分享类
 *
 *  @note weiApi:腾讯微博的分享类
 *      defaultText:需要分享的文本
 *      sinaReqDelegate:新浪对第三方应用的响应协议
 *  @author ckh
 *  @date 2014/07/23
 */
#import <UIKit/UIKit.h>
#import "WeiboApi.h"
#import "EditTCWeiboController.h"
#import "WeiboSDK.h"
#import "CKHShareTCDelegate.h"


@interface SharedToWBController : UIViewController<WeiboAuthDelegate,WeiboRequestDelegate,UIAlertViewDelegate,SendeMessageDelegate,WeiboSDKDelegate>{
    WeiboApi *weiApi;
}
@property(strong, nonatomic) WeiboApi *weiApi;
@property (strong, nonatomic)NSString *defaultText;
@property (strong, nonatomic)id<SinaRequestDelegate>sinaReqDelegate;
/**
 *  分享微博函数
 *
 *  @param root 触发分享的控制器类
 */
-(void)shareWithRootController:(UIViewController *)root;
/**
 * @brief  处理腾讯微博客户端唤回后的回调数据
 * @note   处理微博客户端通过URL启动App时传递的数据,需要在 这个方法是在CKHShareTCDelegate协议中调用的
 * @note   需同时在 URL Types 里面添加urlscheme wbxxxx,其中xxxx为注册应用时获得的appkey，如wb801213517
 * @note   sourceApplication的来源可能是大写，也可能是小写（于iOS 系统版本有关），如果需要用这个参数判断来源，请做好兼容。
 * @param  INPUT  url     启动App的URL
 * @return YES 成功返回
 * @return NO  失败返回
 */
-(BOOL)handleOpenURL:(NSURL *)url;
/**
 *处理新浪微博客户端程序通过URL启动第三方应用时传递的数据
 *这个方法是在CKHShareTCDelegate协议中调用的
 *@param url 启动第三方应用的URL
 *@param delegate WeiboSDKDelegate对象，用于接收微博触发的消息
 *@return YES 成功
 *@return NO  失败
 */
-(BOOL)handleSinaOpenURL:(NSURL *)url;
@end
