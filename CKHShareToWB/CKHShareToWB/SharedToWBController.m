//
//  SharedToWBController.m
//  ShareDemo
//
//  Created by cenkh on 14-7-13.
//  Copyright (c) 2014年 cenkh. All rights reserved.
//

#import "SharedToWBController.h"
#import "constant.h"
#import "Reachability.h"

@interface SharedToWBController (){
    UIViewController *rootController;   //显示的根视图
    NSMutableArray *idols;      //包含name、nick的“我收听的人”列表
    UIAlertView *reachAlert;
}

@end

@implementation SharedToWBController
@synthesize weiApi;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)init{
    if (self = [super init]) {
        if (weiApi == nil) {
            weiApi = [[WeiboApi alloc]initWithAppKey:TCAppKey andSecret:TCAppSecret andRedirectUri:REDIRECTURI andAuthModeFlag:0 andCachePolicy:0];
        }
    }
    return self;
}

//保存我收听的人的的文件路径
/*
-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return [path stringByAppendingPathComponent:@"idolsList"];
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//开始分享
-(void)shareWithRootController:(UIViewController *)root{
    rootController = root;
    UIAlertView *shareAlert = [[UIAlertView alloc]initWithTitle:@"分享到我的微博" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"新浪微博",@"腾讯微博", nil];
    [shareAlert show];
}

/**
 * @brief  处理微博客户端唤回后的回调数据
 * @note   处理微博客户端通过URL启动App时传递的数据,需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @note   需同时在 URL Types 里面添加urlscheme wbxxxx,其中xxxx为注册应用时获得的appkey，如wb801213517
 * @note   sourceApplication的来源可能是大写，也可能是小写（于iOS 系统版本有关），如果需要用这个参数判断来源，请做好兼容。
 * @param  INPUT  url     启动App的URL
 * @return YES 成功返回
 * @return NO  失败返回
 */
-(BOOL)handleOpenURL:(NSURL *)url{
    return [weiApi handleOpenURL:url];
}
-(BOOL)handleSinaOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}


-(void)shareMessageToSina{
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"天下之大，四海为家!";
    if ([self.defaultText length] != 0) {
        message.text = self.defaultText;
    }
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    [WeiboSDK sendRequest:request];
}
//检查授权是否有效
-(void)checkAuthTC{
    [weiApi checkAuthValid:TCWBAuthCheckServer andDelegete:self];
}
//发送消息
-(int)shareMessageToTCWithInfo:(NSMutableDictionary *)info{
    int result =  [weiApi requestWithParams:info apiName:@"t/add_pic" httpMethod:@"POST" delegate:self];
    NSLog(@"%d",result);
    return result;
}
//获取腾讯微博我关注的人
-(void)getWeiboIdolList{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                                   @"json",@"format",
                                   @"200",@"reqnum",
                                   @"0",@"startindex",
                                   nil];
    [weiApi requestWithParams:params apiName:@"friends/idollist_s" httpMethod:@"POST" delegate:self];
}
-(void)dismissAlertView{
    [reachAlert dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - alertView delegate -
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            //取消
            break;
        }
        case 1:{
            //新浪
            [self shareMessageToSina];
            break;
        }
        case 2:{
            //腾讯
            Reachability *reachability = [Reachability reachabilityForInternetConnection];
            NetworkStatus statu = reachability.currentReachabilityStatus;
            if (statu == NotReachable) {
                reachAlert = [[UIAlertView alloc]initWithTitle:nil message:@"当前网络不可用" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
                [reachAlert show];
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismissAlertView) userInfo:nil repeats:NO];
            }
            else{
                [self checkAuthTC];
            }
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - WeiboAuthDelegate -
-(void)didCheckAuthValid:(BOOL)bResult suggest:(NSString *)strSuggestion{
    if (bResult) {//授权有效,弹出编辑框
        EditTCWeiboController *editWeibo = [[EditTCWeiboController alloc]init];
        editWeibo.SMDelegate = self;
        [self getWeiboIdolList];
        editWeibo.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        editWeibo.defaultText = self.defaultText;
        [rootController presentViewController:editWeibo animated:YES completion:nil];
    }
    else{//授权无效,重新授权
        [weiApi loginWithDelegate:self andRootController:rootController];
    }
}
-(void)DidAuthFinished:(WeiboApiObject *)wbobj{
    EditTCWeiboController *editWeibo = [[EditTCWeiboController alloc]init];
    editWeibo.SMDelegate = self;
    [self getWeiboIdolList];
    editWeibo.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [rootController presentViewController:editWeibo animated:YES completion:nil];
}


#pragma mark -TCWeiboRequest Delegate-
-(void)didReceiveRawData:(NSData *)data reqNo:(int)reqno{
    //NSString *idolData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //写进plist文件中，json解析
    idols = [[NSMutableArray alloc]init];
    NSDictionary *idolDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *idolList = [[idolDic objectForKey:@"data"] objectForKey:@"info"];
    for (NSDictionary *aIdol in idolList) {
        NSString *idolName = [aIdol objectForKey:@"name"];
        NSString *idolNick = [aIdol objectForKey:@"nick"];
        NSDictionary *aIdolInfo = [NSDictionary dictionaryWithObjectsAndKeys:idolName,@"name",idolNick,@"nick", nil];
        [idols addObject:aIdolInfo];
    }
}


#pragma mark - sendMessage delegate -
-(int)sendMessageWithInfo:(NSMutableDictionary *)info{
    return [self shareMessageToTCWithInfo:info];
}
-(void)getIdolList{
    [self getWeiboIdolList];
}
-(NSArray *)myIdols{
    return idols;
}

#pragma mark - sina Request Delegate -
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    [self.sinaReqDelegate didReceiveSinaWeiboRequest:request];
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    [self.sinaReqDelegate didReceiveSinaWeiboResponse:response];
}



@end
