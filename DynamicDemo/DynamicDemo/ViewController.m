//
//  ViewController.m
//  DynamicDemo
//
//  Created by LJ on 15/7/22.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "CKHDictionary.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CKHDictionary *dic = [[CKHDictionary alloc]init];
    dic.string = @"动态方法解析";
    dic.date = [NSDate date];
    NSLog(@"%@%@",dic.string,dic.date);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
