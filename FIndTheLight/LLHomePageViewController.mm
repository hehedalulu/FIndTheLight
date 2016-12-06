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
    
    BOOL showTheHintView;
    UIView *LLHintView;

    
    LLFilterBackgroundView *FilterBackgroundView;
    BOOL showTheFilterChooseView;
    LLChooseView *chooseview;
    
    UIButton *ShowFilterBtn;
    UIButton *LLHomeMenubtn;
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
    [self ShowHintimage];


}


#pragma mark - DrawView

-(void)drawview{
    //截图
    Screenshotbtn = [[UIButton alloc]init];
    Screenshotbtn.frame = CGRectMake(369, 190, 40, 37);
    [Screenshotbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    Screenshotbtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Btn_icon_camera"]];
    Screenshotbtn.titleLabel.font = [UIFont systemFontOfSize:30];
    [Screenshotbtn addTarget:self action:@selector(Screenshot) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:Screenshotbtn];
    
    
    ghostSelfInformationNotShow = NO;
    
    
    displayView = [[LLHomePageDisplayView alloc]init];
    displayView.frame = CGRectMake(10, 30, 150, 80);
    displayView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:displayView];
    
    LLHomePageInformationView *pageInformationView = [[LLHomePageInformationView alloc]init];
    pageInformationView.frame = CGRectMake(264, 20, 180, 150);
    pageInformationView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:pageInformationView];
    
    
    LLHomeMenubtn = [[UIButton alloc]init];
    LLHomeMenubtn.frame = CGRectMake(350, 650, 50, 50);
    LLHomeMenubtn.backgroundColor = [UIColor yellowColor];
    [self.glView addSubview:LLHomeMenubtn];
    [LLHomeMenubtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

    
    ShowFilterBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 650, 50, 50)];
    ShowFilterBtn.backgroundColor = [UIColor orangeColor];
    [ShowFilterBtn addTarget:self action:@selector(showFilterChooseView) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:ShowFilterBtn];
    
    [self drawChooseView];
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
    [self.glView addSubview:filterView];

}


-(void)ShowHintimage{
    LLHintView = [[UIView alloc]init];
    LLHintView.frame = CGRectMake(-650, -600, 400, 300);
    LLHintView.backgroundColor = [UIColor clearColor];
    [self.glView addSubview:LLHintView];
    
    
    UIButton *showthehintBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 150, 40, 40)];
    showthehintBtn.backgroundColor =[UIColor yellowColor];
    showTheHintView = YES;
    [showthehintBtn addTarget:self action:@selector(addtheView) forControlEvents:UIControlEventTouchUpInside];
    [self.glView addSubview:showthehintBtn];
    

    icarousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, 400, 300)];
    icarousel.delegate = self;
//    icarousel.dataSource = self;
    icarousel.type = iCarouselTypeCoverFlow2;
    [LLHintView addSubview:icarousel];
    

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


- (void)viewDidUnload
{
    [super viewDidUnload];
    icarousel = nil;
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



#pragma mark - Hint弹框

-(void)addtheView{
    if (showTheHintView) {
        [self showTheView];
        showTheHintView = NO;
    }else{
        [self closetestView];
        showTheHintView = YES;
    }
}

-(void)showTheView{
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = 200;
    CGFloat centerY = 200;
    
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    anim.springBounciness = 16;
    anim.springSpeed = 6;
    [LLHintView pop_addAnimation:anim forKey:@"show"];
}

-(void)closetestView{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = -500;
    CGFloat centerY = 200;
    
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    anim.springBounciness = 16;
    anim.springSpeed = 6;
    [LLHintView pop_addAnimation:anim forKey:@"close"];
}

#pragma mark - Hint详情页面

- (void)awakeFromNib
{
    [super awakeFromNib];
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    HintImagesArray = [NSMutableArray array];
    NSMutableArray *temp = [[NSMutableArray alloc]initWithObjects:
                            @"WechatIMG246",
                            @"WechatIMG247",
                            @"WechatIMG248",
                            @"WechatIMG249",
                            @"WechatIMG250",nil];
    [HintImagesArray addObjectsFromArray:temp];
    
}

//- (void)dealloc
//{
//    icarousel.delegate = nil;
//    icarousel.dataSource = nil;
//    
//}


- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [HintImagesArray count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIButton *button = (UIButton *)view;
    if (button == nil)
    {
//        //        NSString *imageNameString = [NSString stringWithFormat:@"WechatIMG2%@",];
        NSString *path = [[NSBundle mainBundle] pathForResource:HintImagesArray[index] ofType:@"jpeg"];
        
        UIImage *inputimage = [UIImage imageWithContentsOfFile:path];
//        UIImage *inputimage = [UIImage imageNamed:];
        GPUImageBoxBlurFilter *passthroughfilter = [[GPUImageBoxBlurFilter alloc]init];
        passthroughfilter.blurRadiusInPixels = 100.0;
        
        [passthroughfilter forceProcessingAtSize:inputimage.size];
        [passthroughfilter useNextFrameForImageCapture];
        
        GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputimage];
        [stillImageSource addTarget:passthroughfilter];
        [stillImageSource processImage];
        //渲染结果image
        UIImage *nearestNeighborImage = [passthroughfilter imageFromCurrentFramebuffer];
        
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, 200, 200);
        [button setBackgroundImage:nearestNeighborImage forState:UIControlStateNormal];
        button.backgroundColor = [UIColor yellowColor];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //set button label
    //    [button setTitle:_items[index] forState:UIControlStateNormal];
    
    return button;
}
- (void)buttonTapped:(UIButton *)sender
{
    //get item index for button
    //    indexpage = [_icarousel indexOfItemViewOrSubview:sender];
    //    [self performSegueWithIdentifier:@"Punch" sender:self];
    //    LLPunchDetailViewController *llPunchDetailViewController = [[LLPunchDetailViewController alloc]init];
    //    llPunchDetailViewController.detaillocationName = _items[index];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //    LLPunchDetailViewController *view = [segue destinationViewController];
    //    [view passdata:_items[indexpage]];
}


- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
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
    
    //设置不允许系统暂停定位
    [locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置定位超时时间
    [locationManager setLocationTimeout:DefaultLocationTimeout];

    [locationManager setLocatingWithReGeocode:YES];
    
    [locationManager startUpdatingLocation];
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    //更新同时回调地理逆编码
    //    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
    
    //    if (reGeocode)
    //    {
    //        NSLog(@"reGeocode:%@", reGeocode);
    //    }
    
    
    NSLog(@"%f,%f", location.coordinate.latitude, location.coordinate.longitude);
    llsearchAroundLocation = [[LLSearchAroundLocation alloc]init];
    [llsearchAroundLocation GetRequestionlongitude:location.coordinate.longitude latitude:location.coordinate.latitude];
//    displayView.LLHomeDisplayLabel.text = @"测试";
    [self performSelector:@selector(changedisplayLabel) withObject:nil afterDelay:1.0];

}

-(void)changedisplayLabel{
        displayView.LLHomeDisplayLabel.text = llsearchAroundLocation.LLNearestLocation;
        NSLog(@"%@",displayView.LLHomeDisplayLabel);
}

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
