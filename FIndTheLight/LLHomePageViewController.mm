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
#import "LLChooseView.h"
#import <POP/POP.h>
#import "GPUImage.h"
#import "LLWaitingBall.h"
//#import "LLMatureView.h"
#import "LLGetNowTime.h"
#import "LLBoostView.h"
#import "LLGetStep.h"
#import "LLAddStepsByEMMotion.h"
#import "LLLightBoxViewController.h"
#import "LLSetViewController.h"
#import "LLPunchSetArray.h"
#import "LLModelView.h"
#import "LLSuiPianVIew.h"
#import "LLVIewAnimation.h"


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

    BOOL showTheFilterChooseView;
    LLChooseView *chooseview;
    
    UIButton *ShowFilterBtn;
    UIButton *LLHomeMenubtn;
    
    __block UILabel *LLCountTimerLabel;
    BOOL HasShowtheMatureView;
    BOOL HasWaitingBallMatured;
//    LLMatureView *llmature;
    
//    UIImageView *LLMatureBackgroudView;
    UIView *LLDissmissView;
    LLWaitingBall *waitingBall;
    long int LLWaitingBallMatureTime;
    UITapGestureRecognizer *TapImmatureWaitingBall;
    UITapGestureRecognizer *TapMaturedWaitingBall;
    LLBoostView *llBoostView;
    UITapGestureRecognizer *dismissBoostViewGesture;
    UIView *LLDismissBoostView;
    
    NSTimer *flighterTimer;
    LLHomePageInformationView *pageInformationView;
    NSString *MainRoleFootStep;
    
    UITapGestureRecognizer *TapdisplayView;
    
    //第一次打开的判断定时器
    NSTimer *healthTimer;
    NSTimer *LocationTimer;
//    NSTimer *UpdateStepTimer;
    //重新绘制
    BOOL hasDraw;
    UIImageView *skViewBgImg;
    UIButton *showthehintBtn;
    UITapGestureRecognizer *closeChooseViewTap;
    
    
    LLModelView *llMatureModel;
    LLSuiPianVIew *llsuiPianView;
    UITapGestureRecognizer *tapMatureModel;
    int TapMatureModelCount;
    //工具
    LLVIewAnimation *LLanimation;
    LLMusicYeah *llmusic;
    LLAddStepsByEMMotion *addStepsByEMMotion;
    CADisplayLink *changeWaitingBallState;
}



@end


@implementation LLHomePageViewController

