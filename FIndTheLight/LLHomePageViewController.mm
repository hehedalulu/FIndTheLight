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

#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5


@interface LLHomePageViewController (){
    BOOL ghostSelfInformationNotShow;
    UIButton *Screenshotbtn;
    CGFloat Pointer;
    CGFloat headings;
    PopMenu *popMenu;
    
    LLHomePageDisplayView *displayView;
    LLSearchAroundLocation *llsearchAroundLocation;

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
//    BOOL HasLongPress;
    UIView *LLDismissBoostView;
    
    NSTimer *flighterTimer;
    NSString *MainRoleFootStep;
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
    NSLog(@"首页将要开始");

    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.glView stop];
    NSLog(@"首页将要结束");
}


-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.glView resize:self.view.bounds orientation:[UIApplication sharedApplication].statusBarOrientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.glView setOrientation:toInterfaceOrientation];
}



//-(BOOL)prefersStatusBarHidden{
//    
//    return YES;
//}


#pragma mark - DrawView

-(void)drawview{
    //截图
    Screenshotbtn = [[UIButton alloc]init];
    Screenshotbtn.frame = CGRectMake(self.view.bounds.size.width*0.03, 180, 50, 50);
    [Screenshotbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [Screenshotbtn setImage:[UIImage imageNamed:@"btn_camera"] forState:UIControlStateNormal];
    [Screenshotbtn addTarget:self action:@selector(Screenshot) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:Screenshotbtn];
    
    
    UIButton *showthehintBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.03, 115,50, 50)];
    //    showthehintBtn.backgroundColor =[UIColor yellowColor];
    [showthehintBtn setImage:[UIImage imageNamed:@"btn_card"] forState:UIControlStateNormal];
    [showthehintBtn addTarget:self action:@selector(showHintView) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:showthehintBtn];
    
    
    ghostSelfInformationNotShow = NO;
    
    
    displayView = [[LLHomePageDisplayView alloc]init];
    displayView.frame = CGRectMake(self.view.bounds.size.width*0.03, 33, 117, 60);
    displayView.backgroundColor = [UIColor clearColor];
    if (displayView.LLHomeDisplayLabel.text <= 0) {
        displayView.LLHomeDisplayLabel.text = @"正在定位中";
    }
    [self.glView addSubview:displayView];
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
//    tapGesture.delegate = (id <UIGestureRecognizerDelegate>)self;
//    [displayView addGestureRecognizer:tapGesture];
    
    LLHomePageInformationView *pageInformationView = [[LLHomePageInformationView alloc]init];
    [self LoadStepCount];
    pageInformationView.LLMainRoleEnergyValue = MainRoleFootStep;
    pageInformationView.frame = CGRectMake(264, 33, 234, 150);
    pageInformationView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:pageInformationView];
    
    
    LLHomeMenubtn = [[UIButton alloc]init];
    LLHomeMenubtn.frame = CGRectMake(self.view.bounds.size.width*0.845, self.view.bounds.size.height*0.91, self.view.bounds.size.width*0.131, self.view.bounds.size.width*0.120);
    UIImage *homemenuimage = [UIImage imageNamed:@"btn_list"];
    UIImageView *HomeMenuBtnBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width*0.131, self.view.bounds.size.width*0.120)];
    HomeMenuBtnBackImg.image = homemenuimage;
    [LLHomeMenubtn addSubview:HomeMenuBtnBackImg];
    [self.glView addSubview:LLHomeMenubtn];
    [LLHomeMenubtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

    ShowFilterBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.03, self.view.bounds.size.height*0.91, self.view.bounds.size.width*0.131, self.view.bounds.size.width*0.118)];
    UIImageView *showFilterBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width*0.131, self.view.bounds.size.width*0.118)];
    [ShowFilterBtn addSubview:showFilterBackImg];
    showFilterBackImg.image = [UIImage imageNamed:@"btn_filter"];
    [ShowFilterBtn addTarget:self action:@selector(showFilterChooseView) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:ShowFilterBtn];
    

    
    waitingBall = [[LLWaitingBall alloc]initWithFrame:CGRectMake(330, 180, 70, 70)];
    [waitingBall setUserInteractionEnabled:YES];
    [waitingBall LLBallAlwaysDraw];
    [self.glView addSubview:waitingBall];
    
    LLCountTimerLabel = [[UILabel alloc]initWithFrame:CGRectMake(340, 250, 100, 30)];
    LLCountTimerLabel.textColor = [UIColor colorWithDisplayP3Red:212.0/255.0 green:202.0/255.0 blue:255.0/255.0 alpha:1];
    [self.glView addSubview:LLCountTimerLabel];
    [self loadInterviewTime];

    if (!HasWaitingBallMatured) {
        TapImmatureWaitingBall = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShortTapImmatureWaitingBall:)];
        [waitingBall addGestureRecognizer:TapImmatureWaitingBall];
        
    }else{
        TapMaturedWaitingBall = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapMaturedWaitingBall:)];
        [waitingBall addGestureRecognizer:TapMaturedWaitingBall];
        
    }
    

    
    
