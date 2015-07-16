//
//  ViewController.m
//  StackPush
//
//  Created by LJ on 15/7/7.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "ThirdVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClickedAction:(id)sender {
//    [self performSegueWithIdentifier:@"showDetail" sender:nil];
    ThirdVC *th = [[ThirdVC alloc]init];
    [self.navigationController pushViewController:th animated:YES];
    
    [self test];
    
}

-(void)test{
    float sum = 0;
    for (int i = 0; i< 1000000000; i++) {
        sum += i * 0.3 - 7/2 + i%5;
    }
}

@end
