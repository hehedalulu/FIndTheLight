//
//  LLPunchViewController.m
//  FIndTheLight
//
//  Created by Wll on 17/1/21.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLPunchViewController.h"
#import "LLPunchStepsCollectionViewCell.h"

@interface LLPunchViewController (){
    UICollectionView *LLStepsView;
}

@end

@implementation LLPunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:56.0/255.0 blue:87.0/255.0 alpha:1];
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
//    layout.minimumLineSpacing = 20;
    // 设置垂直间距
//    layout.minimumInteritemSpacing = 0;
    // 设置滚动方向（默认垂直滚动）
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置边缘的间距，默认是{0，0，0，0}
 //   layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    LLStepsView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, 414, 100) collectionViewLayout:layout];
    LLStepsView.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:114.0/255.0 blue:188.0/255.0 alpha:1];
    LLStepsView.delegate = self;
    LLStepsView.dataSource = self;
    //LLStepsView.contentSize
    // 通过xib注册
    [LLStepsView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview: LLStepsView];
    
}



-(void)drawStepScrollView{
    //llStepScrollView = [UIScrollView alloc]initWithFrame:CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}

-(void)dismissView{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}


#pragma mark <UICollectionViewDataSource>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 100);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    LLPunchStepsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:38.0/255.0 blue:59.0/255.0 alpha:1];
    
    
    UILabel *weekdayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, cell.bounds.size.width, cell.bounds.size.height/3)];
    weekdayLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    weekdayLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    weekdayLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableArray *temparray =[[NSMutableArray alloc]initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六",nil];
    weekdayLabel.text = [NSString stringWithFormat:@"周%@",[temparray objectAtIndex:indexPath.item]];
    [cell addSubview:weekdayLabel];
    
    UILabel *daylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, cell.bounds.size.height/3, cell.bounds.size.width, cell.bounds.size.height/3)];
    daylabel.textAlignment = NSTextAlignmentCenter;
    daylabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    daylabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
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
