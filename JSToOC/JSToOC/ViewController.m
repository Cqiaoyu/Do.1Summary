//
//  ViewController.m
//  JSToOC
//
//  Created by LJ on 15/5/7.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>{
    UIWebView *web;
    NSArray *datas;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    web.delegate = self;
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *contentPath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSURL *baseURl = [NSURL URLWithString:path];
    NSString *content = [NSString stringWithContentsOfFile:contentPath encoding:NSUTF8StringEncoding error:nil];
    [web loadHTMLString:content baseURL:baseURl];
    [self.view addSubview:web];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = {{250,100},{100,30}};
    button.frame = frame;
    [button setTitle:@"选择" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(sckipToSetting:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"btn_未选中01.png"] forState:UIControlStateNormal];
    [web addSubview:button];
    
    datas = @[@"dkfjsdjfldjlfjsljfldjfljsljflsjldfjldjfljsdf",@"忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘记来忘来",@"374837493",@"00",@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"];
}
- (void)sckipToSetting:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
    UIButton *button = (UIButton *)sender;
    button.selected = YES;
}
- (IBAction)testAction:(id)sender {
    _btnTest.selected = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    if ([[url scheme] isEqualToString:@"ckh"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[url absoluteString] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            //确定
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    //截取
    NSString *btn = [NSString stringWithFormat:@""];
    
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self performSelector:@selector(showText:) withObject:nil afterDelay:0.05];
}


- (IBAction)showText:(id)sender{
    for (NSString *content in datas) {
        NSString *js = @"var p = document.createElement('div');"
        "p.innerText = '%@';"
        "document.body.appendChild(p);";
        NSString *divJS = @"var div = document.createElement('div');"
        "div.innerText = '%@';"
        "div.style.background = \"\";"
        "div.style.color = \"\";"
        "div.style.border = \"1px solid #ABC\";"
        "div.style.borderRadius = \"5px\";"
        "div.style.padding = \"5px\";"
        "document.body.appendChild(div);"
        "var br = document.createElement('br');"
        "document.body.appendChild(br);";
        NSString *excjs = [NSString stringWithFormat:divJS,content];
        [web stringByEvaluatingJavaScriptFromString:excjs];
    }
}


@end
