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
    BOOL showTheFilterChooseView;
    LLChooseView *chooseview;
    
    UIButton *ShowFilterBtn;
    UIButton *LLHomeMenubtn;
    
    __block UILabel *LLCountTimerLabel;
    BOOL HasShowtheMatureView;
    LLMatureView *llmature;
    
    UIImageView *LLMatureBackgroudView;
    UIView *LLDissmissView;
    LLWaitingBall *waitingBall;
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
    [self drawview];
    [self ShowHiddenView];


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
    Screenshotbtn.frame = CGRectMake(12, 180, 50, 50);
    [Screenshotbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [Screenshotbtn setImage:[UIImage imageNamed:@"btn_camera"] forState:UIControlStateNormal];
    [Screenshotbtn addTarget:self action:@selector(Screenshot) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:Screenshotbtn];
    
    
    ghostSelfInformationNotShow = NO;
    
    
    displayView = [[LLHomePageDisplayView alloc]init];
    displayView.frame = CGRectMake(12, 33, 117, 60);
    displayView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:displayView];
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
//    tapGesture.delegate = (id <UIGestureRecognizerDelegate>)self;
//    [displayView addGestureRecognizer:tapGesture];
    
    LLHomePageInformationView *pageInformationView = [[LLHomePageInformationView alloc]init];
    pageInformationView.frame = CGRectMake(264, 33, 234, 150);
    pageInformationView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:pageInformationView];
    
    
    LLHomeMenubtn = [[UIButton alloc]init];
    LLHomeMenubtn.frame = CGRectMake(350, 650, 50, 50);
    [LLHomeMenubtn setImage:[UIImage imageNamed:@"btn_list"] forState:UIControlStateNormal];
    [self.glView addSubview:LLHomeMenubtn];
    [LLHomeMenubtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

    ShowFilterBtn = [[UIButton alloc]initWithFrame:CGRectMake(21, 650, 50, 50)];
    [ShowFilterBtn setImage:[UIImage imageNamed:@"btn_filter"] forState:UIControlStateNormal];
    [ShowFilterBtn addTarget:self action:@selector(showFilterChooseView) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:ShowFilterBtn];
    
    [self drawChooseView];
    
    waitingBall = [[LLWaitingBall alloc]initWithFrame:CGRectMake(330, 180, 70, 70)];
    [waitingBall LLBallAlwaysDraw];
    [self.glView addSubview:waitingBall];
    
    UITapGestureRecognizer *TapWaitingBall = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ShortTapWaitingBall:)];
    [waitingBall addGestureRecognizer:TapWaitingBall];
    
    LLCountTimerLabel = [[UILabel alloc]initWithFrame:CGRectMake(340, 250, 100, 30)];
    LLCountTimerLabel.textColor = [UIColor colorWithDisplayP3Red:212.0/255.0 green:202.0/255.0 blue:255.0/255.0 alpha:1];
    [self.glView addSubview:LLCountTimerLabel];
    [self CountTimerAnimation:2];
//    [self showWaitingBallMatureView];


}


-(void)drawfilterImageView{
    
    FilterBackgroundView = [[LLFilterBackgroundView alloc]initWithFrame:CGRectMake(0, 0, 414, 736)];
    FilterBackgroundView.LLFilteralapa = 1.0;
    [FilterBackgroundView setImage];
    FilterBackgroundView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:FilterBackgroundView];

    
    LLFilterAlwaysView *filterAlwaysView = [[LLFilterAlwaysView alloc]initWithFrame:CGRectMake(0, 0, 414, 736)];
    [filterAlwaysView LLfilerAlwaysDraw];
    FilterBackgroundView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:filterAlwaysView];

    LLFilterView *filterView = [[LLFilterView alloc]initWithFrame:CGRectMake(0, 0,414,736)];
    filterView.backgroundColor = [UIColor clearColor];
    [filterView LLfilerDraw];
//    [self.glView addSubview:filterView];

}


-(void)ShowHiddenView{

    UIButton *showthehintBtn = [[UIButton alloc]initWithFrame:CGRectMake(12, 115,50, 50)];
//    showthehintBtn.backgroundColor =[UIColor yellowColor];
    [showthehintBtn setImage:[UIImage imageNamed:@"btn_card"] forState:UIControlStateNormal];
    [showthehintBtn addTarget:self action:@selector(showHintView) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:showthehintBtn];
    
    LLDissmissView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    LLDissmissView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    LLDissmissView.hidden = YES;
    [self.glView addSubview:LLDissmissView];
    
    UITapGestureRecognizer *tapMatureViewToHome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissMatureView)];
    [LLDissmissView addGestureRecognizer:tapMatureViewToHome];
    
    LLMatureBackgroudView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 0, 0)];
    LLMatureBackgroudView.backgroundColor = [UIColor greenColor];
    [self.glView addSubview:LLMatureBackgroudView];
    
    llmature = [[LLMatureView alloc]init];
    HasShowtheMatureView = NO;
    

    llmature.backgroundColor = [UIColor greenColor];
    [llmature drawRect:CGRectMake(0,0, 0, 0)];
    [LLMatureBackgroudView addSubview:llmature];

    
}




-(void)drawChooseView{
    chooseview = [[LLChooseView alloc]initWithFrame:CGRectMake(0, 1000, 414, 130)];
//    = [chooseview filterchange:chooseview.LLsilderchange];
    
    UISlider *_LLsilderchange = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, 414, 30)];
    _LLsilderchange.backgroundColor = [UIColor whiteColor];
    _LLsilderchange.maximumValue = 1.0;
    _LLsilderchange.minimumValue = 0.0;
    _LLsilderchange.value = 0.5;
    [_LLsilderchange addTarget:self action:@selector(filterchange:) forControlEvents:UIControlEventValueChanged];
    [chooseview addSubview:_LLsilderchange];
    
    [self.glView addSubview:chooseview];
}

