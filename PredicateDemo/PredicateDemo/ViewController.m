//
//  ViewController.m
//  PredicateDemo
//
//  Created by LJ on 15/7/14.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"

@interface ViewController ()<UITextFieldDelegate>{
    NSString *text;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_field1 addTarget:self action:@selector(endInput:) forControlEvents:UIControlEventEditingChanged];
    [_field1 addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
    
    NSDictionary *dic1 = @{@"name":@"2323",@"prodID":@"2323",@"age":@"2323",@"height":@"2323",@"wight":@"2323"};
    NSDictionary *dic2 = @{@"name":@"12",@"prodID":@"11",@"age":@"23",@"height":@"44",@"wight":@"33"};
    NSDictionary *dic3 = @{@"name":@"22",@"prodID":@"33",@"age":@"55",@"height":@"77",@"wight":@"22"};
    
    TestModel *model1 = [TestModel getTestModelInstance];
    [model1 setValuesForKeysWithDictionary:dic1];
    TestModel *model2 = [TestModel getTestModelInstance];
    [model2 setValuesForKeysWithDictionary:dic2];
    TestModel *model3 = [TestModel getTestModelInstance];
    [model3 setValuesForKeysWithDictionary:dic3];
    NSArray *arr = @[model1,model2,model3];
    NSArray *arrA = @[dic1,dic2,dic3];
    
    NSDictionary *dict1 = @{@"name":@"2323",@"prodID":@"2323",@"age":@"55",@"height":@"77",@"wight":@"22"};
    NSDictionary *dict2 = @{@"name":@"",@"prodID":@"2323",@"age":@"55",@"height":@"77",@"wight":@"22"};
    
    TestModel *model4 = [TestModel getTestModelInstance];
    [model4 setValuesForKeysWithDictionary:dict1];
    TestModel *model5 = [TestModel getTestModelInstance];
    [model5 setValuesForKeysWithDictionary:dict2];
    NSArray *arr2 = @[model4,model4];
    NSArray *arrA2 = @[dict1,dict2];
    
    for (int i = 0 ; i < 3; i++) {
        TestModel *local = arr[i];//模拟本地
        for (int j = 0; j<2; j++) {
            TestModel *web = arr2[j];//模拟服务返回数据
            NSPredicate *pre = [NSPredicate predicateWithFormat:@"self.prodID == %@",dict1[@"prodID"]];
            if ([pre evaluateWithObject:local]) {
                NSLog(@"%ld:%@",i,[local description]);
            }
        }
        
    }
    for (int i = 0 ; i < 3; i++) {
        NSDictionary *local = arrA[i];//模拟本地
        for (int j = 0; j<2; j++) {
            NSDictionary *web = arrA2[j];//模拟服务返回数据
            NSPredicate *pre = [NSPredicate predicateWithFormat:@"prodID == %@",dict1[@"prodID"]];
            if ([pre evaluateWithObject:local]) {
                NSLog(@"#字典# %ld:%@",i,[local description]);
            }
        }
        
    }
    
    
    for (int i = 0; i < 10; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = [NSString stringWithFormat:@"%d",i];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_服务办理-1.png"] forState:UIControlStateSelected];
        button.frame = CGRectMake(70 * (i/2) + 20, 50 * (i%2) + 90, 70, 30);
        button.tag = 1000 * (i + 1);
        [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        if (i % 4 == 0) {
            UIButton *selectedBtn = (UIButton *)[self.view viewWithTag:1000 * (i + 1)];
            [self selected:selectedBtn];
        }
    }
    
}

- (void)selected:(id)sender{
    UIButton *button = (UIButton *)sender;
    NSUInteger selected = button.tag/1000 - 1;
    UIButton *btn = (UIButton *)[self.view viewWithTag:(selected + 1) * 1000];
    btn.selected = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _field1) {
        NSLog(@"**1");
        return YES;
    }
    if (textField == _field2) {
        NSLog(@"**2");
        _field2.text = @"";
        return YES;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == _field1) {
        NSLog(@"###1");
    }
    if (textField == _field2) {
        NSLog(@"###2");
        _field2.text = @"";
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"编辑11");
    NSScanner *scanner = [NSScanner scannerWithString:string];
    if (![scanner scanInt:nil] && ![string isEqualToString:@""]) {
        return NO;
    }else if (textField.text.length > 1) {
        return NO;
    }
    text = string;
    if (textField == _field1) {
//        [_field1 resignFirstResponder];
    }
    else if (textField == _field2){
//        [_field2 resignFirstResponder];
    }
    else{

    }
    string = @"";
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return NO;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"@@@%@",textField.text);
    if (textField == _field1) {
        NSLog(@"$$1");
//        [_field2 becomeFirstResponder];
        
    }
    if (textField == _field2) {
        NSLog(@"$$2");

    }
}

-(void)endInput:(id)sender{
    NSLog(@"编辑22%@",sender);
    [_field1 resignFirstResponder];
//    [_field2 becomeFirstResponder];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"!!!%@",keyPath);
}


@end
