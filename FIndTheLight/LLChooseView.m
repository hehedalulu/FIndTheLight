//
//  LLChooseView.m
//  FIndTheLight
//
//  Created by Wll on 16/12/4.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLChooseView.h"
#import "LLMixFilterViewController.h"
#import "LLChooseViewCell.h"

@implementation LLChooseView


- (void)drawRect:(CGRect)rect {
    self.userInteractionEnabled = YES;
//    [self LLDrawAlpha];
    isSelectedItem = YES;
    [self initChooseBTtnArray];
    [self initFilterchooseView];
//    [self FilterChooseBtn];
 }

-(void)LLDrawAlpha{
//    backgroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.
//                                                                         bounds.size.height*0.25,
//                                                                         self.bounds.size.width,
//                                                                         self.bounds.size.height*0.75)];
//    backgroundScrollView.backgroundColor = [UIColor clearColor];
//    backgroundScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
//    backgroundScrollView.delegate = self;
//    backgroundScrollView.contentSize = CGSizeMake(self.bounds.size.width *1.2, 0);
//        backgroundScrollView.scrollEnabled = YES;
//    backgroundScrollView.showsHorizontalScrollIndicator = NO;
//    [self addSubview:backgroundScrollView];
    
    
//    [scrollView setCanCancelContentTouches:NO];

//    scrollView.clipsToBounds  = YES;// 意思
//    scrollView.pagingEnabled  = YES;
}
-(void)initChooseBTtnArray{
    _LLNameFilterArray = [NSMutableArray array];
    NSMutableArray *temp = [[NSMutableArray alloc]initWithObjects:
                            @"默认",
                            @"樱花雨",
                            @"未知",
                            @"未知",nil];
    [_LLNameFilterArray addObjectsFromArray:temp];
    
    LLFilterImageNameArray = [NSMutableArray array];
    NSMutableArray *tempchosenArray = [[NSMutableArray alloc]initWithObjects:
                            @"default",
                            @"snow",
                            @"desert_lock",
                            @"desert_lock",nil];
    [LLFilterImageNameArray addObjectsFromArray:tempchosenArray];
}

//-(void)FilterChooseBtn{
//
//    for (int i = 0 ;i <_LLNameFilterArray.count; i++) {
//        
//        int PositionX  = i * self.bounds.size.width*0.28 + self.bounds.size.width*0.0373;
//        
//        _LLChoseViewBtn = [[UIButton alloc]init];
//        _LLChoseViewBtn.frame = CGRectMake(PositionX,
//                                           5,
//                                           self.bounds.size.width*0.213,
//                                           self.bounds.size.width*0.27);
////        [_LLChoseViewBtn setTitle: _LLNameFilterArray[i] forState:UIControlStateNormal];
//        _LLChoseViewBtn.tag = i;
//        _LLChoseViewBtn.backgroundColor = [UIColor clearColor];
//        UIImageView *btnBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
//                                                                               self.bounds.size.width*0.213,
//                                                                               self.bounds.size.width*0.27)];
//        btnBackImg.image = [UIImage imageNamed:[LLFilterImageNameArray objectAtIndex:i]];
//        [_LLChoseViewBtn addSubview:btnBackImg];
//        [backgroundScrollView addSubview:_LLChoseViewBtn];
//        if (i==0) {
//            UIImageView *chose = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chosen"]];
//            chose.frame = CGRectMake(btnBackImg.bounds.size.height/5, btnBackImg.bounds.size.height/3, btnBackImg.bounds.size.width/2, btnBackImg.bounds.size.width/2);
//            [btnBackImg addSubview:chose];
//        }
//        UILabel *FilterNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(PositionX,
//                                                                            self.bounds.size.width*0.28,
//                                                                            self.bounds.size.width*0.213, 30)];
//        FilterNameLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
//        FilterNameLabel.text = [_LLNameFilterArray objectAtIndex:i];
//        FilterNameLabel.font = [UIFont systemFontOfSize:15];
//        FilterNameLabel.textAlignment = NSTextAlignmentCenter;
//        //        FilterNameLabel.adjustsFontSizeToFitWidth = YES;
//        
//        [backgroundScrollView addSubview:FilterNameLabel];
//    }
//    // 每一个滤镜btn的x位置
//    int PositionX;
//    for (int i = 0; i<_LLNameFilterArray.count; i++) {
//        PositionX  = i * self.bounds.size.width*0.28 + self.bounds.size.width*0.0373;
//    }
//    
////    UIButton *filter1 = [UIButton alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//
//}

# pragma mark- 滤镜选择初始化
-(void)initFilterchooseView{
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    //layout.itemSize = CGSizeMake(100, 100);
    // 设置最小行间距
    layout.minimumLineSpacing = self.bounds.size.width*0.07;
    // 设置垂直间距
    //    layout.minimumInteritemSpacing = 10;
    // 设置滚动方向（默认垂直滚动）
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    
    LLchooseCollectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height*0.25,
                                                                            self.bounds.size.width,
                                                                            self.bounds.size.height*0.75)collectionViewLayout:layout];
    LLchooseCollectView.userInteractionEnabled = YES;
    LLchooseCollectView.backgroundColor = [UIColor clearColor];
    LLchooseCollectView.delegate = self;
    LLchooseCollectView.dataSource = self;
    LLchooseCollectView.alwaysBounceHorizontal = YES;
    LLchooseCollectView.showsHorizontalScrollIndicator = NO;
    
    LLchooseCollectView.contentOffset = CGPointMake(0, 0);
    // 通过xib注册
    [LLchooseCollectView registerClass:[LLChooseViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self addSubview: LLchooseCollectView];
}

# pragma mark- 滤镜选择页面代理方法

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.bounds.size.width*0.22,self.bounds.size.width*0.30);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return LLFilterImageNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    LLChooseViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.FilterNameLabel.text = [_LLNameFilterArray objectAtIndex:indexPath.row];
    cell.LLchoseFilterimg.image = [UIImage imageNamed:[LLFilterImageNameArray objectAtIndex:indexPath.row]];
    cell.userInteractionEnabled = YES;
    
    if (indexPath.item == SelectedIndex.item && SelectedIndex != nil) {
        //如果是展开
        if (isSelectedItem == YES) {
            cell.ChooseCellSelectImage.hidden = NO;
        }else{
            cell.ChooseCellSelectImage.hidden = YES;
        }
        //不是自身
    } else {
        cell.ChooseCellSelectImage.hidden = YES;
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"chooseView点击%zd", indexPath.item);
        if ([self.chooseViewdelegate respondsToSelector:@selector(changeBgScene:)]){
            switch (indexPath.item) {
                case 0:
                    [self.chooseViewdelegate changeBgScene:@"filter1"];
                    break;
                case 1:
                    [self.chooseViewdelegate changeBgScene:@"樱花雨"];
                    break;
                default:
                    break;
            }
        }
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    //判断选中不同row状态时候
    if (SelectedIndex != nil && indexPath.item == SelectedIndex.item) {
        //将选中的和所有索引都加进数组
//        indexPaths = [NSArray arrayWithObjects:indexPath,SelectedIndex, nil];
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
    [LLchooseCollectView reloadItemsAtIndexPaths:indexPaths];

}


@end