#pragma mark - view的生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self Tools];

    if (!hasDraw) {
        self.glView = [[OpenGLView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.glView];
        [self.glView setOrientation:[UIApplication sharedApplication].statusBarOrientation];
        [self drawview];
        [self drawChooseView];
        [self ShowHiddenView];
 
    }

    [self.glView setUserInteractionEnabled:YES];
    // 第一次打开执行别样操作
    [self TheFirstTimeOpen];
    


//    [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(Location) userInfo:nil repeats:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)TheFirstTimeOpen{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isFirst"] isEqualToString:@"YES"]) {
        //模拟引导时点击读取步数 获取定位
        [self performSelector:@selector(ReadFirstSteps) withObject:nil afterDelay:15];
        [self performSelector:@selector(firstLocation) withObject:nil afterDelay:5];
    }else{
        //不是第一次后台线程也5s更新一次数据
        //  后台执行：
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [addStepsByEMMotion PedometerGetSteps];
        });
        


    }
}
-(void)hasGetHealth{
    //如果步数获取到
    if ([HKHealthStore isHealthDataAvailable]) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            LLGetStep *llfirstgetsteps = [[LLGetStep alloc]init];
            [llfirstgetsteps FirstCreatHealth];
        });
        [self performSelector:@selector(firstUpdateEnergy) withObject:nil afterDelay:3];
        [healthTimer invalidate];
    }
}
//第一次更新Energy
-(void)firstUpdateEnergy{
    LLAddStepsByEMMotion *ttee = [[LLAddStepsByEMMotion alloc]init];
    [ttee PedometerGetSteps];
    pageInformationView.LLMainRoleEnergyValue = [[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"];
    [pageInformationView changeEnergyLabel];
}


//后期改成引导页面时监控 定位 （制定获取权限顺序）
-(void)firstLocation{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self configLocationManager];
    });
}
//点击操作请求权限调用一次 第一次监听到可以读取后 在调用一次（搞一个通知中心去观察是否可以读取 只在第一次打开的时候开启这个通知中心 ）
-(void)ReadFirstSteps{
    //监听 是否获取步数权限 是否获取定位权限
    healthTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(hasGetHealth) userInfo:nil repeats:YES];
    //没有获得权限 请求获取一下
        LLGetStep *llfirstgetsteps = [[LLGetStep alloc]init];
        [llfirstgetsteps FirstCreatHealth];
        NSLog(@"请求获取步数权限");
    NSDate *today = [NSDate date];
    LLPunchSetArray *setArray = [[LLPunchSetArray alloc]init];
    [setArray setStepsArrayWithDaysCount:60 Date:today];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //如果是第一次先不定位
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"isFirst"] isEqualToString:@"NO"]) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self configLocationManager];
        });
    }
    if (!hasDraw) {
        [self.glView start];
        hasDraw = YES;
//          后台执行：
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_async(queue, ^{
//            NSLog(@"时时刷新");
////            changeWaitingBallState = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeUpdatestate)];
////            [changeWaitingBallState addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//
//        
//        });
        
//        NSTimeInterval period = 1.0; //设置时间间隔
//        
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        
//        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//        
//        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
//        
//        dispatch_source_set_event_handler(_timer, ^{
//            
//            //在这里执行事件
//            
//        });
//        
//        dispatch_resume(_timer);
        
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeUpdatestate) userInfo:@"abc" repeats:YES];
//        });
    }
    
//    NSLog(@"---------------------------");
//    NSLog(@"render初始化一次");
//    NSLog(@"打开页面时含有的能量%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"]);
//    NSLog(@"首页将要开始");
//        [self initArraywithName:@"filter_raining" andImageCount:10 ];

    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.glView stop];
    NSLog(@"首页将要结束");
    //释放UpdateStepTimer
//    [UpdateStepTimer invalidate];
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
    
    //滤镜
    scene = [[FilterDefaultRain alloc]initWithSize:CGSizeMake(414, 736)];
    scene.Filter_rainNumber = 2000;
    skView = [[SKView alloc]initWithFrame:CGRectMake(0, 0, 414, 736)];
    
    skViewBgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 414, 736)];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"filter" ofType:@"png"];
//    skViewBgImg.image = [UIImage imageWithContentsOfFile:path];
    skViewBgImg.image = [UIImage imageNamed:@"FilterLighting_bg_img"];
    skViewBgImg.alpha = 0.8;
    [self.glView addSubview:skViewBgImg];
    
    [skView presentScene:scene];
    skView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:skView];
    
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
    
    
    showthehintBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.03,
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

    [self.glView addSubview:displayView];
    
    TapdisplayView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeNearLocation:)];
    [displayView addGestureRecognizer:TapdisplayView];
    
    pageInformationView = [[LLHomePageInformationView alloc]init];
    pageInformationView.LLMainRoleEnergyValue = [[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"];
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
                                                                 [UIScreen mainScreen].bounds.size.width*0.169)];
    waitingBall.contentMode = UIViewContentModeScaleAspectFit;
    [waitingBall setUserInteractionEnabled:YES];
    [waitingBall LLBallAlwaysDraw];
    [self.glView addSubview:waitingBall];
    
    LLCountTimerLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.821,
                                                                 [UIScreen mainScreen].bounds.size.width*0.603,
                                                                 [UIScreen mainScreen].bounds.size.width*0.2415,
                                                                 [UIScreen mainScreen].bounds.size.width*0.072)];
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

    

}


