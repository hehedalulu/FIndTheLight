//
//  LLHomePageViewController.m
//  UniversityPokemon
//
//  Created by Wll on 16/11/12.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLHomePageViewController.h"
#import "JCAlertView.h"
#import <CoreLocation/CoreLocation.h>
#import "LLHomePageDisplayView.h"
#import "LLHomePageInformationView.h"
#import "Masonry.h"
#import "LLSearchAroundLocation.h"
#import "PopMenu.h"
#import "LLFilterView.h"
#import "LLFilterAlwaysView.h"
#import "LLFilterBackgroundView.h"
#import "LLChooseView.h"
#import <POP/POP.h>
#import "GPUImage.h"
#import "LLWaitingBall.h"
#import "LLMatureView.h"

#import "LLGetNowTime.h"
#import "LLBoostView.h"

#import "LLGetStep.h"
#import "LLOriginalBackgroundFilterView.h"

#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5


@interface LLHomePageViewController ()<UIGestureRecognizerDelegate>{
    BOOL ghostSelfInformationNotShow;
    UIButton *Screenshotbtn;
    CGFloat Pointer;
    CGFloat headings;
    PopMenu *popMenu;
    
    LLHomePageDisplayView *displayView;
    LLSearchAroundLocation *llsearchAroundLocation;

    LLOriginalBackgroundFilterView *OriginalBackgroundFilterView;
    LLFilterBackgroundView *FilterBackgroundView;
    LLFilterAlwaysView *filterAlwaysView;
    LLFilterView *filterView;

    BOOL showTheFilterChooseView;
    LLChooseView *chooseview;
    
    UIButton *ShowFilterBtn;
    UIButton *LLHomeMenubtn;
    
    __block UILabel *LLCountTimerLabel;
    BOOL HasShowtheMatureView;
    BOOL HasWaitingBallMatured;
    LLMatureView *llmature;
    
    UIImageView *LLMatureBackgroudView;
    UIView *LLDissmissView;
    LLWaitingBall *waitingBall;
    long int LLWaitingBallMatureTime;
    UITapGestureRecognizer *TapImmatureWaitingBall;
//    UILongPressGestureRecognizer *LongPressWaitingBall;
    UITapGestureRecognizer *TapMaturedWaitingBall;
    LLBoostView *llBoostView;
    UITapGestureRecognizer *dismissBoostViewGesture;
    UIView *LLDismissBoostView;
    
    NSTimer *flighterTimer;
    LLHomePageInformationView *pageInformationView;
    NSString *MainRoleFootStep;
    
    UITapGestureRecognizer *TapdisplayView;
    
    NSMutableArray *imageArray1;
    NSMutableArray *imageArray2;
    NSMutableArray *imageArray3;
}



@end


@implementation LLHomePageViewController

#pragma mark - view的生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;

    
    self.glView = [[OpenGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.glView];
    [self.glView setOrientation:[UIApplication sharedApplication].statusBarOrientation];


    [self drawfilterImageView];
    [self drawChooseView];
    [self drawview];
    [self ShowHiddenView];
    [self.glView setUserInteractionEnabled:YES];

    [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(Location) userInfo:nil repeats:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self configLocationManager];
    });

    [self.glView start];
    NSLog(@"打开页面时含有的能量%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"]);
    NSLog(@"首页将要开始");
        [self initArraywithName:@"filter_raining" andImageCount:10 ];

    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.glView stop];
    NSLog(@"首页将要结束");
    [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"LLNearestLocation"];
    [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"LLSecondNearestLocation"];
    [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"LLThirdNearestLocation"];
}


-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.glView resize:self.view.bounds orientation:[UIApplication sharedApplication].statusBarOrientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.glView setOrientation:toInterfaceOrientation];
}



#pragma mark - DrawView

