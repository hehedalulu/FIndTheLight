//
//  LLHintViewController.m
//  FIndTheLight
//
//  Created by Wll on 16/12/7.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLHintViewController.h"
//#import "GPUImage.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobFile.h>
#import <SDWebImage/UIButton+WebCache.h>
@interface LLHintViewController ()<iCarouselDataSource, iCarouselDelegate>{
    NSMutableArray *HintImageNameArray;
}

@end

@implementation LLHintViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.layer.cornerRadius = 8.f;
    self.view.backgroundColor = [UIColor clearColor];
    
//    HintImageNameArray = [[NSMutableArray alloc]init];
//    [self initPics];
    

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewdismiss:)];
    [self.view addGestureRecognizer:tap];
    [self performSelector:@selector(setBgColor) withObject:self afterDelay:0.5];
    [self initCarousel];

}

-(void)setBgColor{
//    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0 ,0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0.8;
//    [self.view addSubview:backgroundView];
}

-(void)tapViewdismiss:(UITapGestureRecognizer *)sender{
        [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    icarousel = nil;
}

-(void)initPics{

    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"seekPictures"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"9cahbbbj" block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
            NSLog(@"没有查询到图片");
        }else{
           NSMutableArray  *tempArray = [[NSMutableArray alloc]init];
            if (object) {
                NSURL *tempfileurl1 = nil;
                NSURL *tempfileurl2 = nil;
                NSURL *tempfileurl3 = nil;
                NSURL *tempfileurl4 = nil;
                NSURL *tempfileurl5 = nil;
                if ((BmobFile *)[object objectForKey:@"LocationPics1"]) {
                    BmobFile *file = (BmobFile*)[object objectForKey:@"LocationPics1"];
                    NSLog(@"LocationPics1 %@ ",file.url);
                    tempfileurl1 = (NSURL *)file.url;
                    [tempArray insertObject:tempfileurl1 atIndex:[tempArray count]];
//                    [_pic1 sd_setImageWithURL:HintImageArray[0] placeholderImage:[UIImage imageNamed:@"bg_img"] options:SDWebImageRefreshCached];
                }
                
                if ((BmobFile *)[object objectForKey:@"LocationPic2"]) {
                    BmobFile *file2 = (BmobFile*)[object objectForKey:@"LocationPic2"];
                    NSLog(@"LocationPic2 %@ ",file2.url);
                    tempfileurl2= (NSURL *)file2.url;
                    [tempArray insertObject:tempfileurl2 atIndex:[tempArray count]];
//                    [_pic2 sd_setImageWithURL:HintImageArray[1] placeholderImage:[UIImage imageNamed:@"bg_img"] options:SDWebImageRefreshCached];
                }
                if ((BmobFile *)[object objectForKey:@"LocationPic3"]) {
                    BmobFile *file3 = (BmobFile*)[object objectForKey:@"LocationPic3"];
                    NSLog(@"LocationPic3 %@ ",file3.url);
                    tempfileurl3 = (NSURL *)file3.url;
                    [tempArray insertObject:tempfileurl3 atIndex:[tempArray count]];
//                    [_pic3 sd_setImageWithURL:HintImageArray[2] placeholderImage:[UIImage imageNamed:@"bg_img"] options:SDWebImageRefreshCached];
                }
                if ((BmobFile *)[object objectForKey:@"LocationPic4"]) {
                    BmobFile *file4 = (BmobFile*)[object objectForKey:@"LocationPic4"];
                    NSLog(@"LocationPic4 %@ ",file4.url);
                    tempfileurl4 = (NSURL *)file4.url;
                    [tempArray insertObject:tempfileurl4 atIndex:[tempArray count]];
//                    [_pic4 sd_setImageWithURL:HintImageArray[2] placeholderImage:[UIImage imageNamed:@"bg_img"] options:SDWebImageRefreshCached];
                }
                if ((BmobFile *)[object objectForKey:@"LocationPic5"]) {
                    BmobFile *file5 = (BmobFile*)[object objectForKey:@"LocationPic5"];
                    NSLog(@"LocationPic5 %@ ",file5.url);
                    tempfileurl5 = (NSURL *)file5.url;
                    [tempArray insertObject:tempfileurl5 atIndex:[tempArray count]];
//                    [_pic4 sd_setImageWithURL:HintImageArray[2] placeholderImage:[UIImage imageNamed:@"bg_img"] options:SDWebImageRefreshCached];
                }
//                HintImageNameArray = [tempArray copy];
                [HintImageNameArray addObjectsFromArray:tempArray];
                NSLog(@"查询到图片");
            }
        }
    }];

}

-(void)initCarousel{
    
    
    HintImagesArray = [NSMutableArray array];
    NSMutableArray *temp = [[NSMutableArray alloc]initWithObjects:
                            @"WechatIMG249",
                            @"WechatIMG248",
                            @"WechatIMG250",
                            @"WechatIMG251",
                            @"WechatIMG253",nil];
    [HintImagesArray addObjectsFromArray:temp];
    
    icarousel = [[iCarousel alloc]initWithFrame:CGRectMake(50,100+[UIScreen mainScreen].bounds.size.height*0.153, [UIScreen mainScreen].bounds.size.width+50, [UIScreen mainScreen].bounds.size.height*0.285)];
    icarousel.dataSource = self;
    icarousel.delegate = self;
    icarousel.backgroundColor =[UIColor clearColor];
    icarousel.type = iCarouselTypeCoverFlow;
    icarousel.layer.masksToBounds = YES;
    [self.view addSubview:icarousel];
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

    
}

- (void)dealloc
{
    icarousel.delegate = nil;
    icarousel.dataSource = nil;

}


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
        //        NSString *imageNameString = [NSString stringWithFormat:@"WechatIMG2%@",];
//        UIImage *inputimage = [UIImage imageNamed:HintImagesArray[index]];
        NSString *path = [[NSBundle mainBundle] pathForResource:HintImagesArray[index] ofType:@"jpeg"];
        
        UIImage *inputimage = [UIImage imageWithContentsOfFile:path];
//        GPUImageGaussianBlurFilter *passthroughfilter = [[GPUImageGaussianBlurFilter alloc]init];
//        passthroughfilter.blurRadiusInPixels = 20.0;
//        
//        [passthroughfilter forceProcessingAtSize:inputimage.size];
//        [passthroughfilter useNextFrameForImageCapture];

//        GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:inputimage];
//        [stillImageSource addTarget:passthroughfilter];
//        [stillImageSource processImage];
//        //渲染结果image
//        UIImage *nearestNeighborImage = [passthroughfilter imageFromCurrentFramebuffer];
        
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width*0.506, [UIScreen mainScreen].bounds.size.width*0.506);
        
//        NSURL *tempfileurl = [HintImageNameArray objectAtIndex:index];
//        NSLog(@"%@",tempfileurl);
//        [button sd_setBackgroundImageWithURL:tempfileurl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"FilterLighting_bg_img"] options:SDWebImageRefreshCached];
        [button setBackgroundImage:[UIImage imageNamed:@"homepage_card"] forState:UIControlStateNormal];
//        button.backgroundColor = [UIColor blueColor];
        UIImageView *insertImg = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.035,[UIScreen mainScreen].bounds.size.width*0.035, [UIScreen mainScreen].bounds.size.width*0.437, [UIScreen mainScreen].bounds.size.width*0.437)];
        insertImg.image = inputimage;
        insertImg.alpha =0.85;
        [button addSubview: insertImg];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //set button label
    //    [button setTitle:_items[index] forState:UIControlStateNormal];
            NSLog(@" initbtn");
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



@end