-(void)LocalModelWaitingBallMove{
    llMatureModel.LLLocalWaitingBall.hidden = NO;
    [LLanimation LightBallMove:llMatureModel.LLLocalWaitingBall];
//    NSLog(@"waitingball动起来");
}
-(void)LocalModelLightValueMove{
    llMatureModel.LLLocalLightValue.hidden = NO;
    [LLanimation LightValueMove:llMatureModel.LLLocalLightValue];
}

//点击一次MatureModel
-(void)tapMatureModel{

}

//______________________________________________________________________________







-(void)ShowHiddenView{
    
    LLDissmissView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//    LLDissmissView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    LLDissmissView.backgroundColor = [UIColor clearColor];
    LLDissmissView.hidden = YES;
//    [self.glView addSubview:LLDissmissView];
    
    llMatureModel = [[LLModelView alloc]init];
    llsuiPianView = [[LLSuiPianVIew alloc]init];
    
    
    UITapGestureRecognizer *tapMatureViewToHome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissMatureView)];
    [LLDissmissView addGestureRecognizer:tapMatureViewToHome];
    
    NSNotificationCenter * center1 = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center1 addObserver:self selector:@selector(LocalModelAppearFinish:) name:@"LocalModelAppearFinish" object:nil];
    
    NSNotificationCenter * center2 = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center2 addObserver:self selector:@selector(LocalSuiPianAppearFinish:) name:@"LocalSuiPianAppearFinish" object:nil];
    
//    LLMatureBackgroudView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 0, 0)];
//    [LLMatureBackgroudView.layer setCornerRadius:10];
//    LLMatureBackgroudView.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:56.0/255.0 blue:87.0/255.0 alpha:1];
//    [self.glView addSubview:LLMatureBackgroudView];
    
//    llmature = [[LLMatureView alloc]init];
    HasShowtheMatureView = NO;
