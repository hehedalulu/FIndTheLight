//
//  HomeLoginViewController.m
//  FIndTheLight
//
//  Created by Wll on 17/3/11.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "HomeLoginViewController.h"
#import <BmobSDK/Bmob.h>
#import "JCAlertView.h"
#import "LLHomePageViewController.h"

@interface HomeLoginViewController ()<UITextFieldDelegate>{
    BOOL LoginView;
    UIButton *HomeLoginBtn;
    UIButton *HomeReigistBtn;
    UIButton *loginbtn;
    UIButton *registbtn;
    UIImageView *LoginBackView;
    
    UITextField *PhoneFeild;
    UITextField *MMTextFeild;
    UITextField *YanZhengMaFeild;
    UIImageView *SMSStride;
    
    UIButton *shangweizhuce;
    UIButton *wangjiMM;
    UIButton *woyaoLog;
    UIButton *SendSMS;
    
    
    UIButton *loginPressbtn;
    UIButton *RegistPressbtn;
    
    UIImageView *pointer;
    int secondsCountDown;
    NSTimer *countDownTimer;
}

@end

@implementation HomeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    [self initLoginAndRegistBtn];
    
}

#pragma mark - 视图

-(void)initLoginAndRegistBtn{
    UIImageView *backgroundView = [[UIImageView alloc]init];
    NSString *filePath=[[NSBundle mainBundle] pathForResource:@"register_bg" ofType:@"png"];
    UIImage *image=[UIImage imageWithContentsOfFile:filePath];
    backgroundView.image = image;
    backgroundView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backgroundView];
    
    HomeReigistBtn = [[UIButton alloc]init];
    [HomeReigistBtn setBackgroundImage:[UIImage imageNamed:@"RegisteView_signup.png"] forState:UIControlStateNormal];
//    HomeReigistBtn.titleLabel.text = @"注册";
    HomeReigistBtn.tag = 1;
//    HomeReigistBtn.titleLabel.textColor = [UIColor whiteColor];
    HomeReigistBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.53,
                                      [UIScreen mainScreen].bounds.size.height*0.86,
                                      [UIScreen mainScreen].bounds.size.width*0.352,
                                      [UIScreen mainScreen].bounds.size.width*0.135);
    [HomeReigistBtn addTarget:self action:@selector(GetinLoginView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:HomeReigistBtn];
    
    HomeLoginBtn = [[UIButton alloc]init];
    [HomeLoginBtn setBackgroundImage:[UIImage imageNamed:@"RegisteView_login.png"] forState:UIControlStateNormal];
    //    HomeLoginBtn.titleLabel.text = @"登录";
    HomeLoginBtn.tag = 0;
    //    HomeLoginBtn.titleLabel.textColor = [UIColor whiteColor];
    HomeLoginBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.12,
                                    [UIScreen mainScreen].bounds.size.height*0.86,
                                    [UIScreen mainScreen].bounds.size.width*0.352,
                                    [UIScreen mainScreen].bounds.size.width*0.135);
    [HomeLoginBtn addTarget:self action:@selector(GetinLoginView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:HomeLoginBtn];
}

-(void)GetinLoginView:(UIButton*)sender{
    if (sender.tag == 0) {
        //登录
        LoginView = YES;
    }else{
        //注册
        LoginView = NO;
    }
    [UIView animateWithDuration:1.0 animations:^{
        HomeLoginBtn.alpha = 0;
        HomeReigistBtn.alpha = 0;
    } completion:^(BOOL finished) {
        HomeLoginBtn.hidden = YES;
        HomeReigistBtn.hidden = YES;
        [self TheregistViewUp];
    }];
}

-(void)TheregistViewUp{
    
    
    LoginBackView = [[UIImageView alloc]init];
    LoginBackView.alpha = 0;
    LoginBackView.userInteractionEnabled = YES;
    LoginBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height,
                                     [UIScreen mainScreen].bounds.size.width,
                                     [UIScreen mainScreen].bounds.size.width);
    [self.view addSubview:LoginBackView];
    

    
    UIImageView *backimage = [[UIImageView alloc]init];
    backimage.frame = CGRectMake(0,  [UIScreen mainScreen].bounds.size.width*0.1,
                                 [UIScreen mainScreen].bounds.size.width,
                                 [UIScreen mainScreen].bounds.size.height);
    backimage.image = [UIImage imageNamed:@"register_layer@2x.png"];
    [LoginBackView addSubview:backimage];
    
    pointer = [[UIImageView alloc]init];