-(void)drawview{
    //截图
    Screenshotbtn = [[UIButton alloc]init];
    Screenshotbtn.frame = CGRectMake(self.view.bounds.size.width*0.03,
                                     self.view.bounds.size.width*0.435,
                                     self.view.bounds.size.width*0.121,
                                     self.view.bounds.size.width*0.121);
    [Screenshotbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [Screenshotbtn setImage:[UIImage imageNamed:@"btn_camera"] forState:UIControlStateNormal];
    [Screenshotbtn addTarget:self action:@selector(Screenshot) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:Screenshotbtn];
    
    
    UIButton *showthehintBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.03,
                                                                         self.view.bounds.size.width*0.278,
                                                                         self.view.bounds.size.width*0.121,
                                                                         self.view.bounds.size.width*0.121)];
    //    showthehintBtn.backgroundColor =[UIColor yellowColor];
    [showthehintBtn setImage:[UIImage imageNamed:@"btn_card"] forState:UIControlStateNormal];
    [showthehintBtn addTarget:self action:@selector(showHintView) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:showthehintBtn];
    
    
    ghostSelfInformationNotShow = NO;
    
    displayView = [[LLHomePageDisplayView alloc]init];
    displayView.frame = CGRectMake(self.view.bounds.size.width*0.03,
                                   self.view.bounds.size.width*0.08,
                                   self.view.bounds.size.width*0.282,
                                   self.view.bounds.size.width*0.145);
    displayView.backgroundColor = [UIColor clearColor];
    if (displayView.LLHomeDisplayLabel.text <= 0) {
        displayView.LLHomeDisplayLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:17];
        displayView.LLHomeDisplayLabel.text = @"正在定位中";
    }
    [self.glView addSubview:displayView];
    
    TapdisplayView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeNearLocation:)];
    [displayView addGestureRecognizer:TapdisplayView];
    
    pageInformationView = [[LLHomePageInformationView alloc]init];
    [self LoadStepCount];
    pageInformationView.LLMainRoleEnergyValue = MainRoleFootStep;
    pageInformationView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.638, [UIScreen mainScreen].bounds.size.width*0.08, [UIScreen mainScreen].bounds.size.width*0.5652, [UIScreen mainScreen].bounds.size.width*0.3623);
    pageInformationView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:pageInformationView];
    
    
    LLHomeMenubtn = [[UIButton alloc]init];
    LLHomeMenubtn.frame = CGRectMake(self.view.bounds.size.width*0.845,
                                     self.view.bounds.size.height*0.91,
                                     self.view.bounds.size.width*0.131,
                                     self.view.bounds.size.width*0.120);
    UIImage *homemenuimage = [UIImage imageNamed:@"btn_list"];
    UIImageView *HomeMenuBtnBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                                   self.view.bounds.size.width*0.131,
                                                                                   self.view.bounds.size.width*0.120)];
    HomeMenuBtnBackImg.image = homemenuimage;
    [LLHomeMenubtn addSubview:HomeMenuBtnBackImg];
    [self.glView addSubview:LLHomeMenubtn];
    [LLHomeMenubtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

    ShowFilterBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.03,
                                                              self.view.bounds.size.height*0.91,
                                                              self.view.bounds.size.width*0.131,
                                                              self.view.bounds.size.width*0.118)];
    UIImageView *showFilterBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                                  self.view.bounds.size.width*0.131,
                                                                                  self.view.bounds.size.width*0.118)];
    [ShowFilterBtn addSubview:showFilterBackImg];
    showFilterBackImg.image = [UIImage imageNamed:@"btn_filter"];
    [ShowFilterBtn addTarget:self action:@selector(showFilterChooseView) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:ShowFilterBtn];
    

    
    waitingBall = [[LLWaitingBall alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.797,
                                                                 [UIScreen mainScreen].bounds.size.width*0.4347,
                                                                 [UIScreen mainScreen].bounds.size.width*0.169,
                                                                 [UIScreen mainScreen].bounds.size.width*0.1691)];
    [waitingBall setUserInteractionEnabled:YES];
    [waitingBall LLBallAlwaysDraw];
    [self.glView addSubview:waitingBall];
    
    LLCountTimerLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.821,
                                                                 [UIScreen mainScreen].bounds.size.width*0.603,
                                                                 [UIScreen mainScreen].bounds.size.width*0.2415,
                                                                 [UIScreen mainScreen].bounds.size.width*0.072)];
    LLCountTimerLabel.textColor = [UIColor colorWithDisplayP3Red:212.0/255.0 green:202.0/255.0 blue:255.0/255.0 alpha:1];
//    LLCountTimerLabel.font = [UIFont ]
    [self.glView addSubview:LLCountTimerLabel];
    [self loadInterviewTime];

    if (!HasWaitingBallMatured) {
        TapImmatureWaitingBall = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShortTapImmatureWaitingBall:)];
        [waitingBall addGestureRecognizer:TapImmatureWaitingBall];
        
    }else{
        TapMaturedWaitingBall = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapMaturedWaitingBall:)];
        [waitingBall addGestureRecognizer:TapMaturedWaitingBall];
        
    }

}




-(void)ShowHiddenView{
  
    LLDissmissView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    LLDissmissView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    LLDissmissView.hidden = YES;
    [self.glView addSubview:LLDissmissView];
    
    
    
    UITapGestureRecognizer *tapMatureViewToHome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissMatureView)];
    [LLDissmissView addGestureRecognizer:tapMatureViewToHome];
    
    LLMatureBackgroudView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 0, 0)];
    [LLMatureBackgroudView.layer setCornerRadius:10];
    LLMatureBackgroudView.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:56.0/255.0 blue:87.0/255.0 alpha:1];
    [self.glView addSubview:LLMatureBackgroudView];
    
    llmature = [[LLMatureView alloc]init];
    HasShowtheMatureView = NO;
    


    [llmature drawRect:CGRectMake(0,0, 0, 0)];
    [LLMatureBackgroudView addSubview:llmature];
    

    
    LLDismissBoostView = [[UIView alloc]init];
    LLDismissBoostView.frame = CGRectMake(0, 0, self.glView.frame.size.width, self.glView.frame.size.height);
    LLDismissBoostView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    LLDismissBoostView.hidden = YES;
    [self.glView addSubview:LLDismissBoostView];
    
    //
    llBoostView = [[LLBoostView alloc]init];
    llBoostView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.19,
                                   self.glView.bounds.size.width*0.35,
                                   [UIScreen mainScreen].bounds.size.width*0.613,
                                   [UIScreen mainScreen].bounds.size.width*0.373);
    llBoostView.backgroundColor = [UIColor clearColor];
    llBoostView.hidden = YES;
    [LLDismissBoostView addSubview:llBoostView];
    
    dismissBoostViewGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissBoostView)];
    dismissBoostViewGesture.delegate = self;
    [self.glView addGestureRecognizer:dismissBoostViewGesture];
//    [self gestureRecognizer:dismissBoostViewGesture shouldReceiveTouch:touch];

}