//    [llmature drawRect:CGRectMake(0,0, 0, 0)];
//    [LLMatureBackgroudView addSubview:llmature];
    

    
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
    //点击第一跳到第二 第二跳到第一
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
    }else if([touch.view isKindOfClass:[LLChooseView class]]){;
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
    MainRoleFootStep = [[NSUserDefaults standardUserDefaults] objectForKey:@"Energy"];
    
    NSLog(@"LoadStepCount%@",MainRoleFootStep);
    
}
#pragma mark - 光体不成熟页面动画
-(void)showWaitingBallBoostView{
    llBoostView.hidden = NO;
    [self LoadStepCount];
    //当前步行能量
    llBoostView.LLNowEnergy = [MainRoleFootStep intValue];
    NSLog(@"当前能量%d",llBoostView.LLNowEnergy);
    //加速完成所需能量 ＝ 秒数
    LLGetNowTime *llgetnowtime = [[LLGetNowTime alloc]init];
    long int Intervaltime = [llgetnowtime LLGetIntervalTime];
    int NeedMinute = (int)(3600-Intervaltime)/60;
    if (NeedMinute==60) {
        NeedMinute =100;
    }
    int NeedSecond = (int)(3600-Intervaltime-NeedMinute*60);
    llBoostView.LLMatureNeedEnergy = NeedMinute*100+NeedSecond;
    NSLog(@"加速所需分钟%d,加速所需秒数%d,加速所需能量%ld",NeedMinute,NeedSecond,llBoostView.LLMatureNeedEnergy);
    //llBoostView.LLMatureNeedEnergy  = 3600 - Intervaltime;
    
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
//    NSLog(@"EnergyEnergyEnergyEnergyEnergyEnergyEnergyEnergyEnergyEnergy%@",energyString);
    int energy = [energyString intValue];
    
    int hadMinute = energy/100;
    int hadSecond = energy - hadMinute*100;
    
    int energytransTotime = hadMinute*60 + hadSecond;
    NSLog(@"能量转换成的时间%d",energytransTotime);
    NSLog(@"成熟所需时间%ld",MatureNeedTime);
    if(energytransTotime <= 0){
            [self dismissBoostView];
    }else if( energy <= llBoostView.LLMatureNeedEnergy && energytransTotime>0){
            [self dismissBoostView];
        
        
            NSString *CurrentIntervalTimeString = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLLastRecordTime"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *CurrentIntervalTime = [formatter dateFromString:CurrentIntervalTimeString];
        
        //    // 更具当前date和时间间隔生成的得到一个新的date对象
            NSDate *newDate = [CurrentIntervalTime dateByAddingTimeInterval:-energytransTotime];
            NSString *newDateString = [formatter stringFromDate:newDate];
            [[NSUserDefaults standardUserDefaults]setValue:newDateString forKey:@"LLLastRecordTime"];
        [[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"Energy"];
        //更新UI
        //成熟时间减去步行能量
        MatureNeedTime = MatureNeedTime - energytransTotime;
        [LLCountTimerLabel pop_removeAllAnimations];
//            LLCountTimerLabel.text = nil;
        //    NSLog(@"%ld",Remaintime);
        [self CountTimerAnimation:MatureNeedTime];
        
    }else{
        [self dismissBoostView];
        NSLog(@"够");
        [LLCountTimerLabel pop_removeAllAnimations];
        LLCountTimerLabel.text = @"已成熟";
        //数据层
//        NSString *CurrentIntervalTimeString = [[NSUserDefaults standardUserDefaults]valueForKey:@"LLLastRecordTime"];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSDate *CurrentIntervalTime = [formatter dateFromString:CurrentIntervalTimeString];
//        // 更具当前date和时间间隔生成的得到一个新的date对象
//        NSDate *newDate = [CurrentIntervalTime dateByAddingTimeInterval:-MatureNeedTime];
//        NSString *newDateString = [formatter stringFromDate:newDate];
//        [[NSUserDefaults standardUserDefaults]setValue:newDateString forKey:@"LLLastRecordTime"];
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

    LLDissmissView.hidden = NO;
    sleep(0.4);
    NSLog(@"点击了");
    
    [llMatureModel drawRect:CGRectMake(0, 0, self.glView.bounds.size.width, self.glView.bounds.size.height)];
    llMatureModel.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:llMatureModel];
//    TapMatureModelCount = 0;
    tapMatureModel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMatureModel)];
    [llMatureModel addGestureRecognizer:tapMatureModel];
    LLDissmissView.hidden = NO;
    [self.glView addSubview:LLDissmissView];
    
    
    [llsuiPianView drawRect:CGRectMake(0, 0, self.glView.bounds.size.width, self.glView.bounds.size.height)];
    llsuiPianView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:llsuiPianView];
    llsuiPianView.hidden = YES;
    //本地光体生成后跳出的光体
    [LLanimation LocalModelAppearAnimationWithImgView:llMatureModel.LLLocalModel];
    [LLanimation LocalModelLevelAppearAnimationWithImge:llMatureModel.LLLocalModelLevel];
    [LLanimation LocalModelNameAppearAnimationWithLabel:llMatureModel.LLLocalName];
    [self performSelector:@selector(LocalModelWaitingBallMove) withObject:nil afterDelay:1.0];
    [self performSelector:@selector(LocalModelLightValueMove) withObject:nil afterDelay:1.5];
}