//    pointer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.68,
////                               [UIScreen mainScreen].bounds.size.width*0.26,
//                               [UIScreen mainScreen].bounds.size.width*0.08,
//                               [UIScreen mainScreen].bounds.size.width*0.018,
//                               [UIScreen mainScreen].bounds.size.width*0.02);
    pointer.image = [UIImage imageNamed:@"pointer@2x.png"];
    [LoginBackView addSubview:pointer];
    
    loginbtn = [[UIButton alloc]init];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
//
    loginbtn.titleLabel.textColor = [UIColor whiteColor];
    loginbtn.titleLabel.font = [UIFont systemFontOfSize:16];
    loginbtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.22, 0,
                                [UIScreen mainScreen].bounds.size.width*0.1,
                                [UIScreen mainScreen].bounds.size.width*0.1);
    [loginbtn addTarget:self action:@selector(changetoLogin) forControlEvents:UIControlEventTouchUpInside];
    [LoginBackView addSubview:loginbtn];
    

    
    registbtn = [[UIButton alloc]init];
    [registbtn setTitle:@"注册" forState:UIControlStateNormal];
//    [registbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registbtn.titleLabel.font = [UIFont systemFontOfSize:16];
    registbtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.64, 0,
                                 [UIScreen mainScreen].bounds.size.width*0.1,
                                 [UIScreen mainScreen].bounds.size.width*0.1);
    [registbtn addTarget:self action:@selector(changetoRegist) forControlEvents:UIControlEventTouchUpInside];
    [LoginBackView addSubview:registbtn];
    
    UILabel *shoujihao = [[UILabel alloc]init];
    shoujihao.text = @"手机号";
    shoujihao.textColor = [UIColor whiteColor];
    shoujihao.font = [UIFont systemFontOfSize:16];
    shoujihao.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.14,
                                 [UIScreen mainScreen].bounds.size.width*0.21,
                                 [UIScreen mainScreen].bounds.size.width*0.2,
                                 [UIScreen mainScreen].bounds.size.width*0.08);
    [LoginBackView addSubview:shoujihao];
    
    UIImageView *SJStride = [[UIImageView alloc]init];
    UIImage *image1 =[UIImage imageNamed:@"underline_long.png"];
    SJStride.image = image1;
    SJStride.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.14,
                                [UIScreen mainScreen].bounds.size.width*0.28,
                                [UIScreen mainScreen].bounds.size.width*0.72,
                                1);
    [LoginBackView addSubview:SJStride];
    
    PhoneFeild = [[UITextField alloc]init];
    PhoneFeild.delegate = self;
    PhoneFeild.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.28,
                                  [UIScreen mainScreen].bounds.size.width*0.20,
                                  [UIScreen mainScreen].bounds.size.width*0.50,
                                  [UIScreen mainScreen].bounds.size.width*0.10);
    PhoneFeild.textColor = [UIColor whiteColor];
    PhoneFeild.keyboardType = UIKeyboardTypePhonePad;
    PhoneFeild.clearButtonMode = UITextFieldViewModeAlways;
    PhoneFeild.placeholder = @"请输入手机号";
    PhoneFeild.textAlignment = NSTextAlignmentCenter;
    PhoneFeild.userInteractionEnabled = YES;
    PhoneFeild.backgroundColor = [UIColor clearColor];
    [LoginBackView addSubview:PhoneFeild];
    
    UILabel *mima = [[UILabel alloc]init];
    mima.text = @"密码";
    mima.textColor = [UIColor whiteColor];
    mima.font = [UIFont systemFontOfSize:16];
    mima.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.14,
                                 [UIScreen mainScreen].bounds.size.width*0.39,
                                 [UIScreen mainScreen].bounds.size.width*0.2,
                                 [UIScreen mainScreen].bounds.size.width*0.08);
    [LoginBackView addSubview:mima];
    
    UIImageView *MMStride = [[UIImageView alloc]init];
    MMStride.image = image1;
    MMStride.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.14,
                                [UIScreen mainScreen].bounds.size.width*0.46,
                                [UIScreen mainScreen].bounds.size.width*0.72,
                                1);
    [LoginBackView addSubview:MMStride];
    
    MMTextFeild = [[UITextField alloc]init];
    MMTextFeild.delegate = self;
    MMTextFeild.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.28,
                                   [UIScreen mainScreen].bounds.size.width*0.38,
                                   [UIScreen mainScreen].bounds.size.width*0.50,
                                   [UIScreen mainScreen].bounds.size.width*0.10);
    MMTextFeild.secureTextEntry = YES;
    MMTextFeild.placeholder = @"请输入密码";
    MMTextFeild.textAlignment = NSTextAlignmentCenter;
    MMTextFeild.clearButtonMode = UITextFieldViewModeAlways;
    MMTextFeild.userInteractionEnabled = YES;
    MMTextFeild.backgroundColor = [UIColor clearColor];
    MMTextFeild.textColor = [UIColor whiteColor];
    MMTextFeild.clearButtonMode = UITextFieldViewModeAlways;
    [LoginBackView addSubview:MMTextFeild];
    

    
    YanZhengMaFeild = [[UITextField alloc]init];
    YanZhengMaFeild.delegate = self;
    YanZhengMaFeild.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.14,
                                   [UIScreen mainScreen].bounds.size.width*0.53,
                                   [UIScreen mainScreen].bounds.size.width*0.46,
                                   [UIScreen mainScreen].bounds.size.width*0.10);
    YanZhengMaFeild.placeholder = @"请输入验证码";
    YanZhengMaFeild.textAlignment = NSTextAlignmentCenter;
    YanZhengMaFeild.clearButtonMode = UITextFieldViewModeAlways;
    YanZhengMaFeild.userInteractionEnabled = YES;
    YanZhengMaFeild.keyboardType =UIKeyboardTypeNumberPad;
    YanZhengMaFeild.backgroundColor = [UIColor clearColor];
    YanZhengMaFeild.textColor = [UIColor whiteColor];
    YanZhengMaFeild.clearButtonMode = UITextFieldViewModeAlways;
    [LoginBackView addSubview:YanZhengMaFeild];
    YanZhengMaFeild.hidden = YES;
    
    SendSMS = [[UIButton alloc]init];
    [SendSMS setBackgroundImage:[UIImage imageNamed:@"Register_btn_code.png"] forState:UIControlStateNormal];
    [SendSMS setTitle:@"发送验证码" forState:UIControlStateNormal];
    [SendSMS setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SendSMS.titleLabel.font = [UIFont systemFontOfSize:15];
    SendSMS.titleLabel.textAlignment = NSTextAlignmentCenter;
    SendSMS.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.62,
                               [UIScreen mainScreen].bounds.size.width*0.54,
                               [UIScreen mainScreen].bounds.size.width*0.24,
                               [UIScreen mainScreen].bounds.size.width*0.08);
    [SendSMS addTarget:self action:@selector(RequestSMSCode) forControlEvents:UIControlEventTouchUpInside];
    [LoginBackView addSubview:SendSMS];
    
    
    SMSStride = [[UIImageView alloc]init];
    SMSStride.image = image1;
    SMSStride.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.14,
                                [UIScreen mainScreen].bounds.size.width*0.62,
                                [UIScreen mainScreen].bounds.size.width*0.46,
                                1);
    [LoginBackView addSubview:SMSStride];
    SMSStride.hidden = YES;
    
    
    
    shangweizhuce = [[UIButton alloc]init];
    [shangweizhuce setTitle:@"尚未注册" forState:UIControlStateNormal];
    shangweizhuce.titleLabel.textAlignment = NSTextAlignmentLeft;
    [shangweizhuce setTitleColor:[UIColor colorWithRed:74.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
    shangweizhuce.titleLabel.font = [UIFont systemFontOfSize:12];
    shangweizhuce.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.14,
                                     [UIScreen mainScreen].bounds.size.width*0.54,
                                     [UIScreen mainScreen].bounds.size.width*0.12,
                                     [UIScreen mainScreen].bounds.size.width*0.08);
    [shangweizhuce addTarget:self action:@selector(changetoRegist) forControlEvents:UIControlEventTouchUpInside];
    [LoginBackView addSubview:shangweizhuce];
    
    wangjiMM = [[UIButton alloc]init];
    [wangjiMM setTitle:@"忘记密码" forState:UIControlStateNormal];
    [wangjiMM setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    wangjiMM.titleLabel.font = [UIFont systemFontOfSize:12];
    wangjiMM.titleLabel.textAlignment = NSTextAlignmentRight;
    wangjiMM.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.74,
                                     [UIScreen mainScreen].bounds.size.width*0.54,
                                     [UIScreen mainScreen].bounds.size.width*0.12,
                                     [UIScreen mainScreen].bounds.size.width*0.08);
    [LoginBackView addSubview:wangjiMM];
    
    [UIView animateWithDuration:1.0 animations:^{
        LoginBackView.alpha = 1;
        LoginBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.43,
                                        [UIScreen mainScreen].bounds.size.width,
                                        [UIScreen mainScreen].bounds.size.width);
    }];
    
    [UIView animateWithDuration:1.0 animations:^{
        LoginBackView.alpha = 1;
        LoginBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.43,
                                         [UIScreen mainScreen].bounds.size.width,
                                         [UIScreen mainScreen].bounds.size.width);
    }];
    

    
    loginPressbtn = [[UIButton alloc]init];
    [loginPressbtn setBackgroundImage:[UIImage imageNamed:@"register_btn.png"] forState:UIControlStateNormal];
    [loginPressbtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginPressbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginPressbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    loginPressbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    loginPressbtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.14,
                                     [UIScreen mainScreen].bounds.size.width*0.65,
                                     [UIScreen mainScreen].bounds.size.width*0.757,
                                     [UIScreen mainScreen].bounds.size.width*0.1);
    [LoginBackView addSubview:loginPressbtn];
    [loginPressbtn addTarget:self action:@selector(PressToLogin) forControlEvents:UIControlEventTouchUpInside];
    
    RegistPressbtn = [[UIButton alloc]init];
    [RegistPressbtn setBackgroundImage:[UIImage imageNamed:@"register_btn.png"] forState:UIControlStateNormal];
    [RegistPressbtn setTitle:@"注册" forState:UIControlStateNormal];
    [RegistPressbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RegistPressbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    RegistPressbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    RegistPressbtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.14,
                                     [UIScreen mainScreen].bounds.size.width*0.65,
                                     [UIScreen mainScreen].bounds.size.width*0.757,
                                     [UIScreen mainScreen].bounds.size.width*0.1);
    [LoginBackView addSubview:RegistPressbtn];
    [RegistPressbtn addTarget:self action:@selector(PressToRegist) forControlEvents:UIControlEventTouchUpInside];
    RegistPressbtn.hidden =YES;
    

    UILabel *SecordPartLog = [[UILabel alloc]init];
    SecordPartLog.text = @"其他登录方式";
    SecordPartLog.textColor = [UIColor colorWithRed:131.0/255.0 green:161.0/255.0 blue:202.0/255.0 alpha:1];
    SecordPartLog.font = [UIFont systemFontOfSize:11];
    SecordPartLog.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.44,
                                     [UIScreen mainScreen].bounds.size.width*0.77,
                                     [UIScreen mainScreen].bounds.size.width*0.21,
                                     [UIScreen mainScreen].bounds.size.width*0.08);
    [LoginBackView addSubview:SecordPartLog];

    
    UIButton *QQlog = [[UIButton alloc]init];
    [QQlog setBackgroundImage:[UIImage imageNamed:@"btn_qq@2x.png"] forState:UIControlStateNormal];
    QQlog.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.40,
                             [UIScreen mainScreen].bounds.size.width*0.86,
                             [UIScreen mainScreen].bounds.size.width*0.053,
                             [UIScreen mainScreen].bounds.size.width*0.053);
    [LoginBackView addSubview:QQlog];
    
    UIButton *WeiColog = [[UIButton alloc]init];
    [WeiColog setBackgroundImage:[UIImage imageNamed:@"btn_weibo@2x.png"] forState:UIControlStateNormal];
    WeiColog.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.57,
                             [UIScreen mainScreen].bounds.size.width*0.86,
                             [UIScreen mainScreen].bounds.size.width*0.053,
                             [UIScreen mainScreen].bounds.size.width*0.053);
    [LoginBackView addSubview:WeiColog];
    
    if(LoginView){
        //登录页面
        [registbtn setTitleColor:[UIColor colorWithRed:96.0/255.0 green:132.0/255.0 blue:177.0/255.0 alpha:1] forState:UIControlStateNormal];
        [loginbtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        MMTextFeild.placeholder = @"请输入密码";
        shangweizhuce.hidden = NO;
        wangjiMM.hidden = NO;
        loginPressbtn.hidden = NO;
        RegistPressbtn.hidden = YES;
        SMSStride.hidden = YES;
        SendSMS.hidden = YES;
        YanZhengMaFeild.hidden = YES;
        pointer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.26,
                                   [UIScreen mainScreen].bounds.size.width*0.08,
                                   [UIScreen mainScreen].bounds.size.width*0.018,
                                   [UIScreen mainScreen].bounds.size.width*0.02);

    }else{
        [registbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginbtn setTitleColor:[UIColor colorWithRed:96.0/255.0 green:132.0/255.0 blue:177.0/255.0 alpha:1] forState:UIControlStateNormal];
        MMTextFeild.placeholder = @"请输入不少于六位的密码";
        shangweizhuce.hidden = YES;
        wangjiMM.hidden = YES;
        loginPressbtn.hidden = YES;
        RegistPressbtn.hidden = NO;
        SendSMS.hidden = NO;
        SMSStride.hidden = NO;
        YanZhengMaFeild.hidden = NO;
        pointer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.68,
                                   [UIScreen mainScreen].bounds.size.width*0.08,
                                   [UIScreen mainScreen].bounds.size.width*0.018,
                                   [UIScreen mainScreen].bounds.size.width*0.02);
        
    }
    
}


