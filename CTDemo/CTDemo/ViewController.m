//
//  ViewController.m
//  CTDemo
//
//  Created by LJ on 15/7/1.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DEBUG_LOG(@"dddds");
    DEBUG_LOG(@"%@%@%@%@",@"ddd",@"4333",@"&&&&",@"(((");
    DEBUG_LOGMETHOD();
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 33, 202, 11)];
    label.backgroundColor = RGB(123, 22, 87);
    [self.view addSubview:label];
    if (IOS_VERSION_BIGEREQUAL(8)) {
        DEBUG_LOG(@"是");
    }
    DEBUG_LOG(@"%@",BUNDLE_VERSION);
    DEBUG_LOG(@"%@",DOCUMENTPATH);
    NSString *path = DOCUMENTPATH;
    
    NSData *data = [[NSData alloc] initWithBytes:[[path dataUsingEncoding:NSUTF8StringEncoding] bytes] length:[path length]];
    [data writeToFile:SAVEFILE(@"text.txt") atomically:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
