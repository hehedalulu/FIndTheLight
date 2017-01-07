//
//  LLSelfInformation.m
//  FIndTheLight
//
//  Created by Wll on 16/12/30.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLSelfInformation.h"

@interface LLSelfInformation()
<UICollectionViewDelegate,UICollectionViewDataSource>{
    UICollectionView *llcollectionView;
}

@end

@implementation LLSelfInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:56.0/255.0 blue:87.0/255.0 alpha:1];
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.36, [UIScreen mainScreen].bounds.size.width*0.15)];
    name.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    name.text = @".个人中心";
    name.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [self.view addSubview:name];
    
    UIButton *dismissBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.025, [UIScreen mainScreen].bounds.size.width*0.15, [UIScreen mainScreen].bounds.size.width*0.1, [UIScreen mainScreen].bounds.size.width*0.1)];
    [dismissBtn setImage:[UIImage imageNamed:@"chacha.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    UIImageView *selflight = [[UIImageView alloc]init];
    selflight.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.025, [UIScreen mainScreen].bounds.size.width*0.36, [UIScreen mainScreen].bounds.size.width*0.1932, [UIScreen mainScreen].bounds.size.width*0.1932);
    selflight.image = [UIImage imageNamed:@"flash"];
    [self.view addSubview:selflight];
    
    NSString *nowCount = @"0";
    
    UILabel *selflightCount = [[UILabel alloc]init];
    selflightCount.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.22,[UIScreen mainScreen].bounds.size.width*0.36, [UIScreen mainScreen].bounds.size.width*0.483, [UIScreen mainScreen].bounds.size.width*0.096);
    selflightCount.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    selflightCount.text = [NSString stringWithFormat:@"现有光体数量: %@",nowCount];
    selflightCount.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:24];
    [self.view addSubview:selflightCount];
    
    llcollectionView.delegate = self;
    llcollectionView.dataSource = self;
    
    
}

-(void)dismissView{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 1.从缓存池中取
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    /*
     注意:
     UICollectioncView的cell和UITableView的cell不太一样,
     UITableView有默认的子控件
     UICollectionViewCell除了contentView以外, 没有提供默认的子控件
     设置UICollectionViewCell需要自定义 最好结合Xib使用
     */
    // 2.使用
    cell.backgroundColor = (indexPath.item % 2)?[UIColor redColor]:[UIColor greenColor];
    
    // 3.返回
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
