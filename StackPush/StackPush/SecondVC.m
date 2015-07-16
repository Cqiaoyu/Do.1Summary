//
//  SecondVC.m
//  StackPush
//
//  Created by LJ on 15/7/7.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "SecondVC.h"
#import "ThirdVC.h"

@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    ThirdVC *th = [[ThirdVC alloc]init];
    NSLog(@"#第二个#%@",_dic);
//    float sum = 0;
//    for (int i = 0; i< 1000000000; i++) {
//        sum += i * 0.3 - 7/2 + i%5;
//    }
//    [self.navigationController pushViewController:th animated:YES];
//    NSLog(@"%f",sum);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