-(void)changetoLogin{
    if (LoginView) {
        return;
    }else{
        [registbtn setTitleColor:[UIColor colorWithRed:96.0/255.0 green:132.0/255.0 blue:177.0/255.0 alpha:1] forState:UIControlStateNormal];
        [loginbtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        MMTextFeild.placeholder = @"请输入密码";
        [MMTextFeild setText:@""];
        [PhoneFeild setText:@""];
        shangweizhuce.hidden = NO;
        wangjiMM.hidden = NO;
        loginPressbtn.hidden = NO;
        RegistPressbtn.hidden = YES;
        SendSMS.hidden = YES;
        SMSStride.hidden = YES;
        YanZhengMaFeild.hidden = YES;
        LoginView = YES;
        [UIView animateWithDuration:0.5 animations:^{
            pointer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.26,
                                       [UIScreen mainScreen].bounds.size.width*0.08,
                                       [UIScreen mainScreen].bounds.size.width*0.018,
                                       [UIScreen mainScreen].bounds.size.width*0.02);
        }];
    }

}

-(void)changetoRegist{
    if (!LoginView) {
        return;
    }else{
        [registbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginbtn setTitleColor:[UIColor colorWithRed:96.0/255.0 green:132.0/255.0 blue:177.0/255.0 alpha:1] forState:UIControlStateNormal];
        MMTextFeild.placeholder = @"请输入不少于六位的密码";
        [MMTextFeild setText:@""];
        [PhoneFeild setText:@""];
        shangweizhuce.hidden = YES;
        wangjiMM.hidden = YES;
        loginPressbtn.hidden = YES;
        RegistPressbtn.hidden = NO;
        SendSMS.hidden = NO;
        SMSStride.hidden = NO;
        YanZhengMaFeild.hidden = NO;
        LoginView = NO;
        [UIView animateWithDuration:0.5 animations:^{
            pointer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.68,
                                       [UIScreen mainScreen].bounds.size.width*0.08,
                                       [UIScreen mainScreen].bounds.size.width*0.018,
                                       [UIScreen mainScreen].bounds.size.width*0.02);
        }];
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 数据层
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    if(textField == PhoneFeild){
        [PhoneFeild resignFirstResponder];
        [MMTextFeild becomeFirstResponder];
        [UIView animateWithDuration:0.5 animations:^{
            LoginBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.33,
                                             [UIScreen mainScreen].bounds.size.width,
                                             [UIScreen mainScreen].bounds.size.width);
        }];
    }else if (textField == MMTextFeild){
        [YanZhengMaFeild resignFirstResponder];
        [MMTextFeild resignFirstResponder];
        [UIView animateWithDuration:0.5 animations:^{
            LoginBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.33,
                                             [UIScreen mainScreen].bounds.size.width,
                                             [UIScreen mainScreen].bounds.size.width);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            LoginBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.43,
                                             [UIScreen mainScreen].bounds.size.width,
                                             [UIScreen mainScreen].bounds.size.width);
        }];
    }
    
    

    return YES;
}
//代码实现轻触背景关闭键盘
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![self.view isExclusiveTouch]) {
        [self.view endEditing:YES];
    }
    [UIView animateWithDuration:0.5 animations:^{
        LoginBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.43,
                                         [UIScreen mainScreen].bounds.size.width,
                                         [UIScreen mainScreen].bounds.size.width);
    }];
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if (textField == PhoneFeild) {
        [UIView animateWithDuration:0.5 animations:^{
            LoginBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height*0.33,
                                             [UIScreen mainScreen].bounds.size.width,
                                             [UIScreen mainScreen].bounds.size.width);
        }];
