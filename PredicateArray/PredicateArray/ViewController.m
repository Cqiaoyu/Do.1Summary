//
//  ViewController.m
//  PredicateArray
//
//  Created by LJ on 15/7/28.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//  过滤数组

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *a1 = @[@"purchase",@"preStore",@"packageFor",@"changeCard",@"resetPassword",@"FunctionCancel",@"payment",@"stopOrStart",@"realName",@"complex",@"openAccount",@"orderManagement",@"setUp"];
    
    NSArray *a2 = @[@"packageFor",@"purchase",@"preStore",@"343434",@"changeCard",@"resetPassword",@"FunctionCancel",@"orderManagement",@"payment",@"stopOrStart",@"realName",@"complex",@"openAccount",@"cenkh",@"wwwwww"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"self in %@",a1];
    NSArray *a3 = [a2 filteredArrayUsingPredicate:pre];
    NSLog(@"%@",a3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