//    UIImageView *testView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
//    [testView setUserInteractionEnabled:YES];
//    testView.backgroundColor = [UIColor purpleColor];
//    [self.glView addSubview:testView];
    
//    UITapGestureRecognizer *taptestView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(testtap)];
//    [testView addGestureRecognizer:taptestView];
//    [self showWaitingBallMatureView];

}




-(void)ShowHiddenView{

    
    LLDissmissView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    LLDissmissView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    LLDissmissView.hidden = YES;
    [self.glView addSubview:LLDissmissView];
    
    
    
    UITapGestureRecognizer *tapMatureViewToHome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissMatureView)];
    [LLDissmissView addGestureRecognizer:tapMatureViewToHome];
    
    LLMatureBackgroudView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 0, 0)];
    LLMatureBackgroudView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/225.0 alpha:1.0];
    [self.glView addSubview:LLMatureBackgroudView];
    
    llmature = [[LLMatureView alloc]init];
    HasShowtheMatureView = NO;
    

    llmature.backgroundColor = [UIColor greenColor];
    [llmature drawRect:CGRectMake(0,0, 0, 0)];
    [LLMatureBackgroudView addSubview:llmature];
    
    llBoostView = [[LLBoostView alloc]init];
    [llBoostView drawRect:CGRectMake(self.view.center.x+100, self.view.center.y+100, 0, 0)];
    llBoostView.userInteractionEnabled = YES;
//    llBoostView.hidden = YES;
    
    LLDismissBoostView = [[UIView alloc]init];
    LLDismissBoostView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    LLDismissBoostView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    LLDismissBoostView.hidden = YES;
    [self.glView addSubview:LLDismissBoostView];
    
    UITapGestureRecognizer *dismissBoostView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissBoostView)];
    [LLDismissBoostView addGestureRecognizer:dismissBoostView];

    [self.glView addSubview:llBoostView];
    
    
    
}







#pragma mark - 加载数据