//    }
    return YES;
}


#pragma mark - 功能层
-(void)PressToLogin{
    NSString *mobilePhoneNumber = PhoneFeild.text;
    NSString *userpassword = MMTextFeild.text;
    [BmobUser loginInbackgroundWithAccount:mobilePhoneNumber andPassword:userpassword block:^(BmobUser *user, NSError *error) {
        if (user) {
            NSLog(@"%@",user);
            LLHomePageViewController *HomeController = [[LLHomePageViewController alloc]init];
             [self presentViewController:HomeController animated:YES completion:^{
             }];
        } else {
            NSLog(@"%@",error);
            [JCAlertView showOneButtonWithTitle:@"" Message:@"密码输入错误" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"再次尝试" Click:nil];
        }
    }];
}

-(void)PressToRegist{
    NSString *mobilePhoneNumber = PhoneFeild.text;
    NSString *userpassword = MMTextFeild.text;
    //手机号注册用户
    NSLog(@"开始注册用户");
    //该方法可以进行注册和登录两步操作，如果已经注册过了就直接进行登录
    BmobUser *buser = [[BmobUser alloc] init];
    buser.mobilePhoneNumber = mobilePhoneNumber;
    buser.password = userpassword;
    
    [buser signUpOrLoginInbackgroundWithSMSCode:YanZhengMaFeild.text block:^(BOOL isSuccessful, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            [self FailtoRequestSmsCode];
        } else {
            BmobUser *user = [BmobUser currentUser];
            NSLog(@"%@",user);
            //跳转
            [self SuccessRegister];
        }
    }];
}

