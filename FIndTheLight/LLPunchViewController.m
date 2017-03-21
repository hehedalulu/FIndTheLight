//
//  LLPunchViewController.m
//  FIndTheLight
//
//  Created by Wll on 17/1/21.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLPunchViewController.h"
#import "LLPunchStepsCollectionViewCell.h"
//#import "XZMRefresh.h"
#import "LLPunchSetArray.h"
#import "LLEveryDaystep.h"
#import "LLPunchManger.h"

@interface LLPunchViewController (){
    UICollectionView *LLStepsView;
//    NSMutableArray *LLWeekArray;
//    NSMutableArray *LLDayArray;
//    NSMutableArray *LLStepsArray;
//    NSMutableArray *LLDateArray;
    NSMutableArray *LLDayModelArray;
    
    UILabel *step;
    CADisplayLink *changeStepsLabel;
    int count;
    
    BOOL isSelectedItem;
    NSIndexPath *SelectedIndex;
    
    UIView *backgroundView;
    UIView *bezierbackView;
}

@end

@implementation LLPunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dateformatter = [[NSDateFormatter alloc]init];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    [self initCalendarStepsArray];
    count = 0;
    isSelectedItem = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.view.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:27.0/255.0 blue:47.0/255.0 alpha:1];
    [self drawStepView];
    
    UILabel *pagename = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12,
                                                                 [UIScreen mainScreen].bounds.size.width*0.05,
                                                                 [UIScreen mainScreen].bounds.size.width*0.36,
                                                                 [UIScreen mainScreen].bounds.size.width*0.15)];
    pagename.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    pagename.text = @".能量记录";
    pagename.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    [self.view addSubview:pagename];
    
    UIButton *dismissBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.025,
                                                                     [UIScreen mainScreen].bounds.size.width*0.08,
                                                                     [UIScreen mainScreen].bounds.size.width*0.1,
                                                                     [UIScreen mainScreen].bounds.size.width*0.1)];
    [dismissBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
  //layout.itemSize = CGSizeMake(100, 100);
    // 设置最小行间距
    layout.minimumLineSpacing = 1;
    // 设置垂直间距
//    layout.minimumInteritemSpacing = 10;
    // 设置滚动方向（默认垂直滚动）
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
//    XZMLayout *layout = [[XZMLayout alloc] init];
//    layout.itemSize = CGSizeMake(100, 100);
    // 设置边缘的间距，默认是{0，0，0，0}
 //   layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    UIImageView *StepViewBG = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                           [UIScreen mainScreen].bounds.size.width*0.20,
                                                                           [UIScreen mainScreen].bounds.size.width,
                                                                           [UIScreen mainScreen].bounds.size.width*0.2316)];
    StepViewBG.image = [UIImage imageNamed:@"calendar-layer.png"];
    [self.view addSubview:StepViewBG];
    
    LLStepsView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,
                                                                    [UIScreen mainScreen].bounds.size.width*0.20,
                                                                    [UIScreen mainScreen].bounds.size.width,
                                                                    [UIScreen mainScreen].bounds.size.width*0.2316) collectionViewLayout:layout];
//    LLStepsView.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:114.0/255.0 blue:188.0/255.0 alpha:1];
    LLStepsView.backgroundColor = [UIColor clearColor];
    LLStepsView.delegate = self;
    LLStepsView.dataSource = self;
    LLStepsView.alwaysBounceHorizontal = YES;
    LLStepsView.showsHorizontalScrollIndicator = NO;
    
//    NSIndexPath *path = [NSIndexPath indexPathForItem:4 inSection:0];
//    [LLStepsView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    LLStepsView.contentOffset = CGPointMake(LLDayModelArray.count*[UIScreen mainScreen].bounds.size.width*0.19, 0);
//    NSLog(@"偏移量%f 数组%lu",LLStepsView.contentOffset.x,(unsigned long)LLDayModelArray.count);

    // 通过xib注册
    [LLStepsView registerClass:[LLPunchStepsCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview: LLStepsView];
    
//    [self RightPinchreload];

    
}



