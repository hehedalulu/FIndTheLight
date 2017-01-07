//
//  LLChooseView.m
//  FIndTheLight
//
//  Created by Wll on 16/12/4.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLChooseView.h"

@implementation LLChooseView


- (void)drawRect:(CGRect)rect {
    [self LLDrawAlpha];
    [self initChooseBTtnArray];
    [self FilterChooseBtn];
 }

-(void)LLDrawAlpha{
    backgroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.
                                                                         bounds.size.height*0.25,
                                                                         self.bounds.size.width,
                                                                         self.bounds.size.height*0.75)];
    backgroundScrollView.backgroundColor = [UIColor clearColor];
    backgroundScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    backgroundScrollView.delegate = self;
    backgroundScrollView.contentSize = CGSizeMake(self.bounds.size.width *1.2, 0);
        backgroundScrollView.scrollEnabled = YES;
    backgroundScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:backgroundScrollView];
    
    
//    [scrollView setCanCancelContentTouches:NO];

//    scrollView.clipsToBounds  = YES;// 意思
//    scrollView.pagingEnabled  = YES;
}
-(void)initChooseBTtnArray{
    _LLNameFilterArray = [NSMutableArray array];
    NSMutableArray *temp = [[NSMutableArray alloc]initWithObjects:
                            @"默认",
                            @"雪",
                            @"沙漠",
                            @"海洋",
                            @"滤镜4",nil];
    [_LLNameFilterArray addObjectsFromArray:temp];
    
    _LLFilterImageNameArray = [NSMutableArray array];
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithObjects:
                            @"default",
                            @"snow",
                            @"desert",
                            @"ocean",
                            @"",nil];
    [_LLFilterImageNameArray addObjectsFromArray:tempArray];
}


-(void)FilterChooseBtn{
//    UILabel *EnergyMax = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 80, 30)];
//    EnergyMax.text = @"10000";
//    EnergyMax.font = [UIFont fontWithName:@"Marker Felt" size:12];
//    EnergyMax.adjustsFontSizeToFitWidth = YES;
//    EnergyMax.textColor = [UIColor colorWithRed:212.0/255.0 green:202.0/255.0 blue:255.0/255.0 alpha:1];
////    [self addSubview:EnergyMax];
//    
//    [backgroundScrollView addSubview:EnergyMax];
    for (int i = 0 ;i <_LLNameFilterArray.count; i++) {
        
        int PositionX  = i * self.bounds.size.width*0.28 + self.bounds.size.width*0.0373;
        
        _LLChoseViewBtn = [[UIButton alloc]init];
        _LLChoseViewBtn.frame = CGRectMake(PositionX,
                                           5,
                                           self.bounds.size.width*0.213,
                                           self.bounds.size.width*0.27);
//        [_LLChoseViewBtn setTitle: _LLNameFilterArray[i] forState:UIControlStateNormal];
        _LLChoseViewBtn.backgroundColor = [UIColor clearColor];
        UIImageView *btnBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                               self.bounds.size.width*0.213,
                                                                               self.bounds.size.width*0.27)];
        btnBackImg.image = [UIImage imageNamed:[_LLFilterImageNameArray objectAtIndex:i]];
        [_LLChoseViewBtn addSubview:btnBackImg];
        [backgroundScrollView addSubview:_LLChoseViewBtn];
        
        UILabel *FilterNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(PositionX,
                                                                            self.bounds.size.width*0.28,
                                                                            self.bounds.size.width*0.213, 30)];
        FilterNameLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        FilterNameLabel.text = [_LLNameFilterArray objectAtIndex:i];
        FilterNameLabel.font = [UIFont systemFontOfSize:15];
        FilterNameLabel.textAlignment = NSTextAlignmentCenter;
        //        FilterNameLabel.adjustsFontSizeToFitWidth = YES;
        
        [backgroundScrollView addSubview:FilterNameLabel];
        
        
    }

}




@end