//注册成功后跳出提示框 点击进入
- (void)SuccessRegister{
    [JCAlertView showOneButtonWithTitle:@"" Message:@"注册成功" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"马上登录" Click:^{
        //注册完成 跳转
        [self performSegueWithIdentifier:@"RegisterToHome" sender:self];
    }];
    
}

//验证码验证失败后 跳出提示框
- (void)FailtoRequestSmsCode{
    [JCAlertView showOneButtonWithTitle:@"" Message:@"验证码有误" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"再次尝试" Click:nil];
}


-(void)RequestSMSCode{
    //请求验证码
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:PhoneFeild.text andTemplate:@"test" resultBlock:^(int number, NSError *error) {
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

//设置点击验证码后 60秒内不能够点击
-(void)setRequestSmsCodeBtnCountDown{
    [SendSMS setEnabled:NO];
//    SendSMS.backgroundColor = [UIColor grayColor];
    secondsCountDown = 60;
    
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimeWithSeconds:) userInfo:nil repeats:YES];
    [countDownTimer fire];
}
//60秒之后 可以点击发送验证码
-(void)countDownTimeWithSeconds:(NSTimer*)timerInfo{
    if (secondsCountDown == 0) {
        [SendSMS setEnabled:YES];
//        self.LLRequstSmsBtn.backgroundColor = [UIColor redColor];
        [SendSMS setTitle:@"发送验证码" forState:UIControlStateNormal];
        [countDownTimer invalidate];
    } else {
        [SendSMS setTitle:[[NSNumber numberWithInt:secondsCountDown] description] forState:UIControlStateNormal];
        secondsCountDown--;
    }
}

@end
