//
//  LLPunchViewController.m
//  FIndTheLight
//
//  Created by Wll on 17/1/21.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLPunchViewController.h"
#import "LLPunchStepsCollectionViewCell.h"
#import "XZMRefresh.h"

@interface LLPunchViewController (){
    UICollectionView *LLStepsView;
    NSMutableArray *LLWeekArray;
    NSMutableArray *LLDayArray;
    //NSMutableArray *LLStepsArray;
}

@end

@implementation LLPunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.view.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:56.0/255.0 blue:87.0/255.0 alpha:1];
    [self drawStepView];
    UILabel *pagename = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.36, [UIScreen mainScreen].bounds.size.width*0.15)];
    pagename.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    pagename.text = @".能量记录";
    pagename.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [self.view addSubview:pagename];
    
    UIButton *dismissBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.025, [UIScreen mainScreen].bounds.size.width*0.15, [UIScreen mainScreen].bounds.size.width*0.1, [UIScreen mainScreen].bounds.size.width*0.1)];
    [dismissBtn setImage:[UIImage imageNamed:@"chacha.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
  //layout.itemSize = CGSizeMake(100, 100);
    // 设置最小行间距
    layout.minimumLineSpacing = 5;
    // 设置垂直间距
//    layout.minimumInteritemSpacing = 10;
    // 设置滚动方向（默认垂直滚动）
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    // 设置边缘的间距，默认是{0，0，0，0}
 //   layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    LLStepsView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 140, 414, 100) collectionViewLayout:layout];
    LLStepsView.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:114.0/255.0 blue:188.0/255.0 alpha:1];
    LLStepsView.delegate = self;
    LLStepsView.dataSource = self;
    LLStepsView.alwaysBounceHorizontal = YES;
    LLStepsView.showsHorizontalScrollIndicator = NO;
    // 通过xib注册
    [LLStepsView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview: LLStepsView];
    [self initCalendarStepsArray];
    [self RightPinchreload];

    
}



-(void)drawStepView{
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(10, 270, self.view.bounds.size.width-20, 350)];
    backgroundView.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:38.0/255.0 blue:59.0/255.0 alpha:1];
    [self.view addSubview:backgroundView];
    
    UILabel *todaylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, backgroundView.bounds.size.width, 30)];
    todaylabel.textAlignment = NSTextAlignmentCenter;
    todaylabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    todaylabel.text = @"2017/1/10";
    todaylabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [backgroundView addSubview:todaylabel];
    
    UIImageView *outsidecircle = [[UIImageView alloc]initWithFrame:CGRectMake(backgroundView.bounds.size.width/2-60, backgroundView.bounds.size.height/2-85, 120, 120)];
    outsidecircle.backgroundColor = [UIColor colorWithRed:35.0/255.0 green:69.0/255.0 blue:189.0/255.0 alpha:1];
    [outsidecircle.layer setMasksToBounds:YES];
    [outsidecircle.layer setCornerRadius:60];
    [backgroundView addSubview:outsidecircle];
    
    UIImageView *insidecircle = [[UIImageView alloc]initWithFrame:CGRectMake(backgroundView.bounds.size.width/2-40, backgroundView.bounds.size.height/2-65, 80, 80)];
    insidecircle.backgroundColor = [UIColor colorWithRed:83.0/255.0 green:95.0/255.0 blue:231.0/255.0 alpha:1];
    [insidecircle.layer setMasksToBounds:YES];
    [insidecircle.layer setCornerRadius:40];
    [backgroundView addSubview: insidecircle];
    
    UILabel *step = [[UILabel alloc]initWithFrame:CGRectMake(0, insidecircle.bounds.size.height/2-20, insidecircle.bounds.size.width, 40)];
    step.textAlignment = NSTextAlignmentCenter;
    step.text = @"2000";
    step.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    step.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [insidecircle addSubview:step];
    
    UILabel *sufixlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, insidecircle.bounds.size.height/2+17, insidecircle.bounds.size.width, 20)];
    sufixlabel.textAlignment = NSTextAlignmentCenter;
    sufixlabel.text = @"步";
    sufixlabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    sufixlabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [insidecircle addSubview:sufixlabel];
    
    
    UILabel *category1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 250, 60, 20)];
    category1.textAlignment = NSTextAlignmentRight;
    category1.text = @"图书馆";
    category1.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    category1.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [backgroundView addSubview:category1];
    
    UILabel *category2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 280, 60, 20)];
    category2.textAlignment = NSTextAlignmentRight;
    category2.text = @"食堂";
    category2.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    category2.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [backgroundView addSubview:category2];
    
    UILabel *category3 = [[UILabel alloc]initWithFrame:CGRectMake(50, 310, 60, 20)];
    category3.textAlignment = NSTextAlignmentRight;
    category3.text = @"教学楼";
    category3.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    category3.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [backgroundView addSubview:category3];
  
    for (int j=0; j<3; j++) {
        int HeightY = j*30;
        for (int i=0; i<10; i++) {
            int widthX = i*18;
            UIImageView *unpunchcard = [[UIImageView alloc]initWithFrame:CGRectMake(125+widthX, 250+HeightY, 35, 20)];
            unpunchcard.image = [UIImage imageNamed:@"bluecard.png"];
            [backgroundView addSubview:unpunchcard];
        }
    }
    

    for (int i=0; i<3; i++) {
            int widthX = i*18;
            UIImageView *unpunchcard = [[UIImageView alloc]initWithFrame:CGRectMake(125+widthX, 250, 35, 20)];
            unpunchcard.image = [UIImage imageNamed:@"greencard.png"];
            [backgroundView addSubview:unpunchcard];
    }
    
    for (int i=0; i<8; i++) {
        int widthX = i*18;
        UIImageView *unpunchcard = [[UIImageView alloc]initWithFrame:CGRectMake(125+widthX, 280, 35, 20)];
        unpunchcard.image = [UIImage imageNamed:@"greencard.png"];
        [backgroundView addSubview:unpunchcard];
    }
    
    for (int i=0; i<5; i++) {
        int widthX = i*18;
        UIImageView *unpunchcard = [[UIImageView alloc]initWithFrame:CGRectMake(125+widthX, 310, 35, 20)];
        unpunchcard.image = [UIImage imageNamed:@"greencard.png"];
        [backgroundView addSubview:unpunchcard];
    }

    
    UIView *bezierbackView = [[UIView alloc]initWithFrame:CGRectMake(backgroundView.bounds.size.width/2-80, backgroundView.bounds.size.height/2-105, 160, 160)];
    bezierbackView.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:bezierbackView];
    