-(void)loadInterviewTime{
    LLWaitingBallMatureTime = 3600;
    LLGetNowTime *llgetnowtime = [[LLGetNowTime alloc]init];
    long int Intervaltime = [llgetnowtime LLGetIntervalTime];

    if (Intervaltime >= 3600 ) {
        LLCountTimerLabel.text = @"已成熟";
        HasWaitingBallMatured = YES;
    }else{
        long int Remaintime = LLWaitingBallMatureTime - Intervaltime;
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
    
}
#pragma mark - 光体不成熟页面动画
-(void)showWaitingBallBoostView{
//    llBoostView.hidden = NO;
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
//    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPLayerScaleXY];
//    PopMatureView.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.2, 0.2)];
//    PopMatureView.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    LLDismissBoostView.hidden = NO;
    [self performSelector:@selector(InitImmatureView) withObject:nil afterDelay:0.3];
    PopMatureView.springBounciness = 10.0;
    PopMatureView.springSpeed      = 10.0;
    [llBoostView pop_addAnimation:PopMatureView forKey:@"shortpopView"];
}

-(void)InitImmatureView{
    
    llBoostView.LLTapBoostbtn.frame = CGRectMake(30, 130, 150, 30);
    llBoostView.LLBoostContextLabel.frame = CGRectMake(10, 10, 180, 100);
    llBoostView.LLBoostcontentView.frame = CGRectMake(100, 200, 200, 200);
}

-(void)dismissBoostView{
    
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
//    PopMatureView.velocity = 0.1;
    LLDismissBoostView.hidden = YES;
    
//    llBoostView.frame = CGRectMake(self.view.center.x, self.view.center.y, 0, 0);
    llBoostView.LLTapBoostbtn.frame = CGRectMake(30, 130, 0, 0);
    llBoostView.LLBoostContextLabel.frame = CGRectMake(10, 10, 0, 0);
    llBoostView.LLBoostcontentView.frame = CGRectMake(100, 200, 0, 0);
    
    PopMatureView.springBounciness = 10.0;
    PopMatureView.springSpeed      = 10.0;
    [llBoostView pop_addAnimation:PopMatureView forKey:@"shortDismissView"];
}

#pragma mark - 光体成熟页面动画
-(void)SetWaitingBallMature{
    
    [waitingBall pop_removeAllAnimations];
    LLCountTimerLabel.text = @"已成熟";
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
    PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake(self.view.center.x-140, self.view.center.y-190, 280, 380)];
    LLDissmissView.hidden = NO;
    [self performSelector:@selector(initMaturethingsView) withObject:nil afterDelay:0.3];
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
    NSLog(@"未成熟状态下点按");
    [self showWaitingBallBoostView];
    
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
    chooseview.backgroundColor = [UIColor colorWithRed:115.0/255.0 green:115.0/255.0 blue:115.0/255.0 alpha:1];
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
    _LLsilderchange.value = 0.5;
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
    
    
    filterAlwaysView = [[LLFilterAlwaysView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height)];
    filterAlwaysView.LLfilterAlwaysString = @"filter_raining";
    filterAlwaysView.LLAlwaysFilterCount = 10;

    [filterAlwaysView LLfilerAlwaysDraw];
    FilterBackgroundView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:filterAlwaysView];
    
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
    if (FilterBackgroundView.LLFilteralapa <= 0.69 && FilterBackgroundView.LLFilteralapa >= 0.68) {
        [flighterTimer fire];
        [filterAlwaysView stopAnimating];
        filterAlwaysView.LLfilterAlwaysString = @"filter_raining";
        filterAlwaysView.LLAlwaysFilterCount = 10;
        [filterAlwaysView LLfilerAlwaysDraw];

    }if (FilterBackgroundView.LLFilteralapa >= 0.46 && FilterBackgroundView.LLFilteralapa <= 0.47) {
    [flighterTimer invalidate];
    [filterAlwaysView stopAnimating];
    filterAlwaysView.LLfilterAlwaysString = @"smallrain_";
    filterAlwaysView.LLAlwaysFilterCount = 120;
    [filterAlwaysView LLfilerAlwaysDraw];

    }
    else if(FilterBackgroundView.LLFilteralapa <= 0.25 && FilterBackgroundView.LLFilteralapa >= 0.24){
        [flighterTimer invalidate];
    [filterAlwaysView stopAnimating];
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
        showTheFilterChooseView = NO;
    }else{
        [self showchooseView];
        showTheFilterChooseView = YES;
    }
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
            if (llsearchAroundLocation.LLNearestLocation == nil) {
                displayView.LLHomeDisplayLabel.text = @"重新定位中";
            }else{
                displayView.LLHomeDisplayLabel.text = llsearchAroundLocation.LLNearestLocation;
                NSLog(@"最近的地点%@",llsearchAroundLocation.LLNearestLocation);
            }

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
    
    MenuItem *menuItem = [MenuItem itemWithTitle:@"记步" iconName:@"post_type_bubble_twitter"];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"碎片箱" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.840 green:0.264 blue:0.208 alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"道具箱" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.232 green:0.442 blue:0.687 alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"排名" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.000 green:0.509 blue:0.687 alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"活动版块" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.687 green:0.164 blue:0.246 alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"舰队" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.800]];
    [items addObject:menuItem];
    
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
        if ([selectedItem.title isEqual:@"Flickr"]) {
        [weakSelf pushpunchView];
        }

    };
    
    
    
    [popMenu showMenuAtView:self.view];
    
    //    [_popMenu showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}

-(void)pushpunchView{
        [self performSegueWithIdentifier:@"PushPunchView" sender:nil];
}
@end
