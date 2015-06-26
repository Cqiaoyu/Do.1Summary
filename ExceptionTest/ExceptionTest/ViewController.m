//
//  ViewController.m
//  ExceptionTest
//
//  Created by LJ on 15/5/13.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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
- (IBAction)testAction:(id)sender {
    NSDate *start = [NSDate date];
//    NSArray *arr = [NSArray array];
//    NSDictionary *dic = @{@"test":arr};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGRect ivFrame = {{20,200},{280,150}};
        UIImageView *iv = [[UIImageView alloc]initWithFrame:ivFrame];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/7a899e510fb30f240db64cbfcb95d143ad4b0359.jpg"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            iv.image = [UIImage imageWithData:data];
            [self.view addSubview:iv];
            NSDate *end = [NSDate date];
            NSLog(@"##2:%f",[end timeIntervalSinceDate:start]);
        });
    });
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/7a899e510fb30f240db64cbfcb95d143ad4b0359.jpg"]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        CGRect ivFrame = {{20,30},{280,150}};
        UIImageView *iv = [[UIImageView alloc]initWithFrame:ivFrame];
        iv.image = [UIImage imageWithData:data];
        [self.view addSubview:iv];
        NSDate *end = [NSDate date];
        NSLog(@"##1:%f",[end timeIntervalSinceDate:start]);
    }];
    
    
    NSString *str = @"";
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dic = @{@"test":[NSNull null]};
    str = dic[@"test"];
    [arr addObject:str];
    NSLog(@"%@",arr);
    NSArray *testArr = @[@"djfdj",@"ddfdf"];
    NSLog(@"%@",testArr[2]);
    
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear | UIImagePickerControllerCameraDeviceFront]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        picker.showsCameraControls = NO;
        CGRect frame = {{50,100},{200,200}};
        UIView *overlayView = [[UIView alloc]initWithFrame:frame];
        overlayView.backgroundColor = [UIColor redColor];
        picker.cameraOverlayView = overlayView;
        picker.cameraViewTransform = CGAffineTransformMakeRotation(90);
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker popoverPresentationController];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker popoverPresentationController];
}

@end