-(void)dismissMatureView{
    NSLog(@"点击model");

    
    
    
    if (TapMatureModelCount==0) {
//        TapMatureModelCount++;
        [LLanimation LocalModelDisAppearAnimationWithImgView:llMatureModel.LLLocalModel];
        [LLanimation LocalModelLevelDisAppearAnimationWithImge:llMatureModel.LLLocalModelLevel];
        [LLanimation LocalModelNameDisAppearAnimationWithLabel:llMatureModel.LLLocalName];
//
        [self performSelector:@selector(showSuiPianView) withObject:nil afterDelay:1.5];
//        sleep(1.5);
        [LLanimation LocalSuiPianAppearWithImg:llsuiPianView.LLSuiPianImg];
        [LLanimation LocalSuiPianCountWithLabel:llsuiPianView.LLSuiPianTotalLabel];
        [LLanimation LocalSuiPianNameAppearWithLabel:llsuiPianView.LLSuipianName];
        
    }else{
        [LLanimation LocalSuiPianDisAppearWithImg:llsuiPianView.LLSuiPianImg];
        [LLanimation LocalSuiPianCountDisWithLabel:llsuiPianView.LLSuiPianTotalLabel];
        [LLanimation LocalSuiPianNameDisAppearWithLabel:llsuiPianView.LLSuipianName];
        //碎片页面动画结束后消失
        LLDissmissView.hidden = YES;
    }

}

-(void)LocalModelAppearFinish:(id)sender{
    NSLog(@"%@",sender);
    NSLog(@"接收到光体动画结束");
    TapMatureModelCount = 0;
}


-(void)LocalSuiPianAppearFinish:(id)sender{
    NSLog(@"%@",sender);
    NSLog(@"接收到碎片动画结束");
    TapMatureModelCount = 1;
}

-(void)showSuiPianView{
//    TapMatureModelCount++;
    llsuiPianView.hidden = NO;
    [LLanimation LocalSuiPianAppearWithImg:llsuiPianView.LLSuiPianImg];
    [LLanimation LocalSuiPianCountWithLabel:llsuiPianView.LLSuiPianTotalLabel];
    [LLanimation LocalSuiPianNameAppearWithLabel:llsuiPianView.LLSuipianName];
    
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
    [llmusic playSound:@"ClickWaitingBall" type:@"wav"];
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
    [llmusic playSound:@"ClickWaitingBall" type:@"wav"];
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
    _LLsilderchange.maximumValue = 100;
    _LLsilderchange.minimumValue = 0;
    _LLsilderchange.value = 0;
    [_LLsilderchange addTarget:self action:@selector(changeDefaultScene:) forControlEvents:UIControlEventValueChanged];
    [chooseview addSubview:_LLsilderchange];
    [chooseview.LLChoseViewBtn addTarget:self action:@selector(changefilter:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.glView addSubview:chooseview];
}

-(void)changefilter:(UIButton *)button{
    NSLog(@"点击的滤镜的名%ld",(long)chooseview.LLChoseViewBtn.tag);
}

-(void)changeDefaultScene:(UISlider *)slider{
    NSLog(@"%f",slider.value);
    skViewBgImg.alpha = 0.8 - slider.value/100*0.7;
    if (slider.value<=30&&slider.value>=0) {
        [sunshine removeFromParent];
        [rainscene removeFromParent];
        sunshine = nil;
        rainscene = nil;
        if (scene==nil) {
            scene = [[FilterDefaultRain alloc]initWithSize:skView.bounds.size];
            //            SKTransition *changetomovecloud = [SKTransition doorsOpenVerticalWithDuration:0.5];
            //            [skView presentScene:scene transition:changetomovecloud];
            [skView presentScene:scene];
        }
        NSLog(@"在大雨区域");
        scene.Filter_rainNumber = 300-slider.value*10;
        [scene update:0.01];
        
        
    }else if (slider.value>30&&slider.value<=75){
        [scene removeFromParent];
        [sunshine removeFromParent];
        scene    = nil;
        sunshine = nil;
        NSLog(@"在多云区域");
        if (rainscene==nil) {
            rainscene = [[FilterDefaultCloud alloc]initWithSize:skView.bounds.size];
            //            SKTransition *changetomovecloud = [SKTransition doorsOpenVerticalWithDuration:0.5];
            //            [skView presentScene:rainscene transition:changetomovecloud];
            [skView presentScene:rainscene];
        }
//        rainscene.waitTime = (slider.value-30)/30+1.5;
//        NSLog(@"%f",rainscene.waitTime);
//        [rainscene update:0.05];
    }else{
        [rainscene removeFromParent];
        [scene removeFromParent];
        rainscene = nil;
        scene = nil;
        NSLog(@"在太阳区域");
        if (sunshine==nil) {
            sunshine = [[FilterDefaultSunshine alloc]initWithSize:skView.bounds.size];
            //            SKTransition *changetomovecloud = [SKTransition doorsOpenVerticalWithDuration:0.5];
            //            [skView presentScene:sunshine transition:changetomovecloud];
            [skView presentScene:sunshine];
        }
    }
    
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}


//滤镜选择的动画
-(void)showFilterChooseView{
    [llmusic playSound:@"changeFIlter" type:@"wav"];
    if (showTheFilterChooseView) {
        [self closechooseView];
        NSLog(@"chooseview关闭了");
        showTheFilterChooseView = NO;
        [sunshine removeFromParent];
        [rainscene removeFromParent];
        [scene removeFromParent];
        sunshine = nil;
        rainscene = nil;
        scene   = nil;
        scene = [[FilterDefaultRain alloc]initWithSize:skView.bounds.size];
            //            SKTransition *changetomovecloud = [SKTransition doorsOpenVerticalWithDuration:0.5];
            //            [skView presentScene:scene transition:changetomovecloud];
            [skView presentScene:scene];
        NSLog(@"回到大雨区域");
        scene.Filter_rainNumber = 300;
        [scene update:0.01];
        Screenshotbtn.hidden = NO;
        showthehintBtn.hidden = NO;
        LLHomeMenubtn.hidden = NO;
        [self.glView removeGestureRecognizer:closeChooseViewTap];
    }else{
        [self showchooseView];
        showTheFilterChooseView = YES;
        NSLog(@"chooseview打开了");
        Screenshotbtn.hidden = YES;
        showthehintBtn.hidden = YES;
        LLHomeMenubtn.hidden = YES;
        
        closeChooseViewTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showFilterChooseView)];
        closeChooseViewTap.delegate = self;
        [self.glView addGestureRecognizer:closeChooseViewTap];
        
    }
}
//-(void)showtestfilter{
//    [filterAlwaysView LLfilerAlwaysDraw];
//}
-(void)showchooseView{
    
    [self drawChooseView];
    [chooseview setNeedsDisplay];
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
    chooseview.hidden = YES;
    
}




