//
//  LLLightBoxViewController.m
//  FIndTheLight
//
//  Created by Wll on 17/2/11.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLLightBoxViewController.h"
#import "LLLightBoxCollectionViewCell.h"

@interface LLLightBoxViewController (){
    UICollectionView *LightBoxCollectionView;
    NSMutableArray *CollectionViewImagesArray;
    NSMutableArray *LightBoxNameArray;
    UIPageControl *pageControl;
}

@end

@implementation LLLightBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.view.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:27.0/255.0 blue:47.0/255.0 alpha:1];

    UILabel *pagename = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12,
                                                                 [UIScreen mainScreen].bounds.size.width*0.05,
                                                                 [UIScreen mainScreen].bounds.size.width*0.36,
                                                                 [UIScreen mainScreen].bounds.size.width*0.15)];
    pagename.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    pagename.text = @".光体箱";
    pagename.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    [self.view addSubview:pagename];
    
    UIButton *dismissBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.025,
                                                                     [UIScreen mainScreen].bounds.size.width*0.08,
                                                                     [UIScreen mainScreen].bounds.size.width*0.1,
                                                                     [UIScreen mainScreen].bounds.size.width*0.1)];
    [dismissBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    if (!detailView) {
        detailView = [[LLLightBoxDetailView alloc]initWithFrame:CGRectMake(0,
                                                                           [UIScreen mainScreen].bounds.size.width*0.2,
                                                                           [UIScreen mainScreen].bounds.size.width,
                                                                           [UIScreen mainScreen].bounds.size.width*0.635)];
//        [detailView drawRect:CGRectMake(0,
//                                        [UIScreen mainScreen].bounds.size.width*0.233,
//                                        [UIScreen mainScreen].bounds.size.width,
//                                        [UIScreen mainScreen].bounds.size.width*0.635)];
        [self.view addSubview:detailView];
    }
    
    if (!CollectionBackgroundView) {
        CollectionBackgroundView = [[UIImageView alloc]init];
        CollectionBackgroundView.image = [UIImage imageNamed:@"LightCollectionView_layer.png"];
        CollectionBackgroundView.userInteractionEnabled = YES;
        [self.view addSubview:CollectionBackgroundView];
        [CollectionBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(self.view.frame.size.width*0.02);
            make.top.mas_equalTo(detailView.mas_bottom).offset(self.view.frame.size.width*0.01);
            make.width.mas_equalTo(self.view.frame.size.width*0.96);
            make.height.mas_equalTo(self.view.frame.size.width*0.885);
        }];
        
        UILabel *MyCollectionLabel = [[UILabel alloc]init];
        MyCollectionLabel.text = @"我的收藏";
        MyCollectionLabel.textAlignment = NSTextAlignmentCenter;
        MyCollectionLabel.textColor = [UIColor colorWithRed:42.0/255.0 green:94.0/255.0 blue:161.0/255.0 alpha:1];
        MyCollectionLabel.font = [UIFont systemFontOfSize:16];
        [CollectionBackgroundView addSubview:MyCollectionLabel];
        [MyCollectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(CollectionBackgroundView);
            make.top.equalTo(CollectionBackgroundView).offset(self.view.frame.size.width*0.04);
            make.width.mas_equalTo(self.view.frame.size.width*0.24);
            make.height.mas_equalTo(self.view.frame.size.width*0.08);
        }];
        [self initCollectionViewImagesArray];
        [self initCollectView];
    }
    

}
#pragma mark- CollectionView初始化
-(void)initCollectView{
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width*0.24, self.view.frame.size.width*0.3);
    // 设置最小行间距
    layout.minimumLineSpacing = self.view.frame.size.width*0.085;
    // 设置垂直间距
//    layout.minimumInteritemSpacing = self.view.frame.size.width*0.042;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    // 设置滚动方向（默认垂直滚动）
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    LightBoxCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.032,
                                                                    self.view.frame.size.width*0.15,
                                                                    self.view.frame.size.width*0.896,
                                                                    self.view.frame.size.width*0.67) collectionViewLayout:layout];
    
    LightBoxCollectionView.backgroundColor = [UIColor clearColor];
    LightBoxCollectionView.delegate = self;
    LightBoxCollectionView.dataSource = self;
    LightBoxCollectionView.alwaysBounceHorizontal = YES;
    LightBoxCollectionView.showsHorizontalScrollIndicator = NO;
    LightBoxCollectionView.userInteractionEnabled = YES;
//    LightBoxCollectionView.able    
    //    NSIndexPath *path = [NSIndexPath indexPathForItem:4 inSection:0];
    //    [LLStepsView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
//    LightBoxCollectionView.contentOffset = CGPointMake(self.view.frame.size.width*0.96*4, 0);
    
    // 通过xib注册
    [LightBoxCollectionView registerClass:[LLLightBoxCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [CollectionBackgroundView addSubview: LightBoxCollectionView];
    
    pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = CollectionViewImagesArray.count/6;
    if (CollectionViewImagesArray.count/6 == 1) {
        pageControl.alpha = 0;
    }
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:59.0/255.0 green:65.0/255.0 blue:94.0/255.0 alpha:1];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:253.0/255.0 alpha:1];
    [CollectionBackgroundView addSubview:pageControl];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(LightBoxCollectionView);
        make.top.mas_equalTo(LightBoxCollectionView.mas_bottom);
        make.width.mas_equalTo(self.view.frame.size.width*0.1);
    }];
}

