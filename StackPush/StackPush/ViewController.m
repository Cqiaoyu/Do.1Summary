//
//  ViewController.m
//  StackPush
//
//  Created by LJ on 15/7/7.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"

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
    [self performSegueWithIdentifier:@"showDetail" sender:nil];
}

@end
