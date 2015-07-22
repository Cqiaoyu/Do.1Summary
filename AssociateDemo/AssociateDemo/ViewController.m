//
//  ViewController.m
//  AssociateDemo
//
//  Created by LJ on 15/7/22.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>


static void *ALERTBUTTONCLICKKEY = "alertbuttonclickkey";

@interface ViewController ()<UIAlertViewDelegate>

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
- (IBAction)oneAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"第一个提示" message:@"这是关联对象应用场景" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    void (^alertButtonClick)(NSUInteger) = ^(NSUInteger buttonIndex){
        if (buttonIndex == 0) {
            NSLog(@"第一个alert取消");
        }
        else{
            NSLog(@"第一个alert确定");
        }
    };
    objc_setAssociatedObject(alert, ALERTBUTTONCLICKKEY, alertButtonClick, OBJC_ASSOCIATION_COPY);
    [alert show];
    
}
- (IBAction)secondAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"第二个提示" message:@"这是关联对象应用场景" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    void (^alertButtonClick)(NSUInteger) = ^(NSUInteger buttonIndex){
        if (buttonIndex == 0) {
            NSLog(@"第二个alert取消");
        }
        else{
            NSLog(@"第二个alert确定");
        }
    };
    objc_setAssociatedObject(alert, ALERTBUTTONCLICKKEY, alertButtonClick, OBJC_ASSOCIATION_COPY);
    [alert show];
}
- (IBAction)thirdAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"第三个提示" message:@"这是关联对象应用场景" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    void (^alertButtonClick)(NSUInteger) = ^(NSUInteger buttonIndex){
        if (buttonIndex == 0) {
            NSLog(@"第三个alert取消");
        }
        else{
            NSLog(@"第三个alert确定");
        }
    };
    objc_setAssociatedObject(alert, ALERTBUTTONCLICKKEY, alertButtonClick, OBJC_ASSOCIATION_COPY);
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    void (^alertClickedAtButtonIndex)(NSUInteger) = objc_getAssociatedObject(alertView, ALERTBUTTONCLICKKEY);
    alertClickedAtButtonIndex(buttonIndex);
}

@end