-(void)changeNearLocation:(UITapGestureRecognizer *)gesture{
    NSLog(@"点击了displayview");
    //点击第一跳到第二 第二跳到第三 第三跳到第三 第三跳到第一 其余显示 继续定位
    NSString *locationString = displayView.LLHomeDisplayLabel.text;
    NSString *location1 = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLNearestLocation"];
    NSString *location2 = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLSecondNearestLocation"];
    NSString *location3 = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLThirdNearestLocation"];
    if ([locationString isEqualToString: location1]) {
        displayView.LLHomeDisplayLabel.text = location3;
        [displayView removeGestureRecognizer:TapdisplayView];
        [self performSelector:@selector(changelabeldongxiao1) withObject:nil afterDelay:0.15];
    }else if ([locationString isEqualToString:location2]) {
        displayView.LLHomeDisplayLabel.text = location3;
        
    }else if([locationString isEqualToString:location3]){
        displayView.LLHomeDisplayLabel.text = location1;
    }else{
        displayView.LLHomeDisplayLabel.text= @"继续查找";
    }

}
-(void)changelabeldongxiao1{
    displayView.LLHomeDisplayLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLSecondNearestLocation"];
    [self performSelector:@selector(changelabeldongxiao2) withObject:nil afterDelay:0.15];
}
-(void)changelabeldongxiao2{
    displayView.LLHomeDisplayLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLNearestLocation"];
    [self performSelector:@selector(changelabeldongxiao3) withObject:nil afterDelay:0.15];
}
-(void)changelabeldongxiao3{
    displayView.LLHomeDisplayLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLSecondNearestLocation"];
    [displayView addGestureRecognizer:TapdisplayView];
}



- (BOOL)gestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if([touch.view isKindOfClass:[LLBoostView class]]){;
            return NO;
    }
    return YES;
}





#pragma mark - 加载数据

-(void)loadInterviewTime{
    //成熟所需时间3600
    LLWaitingBallMatureTime = 3600;
    LLGetNowTime *llgetnowtime = [[LLGetNowTime alloc]init];
    long int Intervaltime = [llgetnowtime LLGetIntervalTime];

    if (Intervaltime >= 3600 ) {
        LLCountTimerLabel.text = @"已成熟";
        HasWaitingBallMatured = YES;
    }else{
        //成熟所需时间＝ 成熟所需时间－当前时间与最后纪录时间间隔
        long int Remaintime = LLWaitingBallMatureTime - Intervaltime;
        NSString *intervaltime = [NSString stringWithFormat:@"%ld",Remaintime];
        //存下小球的intervaltime
        [[NSUserDefaults standardUserDefaults]setValue:intervaltime forKey:@"WaitingBallMatureTime"];
        NSLog(@"当前IntervalTime%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"WaitingBallMatureTime"]);
        [self CountTimerAnimation:Remaintime];
        HasWaitingBallMatured = NO;
    }
//    LLWaitingBallMatureTime = Intervaltime;
    NSLog(@"%ld",Intervaltime);
}


-(void)LoadStepCount{
    LLGetStep *getStep = [[LLGetStep alloc]init];
    [getStep CreatHealth];
    MainRoleFootStep = [[NSUserDefaults standardUserDefaults] objectForKey:@"Energy"];
    
    NSLog(@"LoadStepCount%@",MainRoleFootStep);
    
}
#pragma mark - 光体不成熟页面动画
-(void)showWaitingBallBoostView{
    llBoostView.hidden = NO;
    [self LoadStepCount];
    //当前步行能量
    llBoostView.LLNowEnergy = [MainRoleFootStep intValue];
    //加速完成所需能量 ＝ 秒数
    LLGetNowTime *llgetnowtime = [[LLGetNowTime alloc]init];
    long int Intervaltime = [llgetnowtime LLGetIntervalTime];
    llBoostView.LLMatureNeedEnergy  = 3600 - Intervaltime;
    
    [llBoostView DrawinNeed];
    POPSpringAnimation *BoostViewSize = [POPSpringAnimation animation];
    BoostViewSize.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    BoostViewSize.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.613, [UIScreen mainScreen].bounds.size.width*0.373)];
    BoostViewSize.springBounciness = 5.0;
    BoostViewSize.springSpeed      = 10.0;
    [llBoostView.LLBoostcontentView pop_addAnimation:BoostViewSize forKey:@"BoostViewsizePOP"];
    
    LLDismissBoostView.hidden = NO;
    
    [self performSelector:@selector(InitImmatureView) withObject:nil afterDelay:0.1];
}

//-(void)LLboostTap{
//    NSLog(@"点击");
//}

