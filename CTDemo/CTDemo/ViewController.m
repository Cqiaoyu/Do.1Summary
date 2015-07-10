//
//  ViewController.m
//  CTDemo
//
//  Created by LJ on 15/7/1.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h" 



@interface ViewController ()<UITextFieldDelegate>

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
    [data writeToFile:PATH_FOR_FILE(@"text.txt") atomically:YES];
    
    if (IS_NUMBER_STR(@"wm")) {
        DEBUG_LOG(@"是数字");
    }else{
        DEBUG_LOG(@"不是数字");
    }
    
    
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(21, 55, 100, 30)];
    field.delegate = self;
    field.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:field];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
}
- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    DEBUG_LOG(@"开始");
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    DEBUG_LOG(@"结束");
    
}

- (void) keyboardHide:(NSNotification *)noti{
    DEBUG_LOG(@"隐藏");
    
}
- (IBAction)tapAction:(id)sender {
    [self test];
}

- (void) test{
    
}
//单例
+ (instancetype) shareInstance{
    static dispatch_once_t onceToken;
    static ViewController *shareInstance = nil;
    dispatch_once(&onceToken, ^{
        shareInstance = [[ViewController alloc]init];
    });
    return shareInstance;
}


@end