-(void)drawStepView{
    
    
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.02,
                                                             [UIScreen mainScreen].bounds.size.width*0.50,
                                                             [UIScreen mainScreen].bounds.size.width*0.96,
                                                             [UIScreen mainScreen].bounds.size.width)];
//    backgroundView.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:38.0/255.0 blue:59.0/255.0 alpha:1];
    [self.view addSubview:backgroundView];
    
    UIImageView *backImage= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backgroundView.bounds.size.width, backgroundView.bounds.size.height)];
    backImage.image = [UIImage imageNamed:@"progress-layer.png"];
    [backgroundView addSubview:backImage];
    todaylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*0.04,
                                                                   backgroundView.bounds.size.width,
                                                                   [UIScreen mainScreen].bounds.size.width*0.0726)];
    todaylabel.textAlignment = NSTextAlignmentCenter;
    todaylabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy / MM / dd"];
    NSString *DateString = [dateFormatter stringFromDate:today];
    todaylabel.text = DateString;
    todaylabel.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    [backgroundView addSubview:todaylabel];
    
    UIImageView *outsidecircle = [[UIImageView alloc]initWithFrame:CGRectMake(backgroundView.bounds.size.width/2-[UIScreen mainScreen].bounds.size.width*0.3514/2,
                                                                              backgroundView.bounds.size.height/5.5,
                                                                              [UIScreen mainScreen].bounds.size.width*0.3514,
                                                                              [UIScreen mainScreen].bounds.size.width*0.3514)];
    outsidecircle.image = [UIImage imageNamed:@"step-number-layer.png"];
    [outsidecircle.layer setMasksToBounds:YES];
    [backgroundView addSubview:outsidecircle];
    
    UIImageView *insidecircle = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width*0.3514-[UIScreen mainScreen].bounds.size.width*0.245)/2,
                                                                             ([UIScreen mainScreen].bounds.size.width*0.3514-[UIScreen mainScreen].bounds.size.width*0.245)/2,
                                                                             [UIScreen mainScreen].bounds.size.width*0.245, [UIScreen mainScreen].bounds.size.width*0.245)];
    insidecircle.backgroundColor = [UIColor clearColor];
    [insidecircle.layer setMasksToBounds:YES];
    [outsidecircle addSubview: insidecircle];
    
    step = [[UILabel alloc]initWithFrame:CGRectMake(0, insidecircle.bounds.size.height/2-20, insidecircle.bounds.size.width, 40)];
    step.textAlignment = NSTextAlignmentCenter;
    ThedayStep = [[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"];
    step.text = ThedayStep;
    if (ThedayStep.intValue>=10000) {
        step.textColor = [UIColor colorWithRed:251.0/255.0 green:175.0/255.0 blue:173.0/255.0 alpha:1];
    }else{
        step.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    }
    step.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    
    [insidecircle addSubview:step];
    changeStepsLabel = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateStepsLabel)];
    [changeStepsLabel addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    UILabel *sufixlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, insidecircle.bounds.size.height/2+[UIScreen mainScreen].bounds.size.width*0.041,
                                                                   insidecircle.bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.0483)];
    sufixlabel.textAlignment = NSTextAlignmentCenter;
    sufixlabel.text = @"步";
    sufixlabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    sufixlabel.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    [insidecircle addSubview:sufixlabel];
    
    
    UILabel *category1 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.65,
                                                                  [UIScreen mainScreen].bounds.size.width*0.20,
                                                                  [UIScreen mainScreen].bounds.size.width*0.0483)];
    category1.textAlignment = NSTextAlignmentRight;
    category1.text = @"图书馆";
    category1.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    category1.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    [backgroundView addSubview:category1];
    
    UILabel *category2 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.72,
                                                                  [UIScreen mainScreen].bounds.size.width*0.20,
                                                                  [UIScreen mainScreen].bounds.size.width*0.0483)];
    category2.textAlignment = NSTextAlignmentRight;
    category2.text = @"食堂";
    category2.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    category2.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    [backgroundView addSubview:category2];
    
    UILabel *category3 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.79,
                                                                  [UIScreen mainScreen].bounds.size.width*0.20,
                                                                  [UIScreen mainScreen].bounds.size.width*0.0483)];
    category3.textAlignment = NSTextAlignmentRight;
    category3.text = @"教学楼";
    category3.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    category3.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    [backgroundView addSubview:category3];
  
    for (int j=0; j<3; j++) {
        int HeightY = j*30;
        for (int i=0; i<10; i++) {
            int widthX = i*18;
            UIImageView *unpunchcard = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.32+widthX,
                                                                                    [UIScreen mainScreen].bounds.size.width*0.65+HeightY, 30, 24)];
            unpunchcard.image = [UIImage imageNamed:@"Punchnotfound.png"];
            [backgroundView addSubview:unpunchcard];
        }
    }
    
    [self DrawPunchCardView:today];
    [self DrawCircleWithEnergy:ThedayStep];
    

}
#pragma mark - 画打卡动画