- (void)filterchange:(UISlider *) slider{
//    NSLog(@"%f",slider.value);
    FilterBackgroundView.LLFilteralapa = slider.value;
    NSLog(@"%f",FilterBackgroundView.LLFilteralapa);
    [FilterBackgroundView setImage];
}



#pragma mark - 光体成熟页面动画
-(void)showWaitingBallMatureView{
//    NSLog(@"蹦出动画");
    POPSpringAnimation *PopMatureView = [POPSpringAnimation animation];
    PopMatureView.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
//    if (!HasShowtheMatureView) {
        PopMatureView.toValue = [NSValue valueWithCGRect:CGRectMake(self.view.center.x-140, self.view.center.y-190, 280, 380)];
    
    LLDissmissView.hidden = NO;
    [self performSelector:@selector(initMaturethingsView) withObject:nil afterDelay:0.3];
//        HasShowtheMatureView = YES;
//    }else{
//        PopMatureView.toValue = [NSValue valueWithCGSize:CGSizeMake(0,0)];
//        HasShowtheMatureView = NO;
//    }
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
    NSLog(@"收回动画");
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

-(void)CountTimerAnimation:(int)StopTime{

    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            LLCountTimerLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)values[0]/60,(int)values[0]%60];
        };
        
        //        prop.threshold = 0.01f;
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(0);   //从0开始
    anBasic.toValue = @(5);  //180秒
    anBasic.duration = 5;    //持续3分钟
    anBasic.beginTime = CACurrentMediaTime() + 1.0f;    //延迟1秒开始
    [LLCountTimerLabel pop_addAnimation:anBasic forKey:@"countdown"];
    
//    [self performSelector:@selector(showWaitingBallMatureView) withObject:self afterDelay:8];
}


-(void)ShortTapWaitingBall:(UITapGestureRecognizer *)gesture{
    NSLog(@"tantantan ");
    POPSpringAnimation *buttonSizeAnimation = [POPSpringAnimation animation];
    buttonSizeAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerScaleXY];
    
    buttonSizeAnimation.toValue = @(10);
    
    buttonSizeAnimation.springBounciness = 20.0;
    buttonSizeAnimation.springSpeed      = 10.0;
    [waitingBall pop_addAnimation:buttonSizeAnimation forKey:@"sizeAnimation"];
    
    
}
#pragma mark - 滤镜选择
-(void)showFilterChooseView{
    
    if (showTheFilterChooseView) {
        [self showchooseView];
        
        showTheFilterChooseView = NO;
    }else{
        [self closechooseView];
        showTheFilterChooseView = YES;
    }
}

-(void)showchooseView{
    
    POPSpringAnimation *showchoose = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = 207;
    CGFloat centerY = 700;
    
    showchoose.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    showchoose.springBounciness = 4;
    showchoose.springSpeed = 6;
    [chooseview pop_addAnimation:showchoose forKey:@"showChooseView"];
    
    POPSpringAnimation *filterbtnUP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerfilterbtnupX = 30;
    CGFloat centerfilterbtnupY = 600;
    
    filterbtnUP.toValue = [NSValue valueWithCGPoint:CGPointMake(centerfilterbtnupX, centerfilterbtnupY)];
    filterbtnUP.springBounciness = 4;
    filterbtnUP.springSpeed = 6;
    [ShowFilterBtn pop_addAnimation:filterbtnUP forKey:@"filterbtnup"];
    
    POPSpringAnimation *menubtnUP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat menubtnUPX = 375;
    CGFloat menubtnUPY = 600;
    
    menubtnUP.toValue = [NSValue valueWithCGPoint:CGPointMake(menubtnUPX, menubtnUPY)];
    menubtnUP.springBounciness = 4;
    menubtnUP.springSpeed = 6;
    [LLHomeMenubtn pop_addAnimation:menubtnUP forKey:@"menubtnup"];
    
}

-(void)closechooseView{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = 207;
    CGFloat centerY =1000;
    
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    anim.springBounciness = 4;
    anim.springSpeed = 6;
    [chooseview pop_addAnimation:anim forKey:@"closeChooseView"];
    
    POPSpringAnimation *filterbtnUP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerfilterbtnupX = 30;
    CGFloat centerfilterbtnupY = 650;
    
    filterbtnUP.toValue = [NSValue valueWithCGPoint:CGPointMake(centerfilterbtnupX, centerfilterbtnupY)];
    filterbtnUP.springBounciness = 4;
    filterbtnUP.springSpeed = 6;
    [ShowFilterBtn pop_addAnimation:filterbtnUP forKey:@"filterbtndown"];
    
    POPSpringAnimation *menubtnUP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat menubtnUPX = 375;
    CGFloat menubtnUPY = 650;
    
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
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }else{
            
            llsearchAroundLocation = [[LLSearchAroundLocation alloc]init];
            [llsearchAroundLocation GetRequestionlongitude:location.coordinate.longitude latitude:location.coordinate.latitude];
            
            if (displayView.LLHomeDisplayLabel.text == nil) {
                displayView.LLHomeDisplayLabel.text = @"正在定位中";
            }
            [self performSelector:@selector(changedisplayLabel) withObject:nil afterDelay:1.0];
        }
        
        NSLog(@"coordinate.latitude:%f,%f", location.coordinate.latitude,location.coordinate.longitude);
    }];
}

-(void)changedisplayLabel{
        displayView.LLHomeDisplayLabel.text = llsearchAroundLocation.LLNearestLocation;
        NSLog(@"%@",displayView.LLHomeDisplayLabel);
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
