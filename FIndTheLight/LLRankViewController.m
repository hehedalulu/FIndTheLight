//
//  LLRankViewController.m
//  FIndTheLight
//
//  Created by Wll on 17/1/21.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLRankViewController.h"
#import "MJRefresh.h"

@interface LLRankViewController (){
    UITableView *lltableView;
    NSMutableArray *LLusernameArray;
}

@end

@implementation LLRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:56.0/255.0 blue:87.0/255.0 alpha:1];
    UILabel *pagename = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.36, [UIScreen mainScreen].bounds.size.width*0.15)];
    pagename.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    pagename.text = @".排行榜";
    pagename.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [self.view addSubview:pagename];
    
    UIButton *dismissBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.025, [UIScreen mainScreen].bounds.size.width*0.15, [UIScreen mainScreen].bounds.size.width*0.1, [UIScreen mainScreen].bounds.size.width*0.1)];
    [dismissBtn setImage:[UIImage imageNamed:@"chacha.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    [self initTitleUI];
    
    lltableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 180, self.view.bounds.size.width, 550)];
    lltableView.delegate = self;
    lltableView.dataSource = self;
    lltableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lltableView];
    [self initArrayData];
    __unsafe_unretained __typeof(self) weakSelf = self;
    lltableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}
-(void)initArrayData{
    LLusernameArray = [[NSMutableArray alloc]initWithObjects:@"黑童话小说家",@"美丽的画家",@"黑童话小说家",@"美丽的画家",@"黑童话小说家",@"美丽的画家",@"黑童话小说家",@"美丽的画家",@"黑童话小说家",@"美丽的画家",nil];
}

-(void)loadMoreData{
     NSMutableArray *tempArray = [[NSMutableArray alloc]initWithObjects:@"黑童话小说家",@"美丽的画家",@"黑童话小说家",@"美丽的画家",@"黑童话小说家",@"美丽的画家",@"黑童话小说家",@"美丽的画家",@"黑童话小说家",@"美丽的画家",nil];
    [LLusernameArray addObjectsFromArray:tempArray];
    
    [lltableView reloadData];
    [lltableView.mj_footer endRefreshing];
    
}
-(void)initTitleUI{
    UILabel *TotalgamerLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 130, 180, 30)];
    int totalCount = 100;
    TotalgamerLabel.text = [NSString stringWithFormat:@"全校榜  共%d人",totalCount];
    TotalgamerLabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:20];
    TotalgamerLabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [self.view addSubview:TotalgamerLabel];
    
    UIImageView *myicon = [[UIImageView alloc]initWithFrame:CGRectMake(355, 120, 50, 50)];
    [myicon.layer setMasksToBounds:YES];
    [myicon.layer setCornerRadius:25];
    myicon.image = [UIImage imageNamed:@"WechatIMG5.jpeg"];
    //myicon.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:38.0/255.0 blue:59.0/255.0 alpha:1];
    [self.view addSubview:myicon];
    
    UILabel *myrank = [[UILabel alloc]initWithFrame:CGRectMake(280, 130, 75, 30)];
    myrank.text = @"第 1 名";
    myrank.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:20];
    myrank.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [self.view addSubview:myrank];
}

-(void)dismissView{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.view = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView代理协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return LLusernameArray.count;
    
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id1"];
    
 
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id1"];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        UIImageView *cellbackgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 80)];
        cellbackgroundView.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:38.0/255.0 blue:59.0/255.0 alpha:1];
        [cell addSubview:cellbackgroundView];
        
        UILabel *ranklabel = [[UILabel alloc]initWithFrame:CGRectMake(20, cellbackgroundView.bounds.size.height/2-20, 40, 40)];
        ranklabel.text = [NSString stringWithFormat:@"%ld",indexPath.section+1];
        ranklabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:20];
        ranklabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
        [cellbackgroundView addSubview:ranklabel];
        
        UILabel *userNickName = [[UILabel alloc]initWithFrame:CGRectMake(135, cellbackgroundView.bounds.size.height/2-20, 150, 40)];
        userNickName.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:20];
        userNickName.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
        userNickName.text = [LLusernameArray objectAtIndex:indexPath.section];
    
        UIImageView *usericon = [[UIImageView alloc]initWithFrame:CGRectMake(60, 10, 60, 60)];
        int judge = indexPath.section%2;
        if (judge == 0 ) {
            usericon.image = [UIImage imageNamed:@"liuliu.JPG"];
        }else{
            usericon.image = [UIImage imageNamed:@"boluo.JPG"];
        }
        
        [usericon.layer setMasksToBounds:YES];
        [usericon.layer setCornerRadius:30];
        [cellbackgroundView addSubview:usericon];
        [cellbackgroundView addSubview:userNickName];
        
    UILabel *userLight = [[UILabel alloc]initWithFrame:CGRectMake(300, cellbackgroundView.bounds.size.height/2-20, 100, 40)];
    userLight.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:20];
    userLight.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    long userLightValue = 1000-indexPath.section*100;
    userLight.text =[NSString stringWithFormat:@"%ld",userLightValue];
    [cell addSubview:userLight];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中效果
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
