//
//  ViewController.m
//  StackPush
//
//  Created by LJ on 15/7/7.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "ThirdVC.h"
#import "SecondVC.h"

@interface ViewController (){
    NSMutableDictionary *testDic;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    testDic = [NSMutableDictionary dictionary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClickedAction:(id)sender {
//    [self performSegueWithIdentifier:@"showDetail" sender:nil];
    ThirdVC *th = [[ThirdVC alloc]init];
    th.dic = testDic;
//    [self.navigationController pushViewController:th animated:YES];
    [self presentViewController:th animated:YES completion:nil];
//    [self performSegueWithIdentifier:@"showDetail" sender:nil];
    [self test];
    
}

-(void)test{
    float sum = 0;
    for (int i = 0; i< 100000; i++) {
        sum += i * 0.3 - 7/2 + i%5;
        [testDic setObject:[NSNumber numberWithInt:sum] forKey:[NSString  stringWithFormat:@"%d",i]];
//        NSLog(@"@输出@%d",i);
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SecondVC *sec = segue.destinationViewController;
    sec.dic = testDic;
}

@end