#pragma mark- CollectionView数据源datasource
-(void)initCollectionViewImagesArray{
    CollectionViewImagesArray = [[NSMutableArray alloc]initWithObjects:
                                 @"optical_layer_normal.png",
                                 @"optical_layer_normal.png",
                                 @"optical_layer_normal.png",
                                 @"optical_layer_unknown.png",
                                 @"optical_layer_normal.png",
                                 @"optical_layer_unknown.png",
                                 nil];
    
    LightBoxNameArray = [[NSMutableArray alloc]initWithObjects:
                                    @"灯泡",
                                    @"钻石",
                                    @"南瓜",
                                    @"未知",
                                    @"星星",
                                    @"未知",
                                        nil];
    
    
}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake([UIScreen mainScreen].bounds.size.width*0.24, [UIScreen mainScreen].bounds.size.width*0.3);
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return CollectionViewImagesArray.count;
//    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    LLLightBoxCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.LLBoxCellLabel.text = [LightBoxNameArray objectAtIndex:indexPath.item];
    cell.LLBoxCellImage.image = [UIImage imageNamed:[CollectionViewImagesArray objectAtIndex:indexPath.item]];
    return cell;
}

#pragma mark- CollectionView代理协议delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int currentIndex = scrollView.contentOffset.x/LightBoxCollectionView.frame.size.width;
    pageControl.currentPage = currentIndex;

}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//
//
//}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
        double cOffset = scrollView.contentOffset.x ;
//        int page;
        if (cOffset < LightBoxCollectionView.frame.size.width/2) {
//            page = 0;
            [scrollView setContentOffset:CGPointMake(5, 0) animated:YES];
        }else{
            [scrollView setContentOffset:CGPointMake(LightBoxCollectionView.bounds.size.width+self.view.frame.size.width*0.085, 0) animated:YES];
        }
//    CGFloat offsetX = page  * ;
//    if (scrollView.contentOffset.x<= LightBoxCollectionView.frame.size.width/2) {
//        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }else{
    
//    }
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.item);
//    detailView.LightName =
    switch (indexPath.item) {
        case 0:{
            
//
            detailView.LightName.text = @"灯泡";
            detailView.LightLevel.text = @"C";
            detailView.LLBoxSuiPianLabel1.text = @"氖气";
            detailView.LLBoxSuiPianLabel2.text = @"玻璃";
            detailView.LLBoxSuiPianLabel3.text = @"钨丝";
            detailView.LLBoxSuiPianLabel3.hidden = NO;
            detailView.LLBoxSuiPianFix3.hidden = NO;
            detailView.LLBoxSuiPianImage3.hidden = NO;
            detailView.LLBoxLightImage.image = [UIImage imageNamed:@"optical.png"];
            break;
        }case 1:{
            detailView.LightName.text = @"钻石";
            detailView.LightLevel.text = @"C";
            detailView.LLBoxSuiPianLabel1.text = @"爱意";
            detailView.LLBoxSuiPianLabel1.text = @"晶体";
            detailView.LLBoxSuiPianLabel3.hidden = YES;
            detailView.LLBoxSuiPianFix3.hidden = YES;
            detailView.LLBoxSuiPianImage3.hidden = YES;
            detailView.LLBoxLightImage.image = [UIImage imageNamed:@"zuanshi.png"];
            break;
        }case 2:{
            detailView.LightName.text = @"南瓜";
            detailView.LightLevel.text = @"A";
            detailView.LLBoxSuiPianLabel1.text = @"藤蔓";
            detailView.LLBoxSuiPianLabel1.text = @"尖叫";
            detailView.LLBoxSuiPianLabel3.text = @"南瓜饼";
            detailView.LLBoxSuiPianLabel3.hidden = NO;
            detailView.LLBoxSuiPianFix3.hidden = NO;
            detailView.LLBoxSuiPianImage3.hidden = NO;
            detailView.LLBoxLightImage.image = [UIImage imageNamed:@"pumpkin.png"];
            break;
        }case 4:{
            detailView.LightName.text = @"星星";
            detailView.LightLevel.text = @"S";
            detailView.LLBoxSuiPianLabel1.text = @"翅膀";
            detailView.LLBoxSuiPianLabel1.text = @"发光的尾巴";
            detailView.LLBoxSuiPianLabel3.hidden = NO;
            detailView.LLBoxSuiPianFix3.hidden = NO;
            detailView.LLBoxSuiPianImage3.hidden = NO;
            detailView.LLBoxLightImage.image = [UIImage imageNamed:@"starstar.png"];
            break;
        }
        default:{
            detailView.LightName.text = @"未知";
            detailView.LightLevel.text = @"未知";
            
            detailView.LLBoxSuiPianLabel1.text = @"未知";
            detailView.LLBoxSuiPianLabel2.text = @"未知";
            detailView.LLBoxSuiPianLabel3.text = @"未知";
            detailView.LLBoxSuiPianImage1.image = [UIImage imageNamed:@"debris_unknown.png"];
            detailView.LLBoxSuiPianImage2.image = [UIImage imageNamed:@"debris_unknown.png"];
            detailView.LLBoxSuiPianImage3.image = [UIImage imageNamed:@"debris_unknown.png"];
            detailView.LLBoxSuiPianLabel3.hidden = NO;
            detailView.LLBoxSuiPianFix3.hidden = NO;
            detailView.LLBoxSuiPianImage3.hidden = NO;
            detailView.LLBoxLightImage.image = nil;
            break;
        }

            
            break;
    }
    
}

#pragma mark- 其他

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dismissView{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
