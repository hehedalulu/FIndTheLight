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
    backgroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, 414, 100)];
    backgroundScrollView.backgroundColor = [UIColor orangeColor];
    backgroundScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    backgroundScrollView.delegate = self;
    backgroundScrollView.contentSize = CGSizeMake(800, 0);
        backgroundScrollView.scrollEnabled = YES;
    backgroundScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:backgroundScrollView];
    
    
//    [scrollView setCanCancelContentTouches:NO];

//    scrollView.clipsToBounds  = YES;// 意思
//    scrollView.pagingEnabled  = YES;
}
-(void)initChooseBTtnArray{
    _LLFilterArray =[NSMutableArray array];
    NSMutableArray *temp = [[NSMutableArray alloc]initWithObjects:
                            @"默认滤镜",
                            @"滤镜1",
                            @"滤镜2",
                            @"滤镜3",
                            @"滤镜4",nil];
    [_LLFilterArray addObjectsFromArray:temp];
}


-(void)FilterChooseBtn{
    
//    UIButton * = [UIButton alloc]initWithFrame:cf
    for (int i = 0 ;i <_LLFilterArray.count; i++) {
        UIButton *filterChoseBtn = [[UIButton alloc]init];
        int PositionX  = i * 120 + 20;
//        int heigth = 60;
        filterChoseBtn.frame = CGRectMake(PositionX, 5, 60, 60);
        [filterChoseBtn setTitle: _LLFilterArray[i] forState:UIControlStateNormal];
        filterChoseBtn.backgroundColor = [UIColor purpleColor];
        [backgroundScrollView addSubview:filterChoseBtn];
        
    }
}




@end
