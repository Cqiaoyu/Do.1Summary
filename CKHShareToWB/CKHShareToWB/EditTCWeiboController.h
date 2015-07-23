//
//  EditTCWeiboController.h
//  ShareDemo
//
//  Created by cenkh on 14-7-12.
//  Copyright (c) 2014年 cenkh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendeMessageDelegate;


@interface EditTCWeiboController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UITextViewDelegate
>{
    UINavigationBar *titleBar;
    UIView *containerView;
    UITextView *contentTextView;
    UIButton *btnSendMessae;
    UIButton *btnTellIdol;
    UIButton *btnSelectPicture;
    UIButton *btnDelete;
    UIImageView *iv;    //选取的图片视图
    
}
@property (strong, nonatomic)id<SendeMessageDelegate>SMDelegate;
@property (strong, nonatomic)NSString *defaultText;

- (IBAction)sendMessageClicked:(id)sender;
- (IBAction)tellIdolClicked:(id)sender;
- (IBAction)selectPictureClicked:(id)sender;
- (IBAction)deleteClicked:(id)sender;

@end

@protocol SendeMessageDelegate <NSObject>

-(int)sendMessageWithInfo:(NSMutableDictionary *)info;
-(void)getIdolList;
-(NSArray *)myIdols;

@end