//    [[UIColor redColor] setStroke]; // stroke 画线的意思，也就是画笔的笔头颜色
    
    //2.使用UIBezierPath 的类方法绘制圆弧，中心我们选择当前窗口的中心
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(bezierbackView.bounds.size.width/2, bezierbackView.bounds.size.height/2) radius:70 startAngle:M_PI*(-90)/180.0f endAngle:M_PI*(200)/180.0f clockwise:YES];
    CAShapeLayer * _progressLayer = [CAShapeLayer layer];
    //指定frame 大小
    _progressLayer.frame = bezierbackView.bounds;
    //fillColor  图层填充颜色
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    //线条颜色
    _progressLayer.strokeColor=[UIColor redColor].CGColor;

    _progressLayer.lineCap = kCALineCapRound;
    // 指定线条宽度
    _progressLayer.lineWidth = 15;
    //到这里我们的弧线已经制作完成
    [bezierbackView.layer addSublayer:_progressLayer];
    
    //遮罩涂层
    //CALayer * grain = [CALayer layer];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bezierbackView.bounds;
//    [bezierbackView.layer addSublayer:gradientLayer];
    
    //set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:50.0/255.0 green:87.0/255.0 blue:246.0/255.0 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:110.0/255.0 green:106.0/255.0 blue:247.0/255.0 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:44.0/255.0 green:187.0/255.0 blue:220.0/255.0 alpha:1].CGColor];
    
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
    pathAnimation.repeatCount = 1;
    _progressLayer.path=path.CGPath;
    
    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

-(void)dismissView{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark <UICollectionViewDataSource> 日历数据源

- (void)RightPinchreload
{
    [LLStepsView xzm_addNormalHeaderWithTarget:self action:@selector(reloadNewData)];
    LLStepsView.xzm_header.updatedTimeHidden = YES;
    [LLStepsView.xzm_header setTitle:@"" forState:XZMRefreshStateNormal];
    [LLStepsView.xzm_header setTitle:@"" forState:XZMRefreshStatePulling];
    [LLStepsView.xzm_header setTitle:@"" forState:XZMRefreshStateRefreshing];
}

-(void)initCalendarStepsArray{
    NSArray *tempArray = [[NSArray alloc]initWithObjects:@"周日",@"周日",@"周日",@"周日",@"周日",@"周日",@"周日", nil];
    LLWeekArray = [[NSMutableArray alloc]initWithArray:tempArray];
    LLDayArray = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
}

-(void)reloadNewData{
    NSMutableArray *tempWeekArray = [[NSMutableArray alloc]initWithObjects:@"周日",@"周日",@"周日",@"周日",@"周日",@"周日",@"周日", nil];
    NSMutableArray *tempDayArray = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
    
    [LLWeekArray addObjectsFromArray:tempWeekArray];
    [LLDayArray addObjectsFromArray:tempDayArray];
    
//    LLWeekArray = [[NSMutableArray alloc]initWithArray:tempWeekArray];
  //  LLDayArray = [[NSMutableArray alloc]initWithArray:tempDayArray];
    //[LLWeekArray addObjectsFromArray:tempWeekArray];
    //[LLDayArray addObjectsFromArray:tempDayArray];
    //NSLog(@"日数组%@",LLDayArray);
    [LLStepsView reloadData];
    [LLStepsView.xzm_header endRefreshing];

}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 100);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return LLWeekArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    LLPunchStepsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:38.0/255.0 blue:59.0/255.0 alpha:1];
    
    
    UILabel *weekdayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, cell.bounds.size.width, cell.bounds.size.height/3)];
    weekdayLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    weekdayLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    weekdayLabel.textAlignment = NSTextAlignmentCenter;
//    NSMutableArray *temparray =[[NSMutableArray alloc]initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六",nil];
    weekdayLabel.text = [LLWeekArray objectAtIndex:indexPath.item];
    [cell addSubview:weekdayLabel];
    
    UILabel *daylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.bounds.size.height/3, cell.bounds.size.width, cell.bounds.size.height/3)];
    daylabel.textAlignment = NSTextAlignmentCenter;
    daylabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
//    daylabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    daylabel.text = [LLDayArray objectAtIndex:indexPath.item];
    daylabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [cell addSubview:daylabel];
    
    UILabel *steplabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.bounds.size.height*2/3, cell.bounds.size.width, cell.bounds.size.height/3)];
    steplabel.textAlignment = NSTextAlignmentCenter;
    steplabel.text = @"2000步";
    steplabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    steplabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [cell addSubview:steplabel];
    
    
    return cell;
}
/*
#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------%zd", indexPath.item);
}
*/
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