-(void)InitImmatureView{
    llBoostView.LLTapBoostbtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.121,
                                                 [UIScreen mainScreen].bounds.size.width*0.2146,
                                                 [UIScreen mainScreen].bounds.size.width*0.3623,
                                                 [UIScreen mainScreen].bounds.size.width*0.1);
    [llBoostView.LLTapBoostbtn addTarget:self action:@selector(LLboostTap) forControlEvents:UIControlEventTouchUpInside];
    [llBoostView addSubview:llBoostView.LLTapBoostbtn];
    llBoostView.LLBoostContextLabel.frame = CGRectMake(0,
                                                       [UIScreen mainScreen].bounds.size.width*0.048,
                                                       [UIScreen mainScreen].bounds.size.width*0.613,
                                                       [UIScreen mainScreen].bounds.size.width*0.12);

}
-(void)LLboostTap{
    /*
     加速waitingball成熟
     1.没有行走的能量 退出boostview
     2.行走能量不够 当前所有步行能量加速
     */
    LLGetNowTime *llgetnowtime = [[LLGetNowTime alloc]init];
    long int Intervaltime = [llgetnowtime LLGetIntervalTime];
    long int MatureNeedTime = 3600 - Intervaltime;
    
    NSString *energyString = [[NSUserDefaults standardUserDefaults] objectForKey:@"Energy"];
    int energy = [energyString intValue];
    
    if(energy <= 0){
            [self dismissBoostView];
    }else if( energy <= MatureNeedTime && energy>0){
            [self dismissBoostView];
        
            NSString *CurrentIntervalTimeString = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLLastRecordTime"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *CurrentIntervalTime = [formatter dateFromString:CurrentIntervalTimeString];
        
        //    // 更具当前date和时间间隔生成的得到一个新的date对象
            NSDate *newDate = [CurrentIntervalTime dateByAddingTimeInterval:-energy];
            NSString *newDateString = [formatter stringFromDate:newDate];
            [[NSUserDefaults standardUserDefaults]setValue:newDateString forKey:@"LLLastRecordTime"];
        [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"Energy"];
        //更新UI
        //成熟时间减去步行能量
        MatureNeedTime = MatureNeedTime - energy;
        [LLCountTimerLabel pop_removeAllAnimations];
//            LLCountTimerLabel.text = nil;
        //    NSLog(@"%ld",Remaintime);
        [self CountTimerAnimation:MatureNeedTime];
    }else{
        [self dismissBoostView];
        [LLCountTimerLabel pop_removeAllAnimations];
        LLCountTimerLabel.text = @"已成熟";
        //数据层
        NSString *CurrentIntervalTimeString = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLLastRecordTime"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *CurrentIntervalTime = [formatter dateFromString:CurrentIntervalTimeString];
        // 更具当前date和时间间隔生成的得到一个新的date对象
        NSDate *newDate = [CurrentIntervalTime dateByAddingTimeInterval:-MatureNeedTime];
        NSString *newDateString = [formatter stringFromDate:newDate];
        [[NSUserDefaults standardUserDefaults]setValue:newDateString forKey:@"LLLastRecordTime"];
        [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"Energy"];
    }

}

-(void)dismissBoostView{
//    NSLog(@"点击dismissview");
    LLDismissBoostView.hidden = YES;
    POPSpringAnimation *BoostViewSize = [POPSpringAnimation animation];
    BoostViewSize.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    BoostViewSize.toValue = [NSValue valueWithCGRect:CGRectMake(llBoostView.bounds.size.width/2, llBoostView.bounds.size.height/2, 0, 0)];
    BoostViewSize.springBounciness = 20.0;
    BoostViewSize.springSpeed      = 10.0;
    [llBoostView.LLBoostcontentView pop_addAnimation:BoostViewSize forKey:@"BoostViewsizeDismiss"];
    
    llBoostView.LLTapBoostbtn.frame = CGRectMake(30, 130, 0, 0);
    llBoostView.LLBoostContextLabel.frame = CGRectMake(10, 10, 0, 0);
    llBoostView.LLBoostcontentView.frame = CGRectMake(0, 0, 0, 0);
    llBoostView.hidden = YES;
}

#pragma mark - 光体成熟页面动画
-(void)SetWaitingBallMature{
    
    [waitingBall pop_removeAllAnimations];
    LLCountTimerLabel.text = @"已成熟";
    [LLCountTimerLabel setNeedsLayout];
    HasWaitingBallMatured = YES;
    //去掉长按短按手势
    [waitingBall removeGestureRecognizer:TapImmatureWaitingBall];
//    [waitingBall removeGestureRecognizer:LongPressWaitingBall];
    
    TapMaturedWaitingBall = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapMaturedWaitingBall:)];
    [waitingBall addGestureRecognizer:TapMaturedWaitingBall];
    
    
}
-(void)showWaitingBallMatureView{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake(self.view.center.x-140, self.view.center.y-190,
                                                                [UIScreen mainScreen].bounds.size.width*0.676,
                                                                [UIScreen mainScreen].bounds.size.width*0.9)];
    LLDissmissView.hidden = NO;
    [self performSelector:@selector(initMaturethingsView) withObject:nil afterDelay:0.4];
    PopMatureView.springBounciness = 10.0;
    PopMatureView.springSpeed      = 10.0;
    [LLMatureBackgroudView pop_addAnimation:PopMatureView forKey:@"shortDismissView"];
    
}

-(void)initMaturethingsView{
    llmature.LLMatureImageView.frame = CGRectMake(40, 30, 200,200);
    llmature.LLGradeImageView.frame = CGRectMake(210, 210, 40, 40);
    llmature.LLMaturePpImageView.frame = CGRectMake(10, 300, 50, 50);
    llmature.LLMatureThingsLabel.frame = CGRectMake(80, 255, 80, 30);
    llmature.LLMaturePpThingsLabel.frame = CGRectMake(70, 315, 60, 20);
    llmature.LLCollectLabel.frame = CGRectMake(10, 0, 80, 20);
    llmature.LLProgressBgIMG.frame = CGRectMake(150, 320, 90, 20);
    llmature.LLProgressIMG.frame = CGRectMake(0, 0, 40, 20);
}


