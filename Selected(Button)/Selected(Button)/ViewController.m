//
//  ViewController.m
//  Selected(Button)
//
//  Created by LJ on 15/4/14.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "KeyboradManagement.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *str = @"1211212";
    CGRect rect = [str boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:64]} context:nil];
    NSLog(@"%@",NSStringFromCGRect(rect));
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 60, 100, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.tintColor = [UIColor redColor];
    
    [self.view addSubview:textField];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)assertTestAction:(id)sender {
    
    //发邮件:
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://cenkh@outlook.com"]];
    
    //
    NSDictionary *testDic = @{@"test":@[@"ddddddd",@"dfjdjfldjf",@"88373733"]};
    NSArray *testArr = testDic[@"test"];
    for (NSDictionary *test in testArr) {
        NSAssert([test isKindOfClass:[NSString class]], @"不是字符串");
        NSLog(@"%@",test);
    }
}

@end
