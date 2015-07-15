//
//  ViewController.m
//  Interceptor
//
//  Created by casa on 4/17/15.
//  Copyright (c) 2015 alibaba. All rights reserved.
//

#import "ViewController.h"
#import "SecondVC.h"

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 60, 30);
    [btn setTitle:@"tap" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void) tap:(id)sender{
    SecondVC *second = [[SecondVC alloc]init];
    [self presentViewController:second animated:YES completion:nil];
}
@end
