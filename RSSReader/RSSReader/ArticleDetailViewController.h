//
//  ArticleDetailViewController.h
//  RSSReader
//
//  Created by LJ on 15/7/28.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleDetailViewController : UIViewController
@property (nonatomic, strong) NSString *urlStr;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