-(void)dismissMatureView{
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake(self.view.center.x, self.view.center.y, 0, 0)];
    LLDissmissView.hidden = YES;
    llmature.LLMatureImageView.frame = CGRectMake(40, 30, 0,0);
    llmature.LLGradeImageView.frame = CGRectMake(210, 210, 0, 0);
    llmature.LLMaturePpImageView.frame = CGRectMake(10, 300, 0, 0);
    llmature.LLMatureThingsLabel.frame = CGRectMake(80, 255, 0, 0);
    llmature.LLMaturePpThingsLabel.frame = CGRectMake(70, 315, 0, 0);
    llmature.LLCollectLabel.frame = CGRectMake(10, 0, 0, 0);
    llmature.LLProgressBgIMG.frame = CGRectMake(150, 320, 0,0);
    llmature.LLProgressIMG.frame = CGRectMake(0, 0, 0, 0);
    
    PopMatureView.springBounciness = 10.0;
    PopMatureView.springSpeed      = 10.0;
    [LLMatureBackgroudView pop_addAnimation:PopMatureView forKey:@"shortDismissView"];
}
#pragma mark - 定时光体计时器和动画

-(void)CountTimerAnimation:(long int)StopTime{
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            long int minute = (StopTime - (int)values[0])/60;
            long int second = (StopTime - (int)values[0] )% 60;
            LLCountTimerLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",minute,second];
        };
        
        //        prop.threshold = 0.01f;
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(0);   //从0开始
    anBasic.toValue = @(StopTime);  //180秒
    anBasic.duration = StopTime;    //持续3分钟
    anBasic.beginTime = CACurrentMediaTime() + 0.5f;    //延迟1秒开始
    [LLCountTimerLabel pop_addAnimation:anBasic forKey:@"countdown"];
    
//    [self performSelector:@selector(showWaitingBallMatureView) withObject:self afterDelay:StopTime];
    [self performSelector:@selector(SetWaitingBallMature) withObject:self afterDelay:StopTime+0.5f];

}


-(void)ShortTapImmatureWaitingBall:(UITapGestureRecognizer *)gesture{
//    NSLog(@"未成熟状态下点按");
    //waitingball弹起来
    POPSpringAnimation *waitingBallSize = [POPSpringAnimation animation];
    waitingBallSize.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
    
    //        buttonSizeAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(60, 60)];
    waitingBallSize.toValue = [NSValue valueWithCGSize:CGSizeMake(50, 50)];
    waitingBallSize.springBounciness = 20.0;
    waitingBallSize.springSpeed      = 10.0;
    [waitingBall pop_addAnimation:waitingBallSize forKey:@"sizePOP"];
    [self performSelector:@selector(recover) withObject:nil afterDelay:0.2];
    [self performSelector:@selector(showWaitingBallBoostView) withObject:nil afterDelay:0.6];
    
/*本来是短按减少10s 现在废弃
     //能量减少 时间减少
    NSString *CurrentIntervalTimeString = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLLastRecordTime"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *CurrentIntervalTime = [formatter dateFromString:CurrentIntervalTimeString];

    // 更具当前date和时间间隔生成的得到一个新的date对象
    NSDate *newDate = [CurrentIntervalTime dateByAddingTimeInterval:-9];
    NSString *newDateString = [formatter stringFromDate:newDate];
    [[NSUserDefaults standardUserDefaults]setValue:newDateString forKey:@"LLLastRecordTime"];
    
    LLGetNowTime *llgetnowtime = [[LLGetNowTime alloc]init];
    long int Intervaltime = [llgetnowtime LLGetIntervalTime];
    long int Remaintime = LLWaitingBallMatureTime - Intervaltime;
        NSLog(@"时间变少");
        [LLCountTimerLabel pop_removeAllAnimations];
  //       LLCountTimerLabel.text = nil;
        NSLog(@"%ld",Remaintime);
        [self CountTimerAnimation:Remaintime];

*/
    

}

-(void)recover{
    //waitingball恢复
    POPSpringAnimation *buttonSize = [POPSpringAnimation animation];
    buttonSize.property = [POPAnimatableProperty propertyWithName:kPOPLayerSize];
    buttonSize.toValue = [NSValue valueWithCGSize:CGSizeMake(70, 70)];
    buttonSize.springBounciness = 20.0;
    buttonSize.springSpeed      = 10.0;
    [waitingBall pop_addAnimation:buttonSize forKey:@"recover"];
}


-(void)TapMaturedWaitingBall:(UITapGestureRecognizer *)gesture{
    NSLog(@"TapMaturedWaitingBall");
    
    NSDate *RecordNowTime = [NSDate date];
    
    // 1.创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 2.设置时间格式化对象的样式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // 3.利用时间格式化对象对时间进行格式化
    NSString *RecordNowTimeString = [formatter stringFromDate:RecordNowTime];
    
    [[NSUserDefaults standardUserDefaults] setValue:RecordNowTimeString forKey:@"LLLastRecordTime"];
    NSLog(@"%@",RecordNowTimeString);
    
    [LLCountTimerLabel pop_removeAllAnimations];
    
    LLGetNowTime *llGetNowTime = [[LLGetNowTime alloc]init];
    long int Intervaltime = [llGetNowTime LLGetIntervalTime];
    
    long int Remaintime = LLWaitingBallMatureTime - Intervaltime;
    [self CountTimerAnimation:Remaintime];
    
//    HasWaitingBallMatured = NO;
    NSLog(@"%ld",Intervaltime);
    
    //去掉成熟完成的短按手势
    [waitingBall removeGestureRecognizer:TapMaturedWaitingBall];
    
    TapImmatureWaitingBall = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShortTapImmatureWaitingBall:)];
    [waitingBall addGestureRecognizer:TapImmatureWaitingBall];
    
    [self showWaitingBallMatureView];
}
#pragma mark - 滤镜选择


