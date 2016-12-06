//
//  LLPunchViewController.m
//  UniversityPokemon
//
//  Created by Wll on 16/11/13.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLPunchViewController.h"



@interface LLPunchViewController (){
    NSInteger indexpage;
    AMapLocationManager *locationManager;
    MAPointAnnotation *pointAnnotaiton;
    NSMutableArray *annotations;

}
@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) IBOutlet MAMapView *mapview;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation LLPunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
        NSMutableArray *temp = [[NSMutableArray alloc]initWithObjects:
                                @"图书馆",
                                @"启明学院",
                                @"韵苑宿舍",
                                @"西十二教学楼",
                                @"华中科技大学东九教学楼",nil];
    [_items addObjectsFromArray:temp];


}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    //this is true even if your project is using ARC, unless
    //you are targeting iOS 5 as a minimum deployment target
    _carousel.delegate = nil;
    _carousel.dataSource = nil;

}
#pragma mark - 地理 定位 地图 懒加
//定位
- (void)configLocationManager
{
    locationManager = [[AMapLocationManager alloc] init];
    [locationManager setDelegate:self];
    //设置不允许系统暂停定位
    [locationManager setPausesLocationUpdatesAutomatically:NO];
    //设置允许在后台定位
    [locationManager setAllowsBackgroundLocationUpdates:YES];
    //开始进行连续定位
    [locationManager setLocatingWithReGeocode:YES];
    //开始连续定位
    [locationManager startUpdatingLocation];
}

#pragma mark - 自定义标志点

- (void)initAnnotions{
    
    annotations = [NSMutableArray array];
    CLLocationCoordinate2D coordinates[5] ={
        {30.511976, 114.411842},
        {30.509069, 114.430805},
        {30.514994, 114.433949},
        {30.509027, 114.407416},
        {30.513247, 114.426664}
    };
    
    for (int i = 0; i < _items.count; i++) {
        MAPointAnnotation *a1 = [[MAPointAnnotation alloc]init];
        a1.coordinate = coordinates[i];
        a1.title      = [NSString stringWithFormat:@"anno:%d",i];
        [annotations addObject:a1];
        
    }
    
}
#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout   = YES;
        annotationView.animatesDrop     = YES;
        annotationView.draggable        = YES;
        annotationView.image            = [UIImage imageNamed:@"icon_location.png"];
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - 生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initAnnotions];
    self.navigationController.navigationBar.hidden = YES;
    _carousel = [[iCarousel alloc]init];
    _carousel.delegate = self;
    _carousel.dataSource = self;
    [_carousel setBackgroundColor:[UIColor clearColor]];
    _carousel.frame = CGRectMake(0, 0, 414, 350);
    _carousel.type = iCarouselTypeCoverFlow2;
    [self.view addSubview:_carousel];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_mapview metersPerPointForZoomLevel:100];
    [self configLocationManager];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _mapview.mapType = MAMapTypeStandard;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [locationManager startUpdatingLocation];
    
    
    [_mapview addAnnotations:annotations];
    [_mapview showAnnotations:annotations edgePadding:UIEdgeInsetsMake(20, 20, 20, 80) animated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
    
    //获取到定位信息，更新annotation
    if (pointAnnotaiton == nil)
    {
        pointAnnotaiton = [[MAPointAnnotation alloc] init];
        [pointAnnotaiton setCoordinate:location.coordinate];
        
        [_mapview addAnnotation:pointAnnotaiton];
    }
    
    [pointAnnotaiton setCoordinate:location.coordinate];
    
    [_mapview setCenterCoordinate:location.coordinate];
    [_mapview setZoomLevel:15 animated:NO];
}




#pragma mark - iCarousel methods


- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [_items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIButton *button = (UIButton *)view;
    view.backgroundColor = [UIColor clearColor];
    if (button == nil)
    {
        UIImage *image = [UIImage imageNamed:@"page.png"];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //set button label
    [button setTitle:_items[index] forState:UIControlStateNormal];
    
    return button;
}
- (void)buttonTapped:(UIButton *)sender
{
    indexpage = [_carousel indexOfItemViewOrSubview:sender];
    [self performSegueWithIdentifier:@"Punch" sender:self];
    
}



- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}


@end