-(void)DrawPunchCardView:(NSDate *)date{
    
    punchView = [[UIView alloc]init];
    punchView.backgroundColor = [UIColor clearColor];
    punchView.frame = CGRectMake(0, 0, backgroundView.bounds.size.width, backgroundView.bounds.size.height);
    [backgroundView addSubview:punchView];
    
    LLPunchManger *punchManger = [[LLPunchManger alloc]init];
//    [punchManger CheckDatePunch:date];
    [punchManger TestDatePunch:date];
    //图书馆上午
    for (int i=0; i<punchManger.LLPunchLibraryAMCount; i++) {
        int widthX = i*18;
        UIImageView *punchcard = [[UIImageView alloc]initWithFrame:
                                    CGRectMake([UIScreen mainScreen].bounds.size.width*0.32+widthX,
                                               [UIScreen mainScreen].bounds.size.width*0.65, 30, 24)];
        punchcard.image = [UIImage imageNamed:@"day.png"];
        punchcard.alpha = 0;
        [punchView addSubview:punchcard];
        
        [UIView animateWithDuration:0.3 delay:0.2*i options:UIViewAnimationOptionCurveLinear animations:^{
            punchcard.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    //图书馆下午
    for (int i=0; i<punchManger.LLPunchLibraryPMCount; i++) {
        //出去上之前数据的x轴
        int WidthInitX = punchManger.LLPunchLibraryAMCount*18;
        int widthX = i*18;
        UIImageView *punchcard = [[UIImageView alloc]initWithFrame:
                                    CGRectMake([UIScreen mainScreen].bounds.size.width*0.32+widthX+WidthInitX,
                                               [UIScreen mainScreen].bounds.size.width*0.65, 30, 24)];
        punchcard.image = [UIImage imageNamed:@"night.png"];
        punchcard.alpha = 0;
        [punchView addSubview:punchcard];
        
        
        [UIView animateWithDuration:0.3 delay:0.2*(i+punchManger.LLPunchLibraryAMCount) options:UIViewAnimationOptionCurveLinear animations:^{
            punchcard.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    //食堂上午
    for (int i=0; i<punchManger.LLPunchRestaurantAMCount; i++) {
        int widthX = i*18;
        UIImageView *punchcard = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.32+widthX,
                                                                                [UIScreen mainScreen].bounds.size.width*0.72, 30, 24)];
        punchcard.image = [UIImage imageNamed:@"day.png"];
        punchcard.alpha = 0;
        [punchView addSubview:punchcard];
        
        [UIView animateWithDuration:0.3 delay:0.2*i options:UIViewAnimationOptionCurveLinear animations:^{
            punchcard.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    //食堂下午
    for (int i=0; i<punchManger.LLPunchRestaurantPMCount; i++) {
        int WidthInitX = punchManger.LLPunchRestaurantAMCount*18;
        int widthX = i*18;
        UIImageView *punchcard = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.32+widthX+WidthInitX,
                                                                              [UIScreen mainScreen].bounds.size.width*0.72, 30, 24)];
        punchcard.image = [UIImage imageNamed:@"night.png"];
        punchcard.alpha = 0;
        [punchView addSubview:punchcard];
        
        [UIView animateWithDuration:0.3 delay:0.2*(i+punchManger.LLPunchRestaurantAMCount) options:UIViewAnimationOptionCurveLinear animations:^{
            punchcard.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    //教学楼上午
    for (int i=0; i<punchManger.LLPunchTeachAMCount; i++) {
        int widthX = i*18;
        UIImageView *punchcard = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.32+widthX,
                                                                                [UIScreen mainScreen].bounds.size.width*0.79, 30, 24)];
        punchcard.image = [UIImage imageNamed:@"day.png"];
        punchcard.alpha = 0;
        [punchView addSubview:punchcard];
        [UIView animateWithDuration:0.3 delay:0.2*i options:UIViewAnimationOptionCurveLinear animations:^{
            punchcard.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
    //教学楼下午
    for (int i=0; i<punchManger.LLPunchTeachAMCount; i++) {
        int WidthInitX = punchManger.LLPunchTeachAMCount*18;
        int widthX = i*18;
        UIImageView *punchcard = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.32+widthX+WidthInitX,
                                                                              [UIScreen mainScreen].bounds.size.width*0.79, 30, 24)];
        punchcard.image = [UIImage imageNamed:@"night.png"];
        punchcard.alpha = 0;
        [punchView addSubview:punchcard];
        [UIView animateWithDuration:0.3 delay:0.2*(i+punchManger.LLPunchTeachAMCount) options:UIViewAnimationOptionCurveLinear animations:^{
            punchcard.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }

}
#pragma  mark - 画圈圈动画

-(void)DrawCircleWithEnergy:(NSString *)energy{
    //画圈圈
    double circlePi = energy.intValue*M_PI/5000 - M_PI*0.5;
    bezierbackView = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.245,
                                                             [UIScreen mainScreen].bounds.size.width*0.124,
                                                             [UIScreen mainScreen].bounds.size.width*0.469,
                                                             [UIScreen mainScreen].bounds.size.width*0.469)];
    bezierbackView.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:bezierbackView];
    
    //    [[UIColor redColor] setStroke]; // stroke 画线的意思，也就是画笔的笔头颜色
    
    //2.使用UIBezierPath 的类方法绘制圆弧，中心我们选择当前窗口的中心
    //    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(bezierbackView.bounds.size.width/2, bezierbackView.bounds.size.height/2) radius:70 startAngle:M_PI*(-90)/180.0f endAngle:M_PI*(200)/180.0f clockwise:YES];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(bezierbackView.bounds.size.width/2, bezierbackView.bounds.size.height/2)
                                                        radius:[UIScreen mainScreen].bounds.size.width*0.21
                                                    startAngle:-M_PI_2 endAngle:circlePi clockwise:YES];
    
    CAShapeLayer * _progressLayer = [CAShapeLayer layer];
    //指定frame 大小
    _progressLayer.frame = bezierbackView.bounds;
    //fillColor  图层填充颜色
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    //线条颜色
    _progressLayer.strokeColor=[UIColor redColor].CGColor;
    
    _progressLayer.lineCap = kCALineCapRound;
    // 指定线条宽度
    _progressLayer.lineWidth = [UIScreen mainScreen].bounds.size.width*0.042;
    //到这里我们的弧线已经制作完成
    [bezierbackView.layer addSublayer:_progressLayer];
    
    //遮罩涂层
    //CALayer * grain = [CALayer layer];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bezierbackView.bounds;
    //    [bezierbackView.layer addSublayer:gradientLayer];
    
    //set gradient colors
    if (ThedayStep.intValue>=10000) {
        gradientLayer.colors = nil;
        NSLog(@"gradientLayer.colors更改1");
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:123.0/255.0 green:67.0/255.0 blue:239.0/255.0 alpha:1].CGColor,
                                 (__bridge id)[UIColor colorWithRed:234.0/255.0 green:105.0/255.0 blue:187.0/255.0 alpha:1].CGColor,
                                 (__bridge id)[UIColor colorWithRed:255.0/255.0 green:165.0/255.0 blue:165.0/255.0 alpha:1].CGColor];
    }else{
        NSLog(@"gradientLayer.colors更改2");
        gradientLayer.colors = nil;
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:60.0/255.0 green:88.0/255.0 blue:255.0/255.0 alpha:1].CGColor,
                                 (__bridge id)[UIColor colorWithRed:121.0/255.0 green:121.0/255.0 blue:255.0/255.0 alpha:1].CGColor,
                                 (__bridge id)[UIColor colorWithRed:42.0/255.0 green:195.0/255.0 blue:218.0/255.0 alpha:1].CGColor];
    }


    
    //set locations
    gradientLayer.locations = @[@0.1, @0.5, @0.8];
    
    //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    [gradientLayer setMask:_progressLayer];
    [bezierbackView.layer addSublayer:gradientLayer];
    
    //增加动画
    
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    pathAnimation.duration = 2;
    
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
    
    pathAnimation.toValue=[NSNumber numberWithFloat:1.0f];
    
    pathAnimation.autoreverses=NO;
    pathAnimation.repeatCount = 0;
    _progressLayer.path=path.CGPath;
    
    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}


-(void)updateStepsLabel{
    NSString *oldtodayenergy = [[NSUserDefaults standardUserDefaults]valueForKey:@"NowDayEnergy"];
    step.text = oldtodayenergy;
}

-(void)dismissView{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}


#pragma mark - <UICollectionViewDataSource> 日历数据源

//- (void)RightPinchreload
//{
////    [LLStepsView xzm_addNormalHeaderWithTarget:self action:@selector(reloadNewData:)];
//    [LLStepsView xzm_addGifHeaderWithTarget:self action:@selector(reloadNewData:)];
//    [LLStepsView xzm_addGifFooterWithTarget:self action:@selector(reloadOldData:)];
//    
//    LLStepsView.xzm_gifHeader.updatedTimeHidden = YES;
//    LLStepsView.xzm_gifHeader.stateHidden = YES;
//    [LLStepsView.xzm_header setTitle:@"" forState:XZMRefreshStateNormal];
//    [LLStepsView.xzm_header setTitle:@"" forState:XZMRefreshStatePulling];
//    [LLStepsView.xzm_header setTitle:@"" forState:XZMRefreshStateRefreshing];
//    
//    LLStepsView.xzm_gifFooter.stateHidden = YES;
//    [LLStepsView.xzm_gifFooter setTitle:@"" forState:XZMRefreshStateNormal];
//    [LLStepsView.xzm_gifFooter setTitle:@"" forState:XZMRefreshStatePulling];
//    [LLStepsView.xzm_gifFooter setTitle:@"" forState:XZMRefreshStateRefreshing];
//    
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=60; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [idleImages addObject:image];
//    }
//    [LLStepsView.xzm_gifHeader setImages:idleImages forState:XZMRefreshStateNormal];
//    [LLStepsView.xzm_gifFooter setImages:idleImages forState:XZMRefreshStateNormal];
//    
//    // 设置正在刷新状态的动画图片
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
//    [LLStepsView.xzm_gifHeader setImages:refreshingImages forState:XZMRefreshStateRefreshing];
//    [LLStepsView.xzm_gifFooter setImages:refreshingImages forState:XZMRefreshStateRefreshing];
//    
//    // 马上进入刷新状态
////    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [LLStepsView.xzm_gifHeader beginRefreshing];
////        NSLog(@"开始刷新");
////    });
//}

-(void)initCalendarStepsArray{
    //如果是当天第一次打开能量记录页面 就把步数更新到第一次使用应用的那一天
//    NSDate *nowday = [NSDate date];
    
//    LLPunchSetArray *setArray = [[LLPunchSetArray alloc]init];
//    LLWeekArray = [[NSMutableArray alloc]init];
//    LLWeekArray = [setArray setWeekArrayWithDate:nowday];
    
//    LLDayArray = [[NSMutableArray alloc]init];
//    LLDayArray = [setArray setDayArrayWithDate:nowday];
    
//    LLStepsArray = [[NSMutableArray alloc]init];
//    LLStepsArray = [setArray newStepsArrayWithDaysCount:19 Date:nowday];
    
//    LLDateArray = [[NSMutableArray alloc]init];
//    LLDateArray = [setArray setDateArrayWithDate:nowday];
    
    
//    NSLog(@"StepsArray%lu",(unsigned long)LLStepsArray.count);
//    NSLog(@"weekArray%lu",(unsigned long)LLWeekArray.count);
    
    LLDayModelArray = [[NSMutableArray alloc]init];
    
    
    RLMRealm * realm = [RLMRealm defaultRealm];
    RLMResults * tempArray = [LLEveryDaystep allObjectsInRealm:[RLMRealm defaultRealm]];
    
    NSMutableArray *PicNameArray = [[NSMutableArray alloc]init];
    
    //加载数值
    [realm transactionWithBlock:^{
        for (LLEveryDaystep *model  in tempArray) {
//            if ([model. isEqualToString:@"东九"]) {
//                [PicNameArray addObject:model.ARPicName];
//            }
            [LLDayModelArray addObject:model];

        }
        [realm commitWriteTransaction]; //注意  这里不能写在for循环里面 写入数据库， 要在循环改变完只好
        
    }];
    
    for (NSString*string in PicNameArray) {
        NSLog(@"模型中的图片名称%@",string);
    }
}


- (BOOL)isSameDayForDate:(NSDate *)date1 andDate:(NSDate*)date2{
    
    if (nil == date1 || nil == date2){
        return NO;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *DateString1 = [dateFormatter stringFromDate:date1];
    NSString *DateString2 = [dateFormatter stringFromDate:date2];
    
    return ([DateString1 isEqualToString:DateString2]);
    
}




-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width*0.18, [UIScreen mainScreen].bounds.size.width*0.2316);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return LLDayModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    LLPunchStepsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    LLEveryDaystep *model = [LLDayModelArray objectAtIndex:indexPath.item];
    cell.LLPunchWeekLabel.text = model.LLEverydayWeekday;
    cell.LLPunchDayLabel.text = model.LLEveryDateString;
    cell.LLPunchStepsLabel.text = model.LLEverydayStep;
//    cell.LLPunchWeekLabel.text = [LLWeekArray objectAtIndex:indexPath.item];
//    cell.LLPunchDayLabel.text = [LLDayArray objectAtIndex:indexPath.item];
//    cell.LLPunchStepsLabel.text = [LLStepsArray objectAtIndex:indexPath.item];
    if (count==0) {
        NSLog(@"count ==0");
        if (indexPath.item ==LLDayModelArray.count-1) {
            cell.LLPunchAward.hidden = YES;
//            [cell setNeedsLayout];
            cell.LLPunchDayLabel.textColor = [UIColor colorWithRed:251.0/255.0 green:175.0/255.0 blue:173.0/255.0 alpha:1];
            cell.LLPunchWeekLabel.textColor = [UIColor colorWithRed:251.0/255.0 green:175.0/255.0 blue:173.0/255.0 alpha:1];
            cell.LLPunchStepsLabel.textColor = [UIColor colorWithRed:251.0/255.0 green:175.0/255.0 blue:173.0/255.0 alpha:1];
            
        }
        else if (cell.LLPunchStepsLabel.text.intValue>=10000){
            cell.LLPunchAward.hidden = NO;
//            [cell setNeedsLayout];
            cell.LLPunchDayLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
            cell.LLPunchWeekLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
            cell.LLPunchStepsLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
        }
        else{
            cell.LLPunchAward.hidden = YES;;
//             [cell setNeedsLayout];
            cell.LLPunchDayLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
            cell.LLPunchWeekLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
            cell.LLPunchStepsLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
        }
    }else{
        if (cell.LLPunchStepsLabel.text.intValue>=10000){
            cell.LLPunchAward.hidden = NO;
            //            [cell setNeedsLayout];
            cell.LLPunchDayLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
            cell.LLPunchWeekLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
            cell.LLPunchStepsLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
        }
        else{
            cell.LLPunchAward.hidden = YES;;
            //             [cell setNeedsLayout];
            cell.LLPunchDayLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
            cell.LLPunchWeekLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
            cell.LLPunchStepsLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
        }
    }
    
    if (indexPath.item == SelectedIndex.item && SelectedIndex != nil) {
        //如果是展开
        if (isSelectedItem == YES) {
            cell.LLPunchDayLabel.textColor = [UIColor whiteColor];
            cell.LLPunchWeekLabel.textColor = [UIColor whiteColor];
            cell.LLPunchStepsLabel.textColor = [UIColor whiteColor];
            NSLog(@"new cell");
        }else{
            cell.LLPunchDayLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
            cell.LLPunchWeekLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
            cell.LLPunchStepsLabel.textColor = [UIColor colorWithRed:94.0/255.0 green:109.0/255.0 blue:152.0/255.0 alpha:1];
            //收起
            NSLog(@"old cell");
        }
        //不是自身
    } else {
    }
    return cell;

}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------%zd", indexPath.item);
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    //判断选中不同row状态时候
    if (SelectedIndex != nil && indexPath.item == SelectedIndex.item) {
        //将选中的和所有索引都加进数组中
        //        indexPaths = [NSArray arrayWithObjects:indexPath,selectedIndex, nil];
        if(indexPath == SelectedIndex){
//            isSelectedItem = !isSelectedItem;
        }else{
            isSelectedItem = !isSelectedItem;
        }
        
        
    }else if (SelectedIndex != nil && indexPath.item != SelectedIndex.item) {
        indexPaths = [NSArray arrayWithObjects:indexPath,SelectedIndex, nil];
        isSelectedItem = YES;
        
    }
    
    //记下选中的索引
    SelectedIndex = indexPath;
    //刷新
    [LLStepsView reloadItemsAtIndexPaths:indexPaths];
//    step.text = nil;
    changeStepsLabel.paused = YES;
    LLEveryDaystep *model = [[LLEveryDaystep alloc]init];
    model = [LLDayModelArray objectAtIndex:indexPath.item];
    
    step.text  = model.LLEverydayStep;
    todaylabel.text = nil;
    todaylabel.text = model.LLEverydayDate;
    if (step.text.intValue>=10000) {
        step.textColor = [UIColor colorWithRed:251.0/255.0 green:175.0/255.0 blue:173.0/255.0 alpha:1];
    }else{
        step.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    }
    [bezierbackView removeFromSuperview];
    [punchView removeFromSuperview];
    ThedayStep = step.text;
    [self DrawCircleWithEnergy:ThedayStep];
//    nsda
    NSDate *thisdate = [dateformatter dateFromString:model.LLEverydayDate];
    
    [self DrawPunchCardView:thisdate];

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.view = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