-(void)drawChooseView{
    chooseview = [[LLChooseView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height*1.26, self.view.bounds.size.width, self.view.bounds.size.height*0.26)];
    chooseview.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5];
    //    = [chooseview filterchange:chooseview.LLsilderchange];
    
    UISlider *_LLsilderchange = [[UISlider alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.04, self.view.bounds.size.width*0.013, self.view.bounds.size.width*0.92, self.view.bounds.size.width*0.070)];
    [_LLsilderchange setMinimumTrackTintColor:[UIColor clearColor]];
    [_LLsilderchange setMaximumTrackTintColor:[UIColor clearColor]];
    UIImageView *SliderBackgroudImge = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.04, self.view.bounds.size.width*0.036, self.view.bounds.size.width*0.92, self.view.bounds.size.width*0.063)];
    SliderBackgroudImge.image = [UIImage imageNamed:@"rail"];
    [chooseview addSubview:SliderBackgroudImge];
    
    [_LLsilderchange setThumbImage:[UIImage imageNamed:@"icon_light"] forState:UIControlStateNormal];
    _LLsilderchange.maximumValue = 0.9;
    _LLsilderchange.minimumValue = 0.15;
    _LLsilderchange.value = 0.1;
    [_LLsilderchange addTarget:self action:@selector(filterchange:) forControlEvents:UIControlEventValueChanged];
    [chooseview addSubview:_LLsilderchange];
    //    [chooseview.LLChoseViewBtn addTarget:self action:@selector(changefilter:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.glView addSubview:chooseview];
}


-(void)drawfilterImageView{
    
    FilterBackgroundView = [[LLFilterBackgroundView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height)];
    FilterBackgroundView.LLFilteralapa = 0.5;
    [FilterBackgroundView setImage];
    FilterBackgroundView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:FilterBackgroundView];
    
    OriginalBackgroundFilterView = [[LLOriginalBackgroundFilterView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
    OriginalBackgroundFilterView.LLOriginalfilterString = @"filter_raining";
    OriginalBackgroundFilterView.LLOriginalFilterCount = 10;
    [OriginalBackgroundFilterView LLInitOriginalFilter];
    [self.glView addSubview:OriginalBackgroundFilterView];
    
    filterView = [[LLFilterView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height)];
    filterView.backgroundColor = [UIColor clearColor];
    filterView.LLFilterName = @"FilterLighting";
    filterView.LLFiltercount = 50;
    
    flighterTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(Fliterfighting) userInfo:nil repeats:YES];
    [self.glView addSubview:filterView];
    
}


-(void)Fliterfighting{
    [filterView LLFilterFireDraw];
}

- (void)filterchange:(UISlider *) slider{
//    NSLog(@"%f",slider.value);
    FilterBackgroundView.LLFilteralapa = 1 - slider.value;
    NSLog(@"%f",FilterBackgroundView.LLFilteralapa);
    [FilterBackgroundView setImage];
    if (FilterBackgroundView.LLFilteralapa <= 0.70 && FilterBackgroundView.LLFilteralapa >= 0.65) {
//        [flighterTimer fire];
        [filterAlwaysView stopAnimating];
        filterAlwaysView.ImagesArray1 = imageArray1;
        filterAlwaysView.LLfilterAlwaysString = @"filter_raining";
        filterAlwaysView.LLAlwaysFilterCount = 10;
        [filterAlwaysView LLfilerAlwaysDraw];

    }
    if (FilterBackgroundView.LLFilteralapa >= 0.45 && FilterBackgroundView.LLFilteralapa <= 0.50) {
    [flighterTimer invalidate];
    [filterAlwaysView stopAnimating];
        filterAlwaysView.ImagesArray1 = imageArray2;
    filterAlwaysView.LLfilterAlwaysString = @"smallrain_";
    filterAlwaysView.LLAlwaysFilterCount = 120;
    [filterAlwaysView LLfilerAlwaysDraw];

    }
    else if(FilterBackgroundView.LLFilteralapa <= 0.25 && FilterBackgroundView.LLFilteralapa >= 0.20){
        [flighterTimer invalidate];
    [filterAlwaysView stopAnimating];
        filterAlwaysView.ImagesArray1 = imageArray3;
        filterAlwaysView.LLfilterAlwaysString = @"Fliter-rainbow-";
        filterAlwaysView.LLAlwaysFilterCount = 60;
        [filterAlwaysView LLfilerAlwaysDraw];
    }
    else{
    }
}