#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{

    return [HintViewPresent new];
}


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
    displayView.LLHomeDisplayLabel.text = @"附近无基站";
    //[self Location];

    
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
    [llmusic playSound:@"ClickMenu" type:@"wav"];
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    MenuItem *menuItem = [MenuItem itemWithTitle:@"能量记录" iconName:@"nengliangjilu"];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"滤镜合成" iconName:@"nengliangjilu"];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"排名" iconName:@"nengliangjilu"];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"光体箱" iconName:@"nengliangjilu"];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"设置" iconName:@"nengliangjilu"];
    [items addObject:menuItem];
    
   // menuItem = [MenuItem itemWithTitle:@"个人中心" iconName:@"nengliangjilu"];
    //[items addObject:menuItem];
//    menuItem = [MenuItem itemWithTitle:@"活动版块" iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.687 green:0.164 blue:0.246 alpha:0.800]];
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
//        NSLog(@"%@",selectedItem.title);
//        if ([selectedItem.title isEqual:@"个人中心"]) {
//            [weakSelf pushpunchView];
//        }else
        if([selectedItem.title isEqualToString:@"能量记录"]){
            //[weakSelf pushEnergyRecordView];
            [weakSelf performSegueWithIdentifier:@"LLPunch" sender:nil];
        }else if ([selectedItem.title isEqualToString:@"滤镜合成"]){
            //[weakSelf pushMixFilterView];
            [weakSelf performSegueWithIdentifier:@"LLMixFilter" sender:nil];
        }else if ([selectedItem.title isEqualToString:@"排名"]){
           //[weakSelf pushRankView];
            [weakSelf performSegueWithIdentifier:@"LLRank" sender:nil];
        }else if ([selectedItem.title isEqualToString:@"光体箱"]){
            //[weakSelf pushRankView];
            [weakSelf performSegueWithIdentifier:@"LLBox" sender:nil];
        }else if ([selectedItem.title isEqualToString:@"设置"]){
            //[weakSelf pushRankView];
            [weakSelf performSegueWithIdentifier:@"LLSet" sender:nil];
        }

    };
    
    [popMenu showMenuAtView:self.view];
    
    //    [_popMenu showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}

