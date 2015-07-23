//
//  EditTCWeiboController.m
//  ShareDemo
//
//  Created by cenkh on 14-7-12.
//  Copyright (c) 2014年 cenkh. All rights reserved.
//

#import "EditTCWeiboController.h"

@interface EditTCWeiboController (){
    UIAlertView *notiAlert;
    UIImageView *backgroundView;
    UIAlertView *delAlert;  //删除一条微博的提示
}

@end

@implementation EditTCWeiboController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
    
    //初始化
    [self initInputView];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
-(void)viewDidAppear:(BOOL)animated{
    [self performSelector:@selector(beginEditText) withObject:nil afterDelay:2.0];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)beginEditText{
    [contentTextView becomeFirstResponder];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [contentTextView resignFirstResponder];
}

//初始化输入视图
-(void)initInputView{
    containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 548)];
    containerView.backgroundColor = [UIColor whiteColor];
    backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 548)];
    backgroundView.image = [UIImage imageNamed:@"textBackground.png"];
    
    titleBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleBar.layer.cornerRadius = 20;
    UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:@"腾讯微博"];
    [titleBar setItems:@[navItem]];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backClicked)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleBordered target:self action:@selector(sendClicked)];
    navItem.leftBarButtonItem = left;
    navItem.rightBarButtonItem = right;
    
    contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 54, 280, 440)];
    contentTextView.delegate = self;
    contentTextView.backgroundColor = [UIColor clearColor];
    contentTextView.text = @"天下之大，四海为家！";
    if ([self.defaultText length] != 0) {
        contentTextView.text = self.defaultText;
    }
    
    btnTellIdol = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTellIdol.frame = CGRectMake(32, 502, 46, 30);
    [btnTellIdol setTitle:@"@" forState:UIControlStateNormal];
    [btnTellIdol setBackgroundImage:[UIImage imageNamed:@"weibosdk_bg_btn.png"] forState:UIControlStateNormal];
    [btnTellIdol setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnTellIdol addTarget:self action:@selector(tellIdolClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    btnSelectPicture = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSelectPicture.frame = CGRectMake(86, 502, 66, 30);
    [btnSelectPicture setTitle:@"上传照片" forState:UIControlStateNormal];
    [btnSelectPicture setBackgroundImage:[UIImage imageNamed:@"weibosdk_bg_btn.png"] forState:UIControlStateNormal];
    [btnSelectPicture setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnSelectPicture.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnSelectPicture addTarget:self action:@selector(selectPictureClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDelete.frame = CGRectMake(253, 489, 46, 30);
    NSString *delTitle = [NSString stringWithFormat:@"%ld X",(unsigned long)(140 - [contentTextView.text length])];
    [btnDelete setTitle:delTitle forState:UIControlStateNormal];
    [btnDelete setBackgroundImage:[UIImage imageNamed:@"weibosdk_bg_delwords_nor.png"] forState:UIControlStateNormal];
    [btnDelete setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnDelete.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnDelete addTarget:self action:@selector(deleteClicked:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:backgroundView];
    [containerView addSubview:titleBar];
    [containerView addSubview:contentTextView];
    [containerView addSubview:btnTellIdol];
    [containerView addSubview:btnSelectPicture];
    [containerView addSubview:btnDelete];
    
    [self.view addSubview:containerView];
    
}
//导航栏返回
-(void)backClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//导航栏发送
-(void)sendClicked{
    [self sendMessageClicked:nil];
}

//键盘出现操作
-(void)keyboardShow:(NSNotification *)notification{
    //向上缩小编辑视图
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    CGRect cvFrame = containerView.frame;
    cvFrame.size.height -= 252;
    containerView.frame = cvFrame;
    
    CGRect bgFrame = backgroundView.frame;
    bgFrame.size.height -= 252;
    backgroundView.frame = bgFrame;
    
    CGRect ctvFrame = contentTextView.frame;
    ctvFrame.size.height -= 252;
    contentTextView.frame = ctvFrame;
    
    CGRect btnTFrame = btnTellIdol.frame;
    btnTFrame.origin.y -= 237;
    btnTellIdol.frame = btnTFrame;
    
    CGRect btnSelFrame = btnSelectPicture.frame;
    btnSelFrame.origin.y -= 237;
    btnSelectPicture.frame = btnSelFrame;
    
    CGRect btnDelFrame = btnDelete.frame;
    btnDelFrame.origin.y -= 227;
    btnDelete.frame = btnDelFrame;
    
    if (iv != nil) {
        CGRect ivFrame = iv.frame;
        ivFrame.origin.y -= 237;
        iv.frame = ivFrame;
    }
    [UIView commitAnimations];
}
//键盘隐藏操作
-(void)keyboardHide:(NSNotification *)notification{
    //向下放大编辑视图
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    CGRect cvFrame = containerView.frame;
    cvFrame.size.height += 252;
    containerView.frame = cvFrame;
    
    CGRect bgFrame = backgroundView.frame;
    bgFrame.size.height += 252;
    backgroundView.frame = bgFrame;
    
    CGRect ctvFrame = contentTextView.frame;
    ctvFrame.size.height += 252;
    contentTextView.frame = ctvFrame;
    
    CGRect btnTFrame = btnTellIdol.frame;
    btnTFrame.origin.y += 237;
    btnTellIdol.frame = btnTFrame;
    
    CGRect btnSelFrame = btnSelectPicture.frame;
    btnSelFrame.origin.y += 237;
    btnSelectPicture.frame = btnSelFrame;
    
    CGRect btnDelFrame = btnDelete.frame;
    btnDelFrame.origin.y += 227;
    btnDelete.frame = btnDelFrame;
    
    if (iv != nil) {
        CGRect ivFrame = iv.frame;
        ivFrame.origin.y += 237;
        iv.frame = ivFrame;
    }
    
    [UIView commitAnimations];
}
//图片伸缩
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}


- (IBAction)sendMessageClicked:(id)sender {
    UIImage *pic = iv.image;
    notiAlert = [[UIAlertView alloc]init];
    if ([contentTextView.text length] == 0) {
        notiAlert.message = @"您还没输入内容";
        [notiAlert show];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(alertDismiss) userInfo:nil repeats:NO];
    }
    else{
        NSMutableDictionary *info = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"json",@"format",
                                     contentTextView.text, @"content",
                                     pic, @"pic",
                                     nil];
        int result = [self.SMDelegate sendMessageWithInfo:info];
        if (result > 0) {
            notiAlert.message = @"发送成功";
            [notiAlert show];
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismissController) userInfo:nil repeats:NO];
        }
        else{
            notiAlert.message = @"发送失败";
            [notiAlert show];
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(alertDismiss) userInfo:nil repeats:NO];
        }
    }
}
-(void)dismissController{
    [notiAlert dismissWithClickedButtonIndex:0 animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)alertDismiss{
    [notiAlert dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)tellIdolClicked:(id)sender{
    //[self.delegate getIdolList];
    [contentTextView resignFirstResponder];
    NSArray *idols = [self.SMDelegate myIdols];
    UIActionSheet *idolActionSheet = [[UIActionSheet alloc]initWithTitle:@"@你关注的人" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: nil];
    if ([idols count] != 0) {
        for (NSDictionary *aIdol in idols) {
            NSString *name = [aIdol objectForKey:@"name"];
            NSString *nick = [aIdol objectForKey:@"nick"];
            NSString *strNameAndNick = [NSString stringWithFormat:@"%@(%@)",nick,name];
            [idolActionSheet addButtonWithTitle:strNameAndNick];
        }
    }
    [idolActionSheet showInView:self.view];
}

- (IBAction)selectPictureClicked:(id)sender {
    //选择照片
    //弹出选择框：直接上传、拍照上传
    UIAlertView *selectPicAlert = [[UIAlertView alloc]initWithTitle:@"请点击选择" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"直接上传",@"拍照上传", nil];
    [selectPicAlert show];
}

//删除微博
- (IBAction)deleteClicked:(id)sender {
    delAlert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"你确定要删除该条微博?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [delAlert show];
}

#pragma mark - UIImagePickerController Delegate -
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *slectdIMG = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSLog(@"%@",slectdIMG);
    iv = [[UIImageView alloc]initWithFrame:CGRectMake(-10, -10, self.view.bounds.size.width, self.view.bounds.size.height)];
    iv.image = [self OriginImage:slectdIMG scaleToSize:CGSizeMake(100, 80)];
    [self.view addSubview:iv];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    CGRect ctvFrame = contentTextView.frame;
    ctvFrame.size.height -= 80;
    contentTextView.frame = ctvFrame;
    iv.frame = CGRectMake(20, 440, 100, 80);
    [UIView commitAnimations];
}

#pragma mark - UIAlertView Delegate  -
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == delAlert) {//删除微博
        if (buttonIndex == 1) {
            contentTextView.text = @"";
            iv.image = nil;
        }
    }else{
        //选择图片
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.allowsEditing = YES;
        picker.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary|UIImagePickerControllerSourceTypeCamera]) {
        }
        [contentTextView resignFirstResponder];
        switch (buttonIndex) {
            case 1:{
                //选择相册
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:picker animated:YES completion:nil];
                break;
            }
            case 2:{
                //选择拍照
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:nil];
                break;
            }
            default:
                break;
        }
    }
}
#pragma mark - UIActionSheet Delegate -
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //取消
            break;
        default:{
            NSString *idolText = [NSString stringWithFormat:@"%@@%@",contentTextView.text,[actionSheet buttonTitleAtIndex:buttonIndex]];
            contentTextView.text = idolText;
            break;
        }
    }
}

#pragma mark - UITextView Delegate -
-(void)textViewDidChange:(UITextView *)textView{
    NSInteger wordCount = [textView.text length];
    NSString *remainWordCount = [NSString stringWithFormat:@"%ld X",(unsigned long)(140-wordCount)];
    [btnDelete setTitle:remainWordCount forState:UIControlStateNormal];
}

@end