//滤镜选择的动画
-(void)showFilterChooseView{


    
    if (showTheFilterChooseView) {
        [self closechooseView];
        NSLog(@"chooseview关闭了");
        showTheFilterChooseView = NO;
        [OriginalBackgroundFilterView startAnimating];
        [filterAlwaysView stopAnimating];
        filterAlwaysView = nil;
    }else{
        [self showchooseView];
        //点击chooseview 就加载图片
        [self initArraywithName:@"filter_raining" andImageCount:10 ];
        [self initArraywithName2:@"smallrain_" andImageCount2:120];
        [self initArraywithName3:@"Fliter-rainbow-" andImageCount3:60];
        
        showTheFilterChooseView = YES;
        [OriginalBackgroundFilterView stopAnimating];
        
        filterAlwaysView = [[LLFilterAlwaysView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height)];
        filterAlwaysView.LLfilterAlwaysString = @"filter_raining";
        filterAlwaysView.LLAlwaysFilterCount = 10;
        filterAlwaysView.ImagesArray1 = imageArray1;
        [self performSelector:@selector(showtestfilter) withObject:nil afterDelay:0.5];
        [self.glView addSubview:filterAlwaysView];
        NSLog(@"chooseview打开了");
    }
}
-(void)showtestfilter{
    [filterAlwaysView LLfilerAlwaysDraw];
}
-(void)showchooseView{
    
    
    POPSpringAnimation *showchoose = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = self.view.center.x;
    CGFloat centerY = self.view.bounds.size.height*0.87;
    
    showchoose.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    showchoose.springBounciness = 4;
    showchoose.springSpeed = 6;
    [chooseview pop_addAnimation:showchoose forKey:@"showChooseView"];
    
    POPSpringAnimation *filterbtnUP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerfilterbtnupX = self.view.bounds.size.width*0.094;
    CGFloat centerfilterbtnupY = self.view.bounds.size.height*0.69;
    
    filterbtnUP.toValue = [NSValue valueWithCGPoint:CGPointMake(centerfilterbtnupX, centerfilterbtnupY)];
    filterbtnUP.springBounciness = 4;
    filterbtnUP.springSpeed = 6;
    [ShowFilterBtn pop_addAnimation:filterbtnUP forKey:@"filterbtnup"];
    
    POPSpringAnimation *menubtnUP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat menubtnUPX = self.view.bounds.size.width*0.905;
    CGFloat menubtnUPY = self.view.bounds.size.height*0.69;
    
    menubtnUP.toValue = [NSValue valueWithCGPoint:CGPointMake(menubtnUPX, menubtnUPY)];
    menubtnUP.springBounciness = 4;
    menubtnUP.springSpeed = 6;
    [LLHomeMenubtn pop_addAnimation:menubtnUP forKey:@"menubtnup"];
    
}

-(void)closechooseView{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = self.view.center.x;
    CGFloat centerY = self.view.bounds.size.height*1.20;
    
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    anim.springBounciness = 4;
    anim.springSpeed = 6;
    [chooseview pop_addAnimation:anim forKey:@"closeChooseView"];
    
    POPSpringAnimation *filterbtnUP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerfilterbtnupX = self.view.bounds.size.width*0.094;
    CGFloat centerfilterbtnupY = self.view.bounds.size.height*0.95;
    
    filterbtnUP.toValue = [NSValue valueWithCGPoint:CGPointMake(centerfilterbtnupX, centerfilterbtnupY)];
    filterbtnUP.springBounciness = 4;
    filterbtnUP.springSpeed = 6;
    [ShowFilterBtn pop_addAnimation:filterbtnUP forKey:@"filterbtndown"];
    
    POPSpringAnimation *menubtnUP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat menubtnUPX = self.view.bounds.size.width*0.905;
    CGFloat menubtnUPY = self.view.bounds.size.height*0.95;
    
    menubtnUP.toValue = [NSValue valueWithCGPoint:CGPointMake(menubtnUPX, menubtnUPY)];
    menubtnUP.springBounciness = 4;
    menubtnUP.springSpeed = 6;
    [LLHomeMenubtn pop_addAnimation:menubtnUP forKey:@"menubtndown"];
}

-(void)initArraywithName:(NSString *)name andImageCount:(int)imageCount{
    NSLog(@"读内存");
    imageArray1 = nil;
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        //                    __block UIImage *image = nil;
        dispatch_sync(concurrentQueue, ^{
            imageArray1 =  [NSMutableArray arrayWithCapacity:imageCount];
            for (int i = 1; i <= imageCount; i++) {
                NSString *imageName = [NSString stringWithFormat:@"%@%d",name,i];
                NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
                //        NSLog(@"%@",path);
                UIImage *image = [UIImage imageWithContentsOfFile:path];
//                NSLog(@"%@",image);
                [imageArray1 addObject:image];
            }
            
        });
    });
}
-(void)initArraywithName2:(NSString *)name andImageCount2:(int)imageCount{
    NSLog(@"读内存");
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        //                    __block UIImage *image = nil;
        dispatch_sync(concurrentQueue, ^{
            imageArray2 =  [NSMutableArray arrayWithCapacity:imageCount];
            for (int i = 1; i <= imageCount; i++) {
                NSString *imageName = [NSString stringWithFormat:@"%@%d",name,i];
                NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
                //        NSLog(@"%@",path);
                UIImage *image = [UIImage imageWithContentsOfFile:path];
                //        NSLog(@"%@",imageName);
                [imageArray2 addObject:image];
                //                [imageArray1 addObjectsFromArray:tempArray];
            }
            
        });
    });
}

-(void)initArraywithName3:(NSString *)name andImageCount3:(int)imageCount{
    NSLog(@"读内存");
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        //                    __block UIImage *image = nil;
        dispatch_sync(concurrentQueue, ^{
            imageArray3 =  [NSMutableArray arrayWithCapacity:imageCount];
            for (int i = 1; i <= imageCount; i++) {
                NSString *imageName = [NSString stringWithFormat:@"%@%d",name,i];
                NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
                //        NSLog(@"%@",path);
                UIImage *image = [UIImage imageWithContentsOfFile:path];
                //        NSLog(@"%@",imageName);
                [imageArray3 addObject:image];
                //                [imageArray1 addObjectsFromArray:tempArray];
            }
            
        });
    });
}



