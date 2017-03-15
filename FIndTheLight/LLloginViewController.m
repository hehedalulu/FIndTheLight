//
//  LLloginViewController.m
//  FIndTheLight
//
//  Created by Wll on 16/12/13.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLloginViewController.h"
#import <BmobSDK/Bmob.h>
#import "JCAlertView.h"


#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface LLloginViewController ()<UITextFieldDelegate>
//@property (strong, nonatomic) IBOutlet UITextField *LLloginPhoneNumber;
//@property (strong, nonatomic) IBOutlet UITextField *LLloginPassword;
//- (IBAction)LLPressToLogin:(UIButton *)sender;
//@property (strong, nonatomic) IBOutlet UIView *alphaView;
//
//
//@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;
//@property(nonatomic ,strong)AVAudioSession *avaudioSession;
//
@end

@implementation LLloginViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"IMG_7219.MOV" ofType:nil];
//    
//    NSURL *url = [NSURL fileURLWithPath:urlStr];
//    
//    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
//    //    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
//    [_moviePlayer play];
//    [_moviePlayer.view setFrame:self.view.bounds];
//    
//    [self.view addSubview:_moviePlayer.view];
//    _moviePlayer.shouldAutoplay = YES;
//    [_moviePlayer setControlStyle:MPMovieControlStyleNone];
//    [_moviePlayer setFullscreen:YES];
//    
//    [_moviePlayer setRepeatMode:MPMovieRepeatModeOne];
//    
//    _alphaView.backgroundColor = [UIColor clearColor];
//    
//    [_moviePlayer.view addSubview:_alphaView];
//    
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [_moviePlayer stop];
//}
//-(BOOL)prefersStatusBarHidden{
//    
//    return YES;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
////换行关闭
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    return [textField resignFirstResponder];
//}
//
////代码实现轻触背景关闭键盘
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if (![self.view isExclusiveTouch]) {
//        [self.view endEditing:YES];
//    }
//}
//
//
//- (IBAction)LLPressToLogin:(UIButton *)sender {
//    NSString *mobilePhoneNumber = _LLloginPhoneNumber.text;
//    NSString *userpassword = _LLloginPassword.text;
//    [BmobUser loginInbackgroundWithAccount:mobilePhoneNumber andPassword:userpassword block:^(BmobUser *user, NSError *error) {
//        if (user) {
//            NSLog(@"%@",user);
//            [self performSegueWithIdentifier:@"LoginUse" sender:self];
//        } else {
//            NSLog(@"%@",error);
//            [JCAlertView showOneButtonWithTitle:@"" Message:@"密码输入错误" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"再次尝试" Click:nil];
//        }
//    }];
//}
@end