-(void)pushpunchView{
    [self performSegueWithIdentifier:@"LLSelfInformation" sender:nil];


}
-(void)pushEnergyRecordView{
//    LLPunchViewController *testVC = [LLPunchViewController new];
//    testVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self.navigationController presentViewController:testVC
//                                            animated:YES
//                                          completion:NULL];
    [self performSegueWithIdentifier:@"LLPunch" sender:nil];
    //[testVC dealloc];
}
-(void)pushMixFilterView{
//    LLMixFilterViewController *testVC = [LLMixFilterViewController new];
//    testVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self.navigationController presentViewController:testVC
//                                            animated:YES
//                                          completion:NULL];
    [self performSegueWithIdentifier:@"LLMixFilter" sender:nil];
    
}
-(void)pushRankView{
//    LLRankViewController *testVC = [LLRankViewController new];
//    testVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self.navigationController presentViewController:testVC
//                                            animated:YES
//                                          completion:NULL];
    [self performSegueWithIdentifier:@"LLRank" sender:nil];
}
#pragma mark - 工具类
//每5s更新一次Energy
//-(void)UpdateAddStep{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        LLGetStep *llfirstgetsteps = [[LLGetStep alloc]init];
//        [llfirstgetsteps CreatAddHealth];
//    });
//    pageInformationView.LLMainRoleEnergyValue = [[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"];
//    [pageInformationView initEnergyValueImage];
//}
-(void)Tools{
    //动效
    LLanimation = [[LLVIewAnimation alloc]init];
    //音效
    llmusic = [[LLMusicYeah alloc]init];
    //实时步数
    addStepsByEMMotion = [[LLAddStepsByEMMotion alloc]init];
    
}
#pragma mark - FTP实时更新UI
-(void)changeUpdatestate{
    NSLog(@"正在定位中");
    //更新等待球的状态
    if ([LLCountTimerLabel.text isEqualToString:@"已成熟"]) {
        HasWaitingBallMatured = YES;
        //去掉长按短按手势
        [waitingBall removeGestureRecognizer:TapImmatureWaitingBall];
        TapMaturedWaitingBall = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapMaturedWaitingBall:)];
        [waitingBall addGestureRecognizer:TapMaturedWaitingBall];
    }else{
        HasWaitingBallMatured = NO;
        [waitingBall removeGestureRecognizer:TapMaturedWaitingBall];
        TapImmatureWaitingBall = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShortTapImmatureWaitingBall:)];
        [waitingBall addGestureRecognizer:TapImmatureWaitingBall];
    }
    //更新定位状态
//    [self Location];
//    if (displayView.LLHomeDisplayLabel.text == nil||[[NSUserDefaults standardUserDefaults]valueForKey:@"LLNearestLocation"]==nil) {
//        displayView.LLHomeDisplayLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:17];
//        displayView.LLHomeDisplayLabel.text = @"正在定位中";
//        NSLog(@"正在定位中");
//    }
//    //更新能量的数字
//    pageInformationView.LLMainRoleEnergyValue = [[NSUserDefaults standardUserDefaults]valueForKey:@"Energy"];
//    [pageInformationView changeEnergyLabel];
    
}
@end
