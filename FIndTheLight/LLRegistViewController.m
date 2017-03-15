//
//  LLRegistViewController.m
//  FIndTheLight
//
//  Created by Wll on 16/12/13.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLRegistViewController.h"
#import <BmobSDK/Bmob.h>
#import "JCAlertView.h"

#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface LLRegistViewController ()<UITextFieldDelegate>
//{
//    NSTimer *countDownTimer;
//    unsigned secondsCountDown;
//}
//@property (strong, nonatomic) IBOutlet UITextField *LLregisterPhoneNumber;
//@property (strong, nonatomic) IBOutlet UITextField *LLRegisterPassword;
//@property (strong, nonatomic) IBOutlet UITextField *LLRegisterCheckNumber;
//- (IBAction)LLRegister:(UIButton *)sender;
//- (IBAction)LLRegisterSmsCode:(UIButton *)sender;
//@property (strong, nonatomic) IBOutlet UIButton *LLRequstSmsBtn;
//
//@property(nonatomic,strong)MPMoviePlayerController *moviePlayer2;
//@property(nonatomic ,strong)AVAudioSession *avaudioSession2;
//@property (strong, nonatomic) IBOutlet UIView *alphaView2;

@end

@implementation LLRegistViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    
//    
//    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"IMG_7219.MOV" ofType:nil];
//    
//    NSURL *url = [NSURL fileURLWithPath:urlStr];
//    
//    _moviePlayer2 = [[MPMoviePlayerController alloc]initWithContentURL:url];
//    //    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
//    [_moviePlayer2 play];
//    [_moviePlayer2.view setFrame:self.view.bounds];
//    
//    [self.view addSubview:_moviePlayer2.view];
//    _moviePlayer2.shouldAutoplay = YES;
//    [_moviePlayer2 setControlStyle:MPMovieControlStyleNone];
//    [_moviePlayer2 setFullscreen:YES];
//    
//    [_moviePlayer2 setRepeatMode:MPMovieRepeatModeOne];
//    _alphaView2.backgroundColor = [UIColor clearColor];
//    
//    [_moviePlayer2.view addSubview:_alphaView2];
//
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [_moviePlayer2 stop];
//}
//-(BOOL)prefersStatusBarHidden{
//    
//    return YES;
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
////代码实现轻触背景关闭键盘
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if (![self.view isExclusiveTouch]) {
//        [self.view endEditing:YES];
//    }
//}
////换行关闭
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    return [textField resignFirstResponder];
//}
//
//
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//- (IBAction)LLRegister:(UIButton *)sender {
//    //手机号注册用户
//    NSLog(@"开始注册用户");
//    //该方法可以进行注册和登录两步操作，如果已经注册过了就直接进行登录
//    BmobUser *buser = [[BmobUser alloc] init];
//    buser.mobilePhoneNumber = _LLregisterPhoneNumber.text;
//    buser.password = _LLRegisterPassword.text;
//    //    buser.email = @"xxx@gmail.com";
//    [buser signUpOrLoginInbackgroundWithSMSCode:_LLRegisterCheckNumber.text block:^(BOOL isSuccessful, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//            [self FailtoRequestSmsCode];
//        } else {
//            BmobUser *user = [BmobUser currentUser];
//            NSLog(@"%@",user);
//            //跳转
//            [self SuccessRegister];
//        }
//    }];
//}
////注册成功后跳出提示框 点击进入
//- (void)SuccessRegister{
//    [JCAlertView showOneButtonWithTitle:@"" Message:@"注册成功" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"马上登录" Click:^{
//        //注册完成 跳转
//        [self performSegueWithIdentifier:@"RegisterToHome" sender:self];
//    }];
//    
//}
//
////验证码验证失败后 跳出提示框
//- (void)FailtoRequestSmsCode{
//    [JCAlertView showOneButtonWithTitle:@"" Message:@"验证码有误" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"再次尝试" Click:nil];
//}
//
//
////请求验证码
//- (IBAction)LLRegisterSmsCode:(UIButton *)sender {
//    //请求验证码
//    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:_LLregisterPhoneNumber.text andTemplate:@"test" resultBlock:^(int number, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//            [JCAlertView showOneButtonWithTitle:@"" Message:@"请输入正确的手机号码" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"确定" Click:nil];
//        } else {
//            //获得smsID
//            NSLog(@"sms ID：%d",number);
//            //设置不可点击
//            [self setRequestSmsCodeBtnCountDown];
//        }
//    }];
//}
//
////设置点击验证码后 60秒内不能够点击
//-(void)setRequestSmsCodeBtnCountDown{
//    [self.LLRequstSmsBtn setEnabled:NO];
//    self.LLRequstSmsBtn.backgroundColor = [UIColor grayColor];
//    secondsCountDown = 60;
//    
//    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimeWithSeconds:) userInfo:nil repeats:YES];
//    [countDownTimer fire];
//}
////60秒之后 可以点击发送验证码
//-(void)countDownTimeWithSeconds:(NSTimer*)timerInfo{
//    if (secondsCountDown == 0) {
//        [self.LLRequstSmsBtn setEnabled:YES];
//        self.LLRequstSmsBtn.backgroundColor = [UIColor redColor];
//        [self.LLRequstSmsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//        [countDownTimer invalidate];
//    } else {
//        [self.LLRequstSmsBtn setTitle:[[NSNumber numberWithInt:secondsCountDown] description] forState:UIControlStateNormal];
//        secondsCountDown--;
//    }
//}

@end