#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{

    return [HintViewPresent new];
}

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
//                                                                  presentingController:(UIViewController *)presenting
//                                                                      sourceController:(UIViewController *)source
//{
//    return [LLMatureViewPresent new];
//}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [HintViewDismiss new];
}

-(void)showHintView{
//    LLDissmissView.hidden = NO;
    LLHintViewController *testVC = [LLHintViewController new];
    testVC.transitioningDelegate = self;
    testVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:testVC
                                            animated:YES
                                          completion:NULL];
}




#pragma mark - 截图
-(void)Screenshot{
    UIImage *viewImage = [self glToUIImage];
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//然后将该图片保存到图片图
    [JCAlertView showOneButtonWithTitle:@"" Message:@"截图成功" ButtonType:JCAlertViewButtonTypeDefault ButtonTitle:@"OK" Click:nil];
}

-(UIImage *) glToUIImage {
    CGSize viewSize=self.view.frame.size;
    NSInteger myDataLength = viewSize.width * viewSize.height * 4;
    
    GLubyte *buffer = (GLubyte *) malloc(myDataLength);
    glReadPixels(0, 0, viewSize.width, viewSize.height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    
    GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
    for(int y = 0; y < viewSize.height; y++)
    {
        for(int x = 0; x < viewSize.width* 4; x++)
        {
            buffer2[(int)((viewSize.height-1 - y) * viewSize.width * 4 + x)] = buffer[(int)(y * 4 * viewSize.width + x)];
        }
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
    
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * viewSize.width;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    // make the cgimage
    CGImageRef imageRef = CGImageCreate(viewSize.width , viewSize.height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
    // then make the uiimage from that
    UIImage *myImage = [UIImage imageWithCGImage:imageRef];
    return myImage;
}

#pragma mark - 定位
- (void)configLocationManager
{
    locationManager = [[AMapLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    
    //设置期望定位精度
    [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
//    //设置不允许系统暂停定位
//    [locationManager setPausesLocationUpdatesAutomatically:NO];

//    //设置允许在后台定位
//    [locationManager setAllowsBackgroundLocationUpdates:YES];
//    
//    //设置定位超时时间
    [locationManager setLocationTimeout:DefaultLocationTimeout];
//
//    [locationManager setLocatingWithReGeocode:YES];
    
//    [locationManager startUpdatingLocation];
    [self Location];

    
}


-(void)Location{
    
    [locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            displayView.LLHomeDisplayLabel.text = @"重新定位中…";
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }else{
            llsearchAroundLocation = [[LLSearchAroundLocation alloc]init];
            [llsearchAroundLocation GetRequestionlongitude:location.coordinate.longitude latitude:location.coordinate.latitude];
//            [llsearchAroundLocation GetRequestionlongitude:200 latitude:80];
//            if (llsearchAroundLocation.LLNearestLocation.count) {
////                displayView.LLHomeDisplayLabel.text = @"重新定位中";
//            }else{
                displayView.LLHomeDisplayLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLNearestLocation"];
 //               NSLog(@"最近的地点%@",[threeLocations objectAtIndex:0]);
//            }
//            [self performSelector:@selector(changedisplayLabel) withObject:nil afterDelay:1.0];
        }
        
        NSLog(@"coordinate.latitude:%f,%f", location.coordinate.latitude,location.coordinate.longitude);
    }];
}

-(void)changedisplayLabel{
    
//        NSLog(@"%@",displayView.LLHomeDisplayLabel);
}

//-(void)
#pragma mark - 地理围栏
//-(void)initLocatalFencewithCoordinatelongitude:(float)Coordinatelongitude latitude:(float)Coordinatelatitude{
//    AMapLocationCircleRegion *cirRegion200 = [[AMapLocationCircleRegion alloc] initWithCenter:coordinate
//                                                                                                           radius:200.0
//                                                                                                       identifier:@"circleRegion200"];
//}


#pragma mark - pop菜单
- (void)showMenu {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    
    MenuItem *menuItem = [MenuItem itemWithTitle:@"SelfGotThing" iconName:@"btn"];
    [items addObject:menuItem];
    
//    menuItem = [MenuItem itemWithTitle:@"碎片箱" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.840 green:0.264 blue:0.208 alpha:0.800]];
//    [items addObject:menuItem];
//    
//    menuItem = [MenuItem itemWithTitle:@"道具箱" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.232 green:0.442 blue:0.687 alpha:0.800]];
//    [items addObject:menuItem];
//    
//    menuItem = [MenuItem itemWithTitle:@"排名" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.000 green:0.509 blue:0.687 alpha:0.800]];
//    [items addObject:menuItem];
//    
//    menuItem = [MenuItem itemWithTitle:@"活动版块" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.687 green:0.164 blue:0.246 alpha:0.800]];
//    [items addObject:menuItem];
//    
//    menuItem = [MenuItem itemWithTitle:@"舰队" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.800]];
//    [items addObject:menuItem];
    
    if (!popMenu) {
        popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
    }
    if (popMenu.isShowed) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        NSLog(@"%@",selectedItem.title);
        if ([selectedItem.title isEqual:@"SelfGotThing"]) {
        [weakSelf pushpunchView];
        }

    };
    
    [popMenu showMenuAtView:self.view];
    
    //    [_popMenu showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}

-(void)pushpunchView{
        [self performSegueWithIdentifier:@"LLSelfInformation" sender:nil];
}
@end
