//
//  LLFindPasswordViewController.m
//  FIndTheLight
//
//  Created by Wll on 16/12/13.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLFindPasswordViewController.h"
#import <BmobSDK/Bmob.h>
#import "JCAlertView.h"


#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface LLFindPasswordViewController ()<UITextViewDelegate>{
    NSTimer *ResetcountDownTimer;
    unsigned ResetsecondsCountDown;
}
@property (strong, nonatomic) IBOutlet UITextField *LLResetPhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *LLResetPassword;
@property (strong, nonatomic) IBOutlet UITextField *LLResetPhoneCheckNumber;
@property (strong, nonatomic) IBOutlet UIButton *LLResetRequstBtn;
- (IBAction)LLResetChechNumber:(UIButton *)sender;
- (IBAction)LLResetLogin:(UIButton *)sender;


@property (strong, nonatomic) IBOutlet UIView *alpha3;
@property(nonatomic,strong)MPMoviePlayerController *moviePlayer3;
@property(nonatomic ,strong)AVAudioSession *avaudioSession3;


@end

@implementation LLFindPasswordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"IMG_7219.MOV" ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    
    _moviePlayer3 = [[MPMoviePlayerController alloc]initWithContentURL:url];
    //    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    [_moviePlayer3 play];
    [_moviePlayer3.view setFrame:self.view.bounds];
    
    [self.view addSubview:_moviePlayer3.view];
    _moviePlayer3.shouldAutoplay = YES;
    [_moviePlayer3 setControlStyle:MPMovieControlStyleNone];
    [_moviePlayer3 setFullscreen:YES];
    
    [_moviePlayer3 setRepeatMode:MPMovieRepeatModeOne];
    
    _alpha3.backgroundColor = [UIColor clearColor];
    
    [_moviePlayer3.view addSubview:_alpha3];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_moviePlayer3 stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    
    return YES;
}
//代码实现轻触背景关闭键盘
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![self.view isExclusiveTouch]) {
        [self.view endEditing:YES];
    }
}
//换行关闭
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


- (IBAction)LLResetChechNumber:(UIButton *)sender {
    //请求验证码
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:_LLResetPhoneNumber.text andTemplate:@"test" resultBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            [JCAlertView showOneButtonWithTitle:@"" Message:@"请输入正确的手机号码" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"确定" Click:nil];
        } else {
            //获得smsID
            NSLog(@"sms ID：%d",number);
            //设置不可点击
            [self setRequestSmsCodeBtnCountDown];
        }
    }];
}


#pragma mark - 点击请求验证码之后button不能够点击 60s后进行点击的相关逻辑

//设置点击验证码后 60秒内不能够点击
-(void)setRequestSmsCodeBtnCountDown{
    [self.LLResetRequstBtn setEnabled:NO];
    self.LLResetRequstBtn.backgroundColor = [UIColor grayColor];
    ResetsecondsCountDown = 60;
    
    ResetcountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimeWithSeconds:) userInfo:nil repeats:YES];
    [ResetcountDownTimer fire];
}

//60秒之后 可以点击发送验证码
-(void)countDownTimeWithSeconds:(NSTimer*)timerInfo{
    if (ResetsecondsCountDown == 0) {
        [self.LLResetRequstBtn setEnabled:YES];
        self.LLResetRequstBtn.backgroundColor = [UIColor redColor];
        [self.LLResetRequstBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [ResetcountDownTimer invalidate];
    } else {
        [self.LLResetRequstBtn setTitle:[[NSNumber numberWithInt:ResetsecondsCountDown] description] forState:UIControlStateNormal];
        ResetsecondsCountDown--;
    }
}

- (IBAction)LLResetLogin:(UIButton *)sender {
    [BmobUser resetPasswordInbackgroundWithSMSCode:_LLResetPhoneCheckNumber.text andNewPassword:_LLResetPassword.text block:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"%@",@"重置密码成功");
            [self performSegueWithIdentifier:@"ResetToHome" sender:self];
        } else {
            NSLog(@"%@",error);
        }
    }];
}
@end
