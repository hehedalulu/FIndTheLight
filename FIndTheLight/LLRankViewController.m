//
//  LLRankViewController.m
//  FIndTheLight
//
//  Created by Wll on 17/1/21.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLRankViewController.h"
#import "MJRefresh.h"
#import "AnimationTableView.h"
@interface LLRankViewController (){
    AnimationTableView *lltableView;
    NSMutableArray *LLusernameArray;
}

@end

@implementation LLRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    showRankViewOnce = YES;
    self.view.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:27.0/255.0 blue:47.0/255.0 alpha:1];
    
    
    UILabel *pagename = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12,
                                                                 [UIScreen mainScreen].bounds.size.width*0.05,
                                                                 [UIScreen mainScreen].bounds.size.width*0.36,
                                                                 [UIScreen mainScreen].bounds.size.width*0.15)];
    pagename.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    pagename.text = @".排行榜";
    pagename.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    [self.view addSubview:pagename];
    
    UIButton *dismissBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.025,
                                                                     [UIScreen mainScreen].bounds.size.width*0.08,
                                                                     [UIScreen mainScreen].bounds.size.width*0.1,
                                                                     [UIScreen mainScreen].bounds.size.width*0.1)];
    [dismissBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    [self initTitleUI];
    
    lltableView = [[AnimationTableView alloc]initWithFrame:CGRectMake(0,
                                                               [UIScreen mainScreen].bounds.size.width*0.27,
                                                               [UIScreen mainScreen].bounds.size.width,
                                                               [UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.width*0.27)];
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
    UIImageView *PHBImage = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.0483,
                                                                         [UIScreen mainScreen].bounds.size.width*0.2126,
                                                                         [UIScreen mainScreen].bounds.size.width*0.036,
                                                                         [UIScreen mainScreen].bounds.size.width*0.036)];
    PHBImage.image = [UIImage imageNamed:@"icon-ranking.png"];
    [self.view addSubview:PHBImage];
    
    
    UILabel *TotalgamerLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.0967,
                                                                        [UIScreen mainScreen].bounds.size.width*0.2126,
                                                                        [UIScreen mainScreen].bounds.size.width*0.4348,
                                                                        [UIScreen mainScreen].bounds.size.width*0.036)];
    int totalCount = 100;
    TotalgamerLabel.text = [NSString stringWithFormat:@"全校榜  共%d人",totalCount];
    TotalgamerLabel.font = [UIFont systemFontOfSize:15];
    TotalgamerLabel.textColor = [UIColor colorWithRed:158.0/255.0 green:149.0/255.0 blue:196.0/255.0 alpha:1];
    [self.view addSubview:TotalgamerLabel];
    
    
    UIImageView *myiconBg = [[UIImageView alloc ]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.8575,
                                                                          [UIScreen mainScreen].bounds.size.width*0.157,
                                                                          [UIScreen mainScreen].bounds.size.width*0.112,
                                                                          [UIScreen mainScreen].bounds.size.width*0.112)];
    myiconBg.image = [UIImage imageNamed:@"photo_layer_big.png"];
    [self.view addSubview:myiconBg];
    
    UIImageView *myicon = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.8575,
                                                                       [UIScreen mainScreen].bounds.size.width*0.157,
                                                                       [UIScreen mainScreen].bounds.size.width*0.108,
                                                                       [UIScreen mainScreen].bounds.size.width*0.108)];
    [myicon.layer setMasksToBounds:YES];
    [myicon.layer setCornerRadius:25];
    myicon.image = [UIImage imageNamed:@"WechatIMG5.jpeg"];
    //myicon.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:38.0/255.0 blue:59.0/255.0 alpha:1];
    [self.view addSubview:myicon];
    
    UILabel *myname = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.6425,
                                                               [UIScreen mainScreen].bounds.size.width*0.1689,
                                                               [UIScreen mainScreen].bounds.size.width*0.1811,
                                                               [UIScreen mainScreen].bounds.size.width*0.036)];
    myname.text = @"lulu";
    myname.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    myname.font = [UIFont systemFontOfSize:15];
    myname.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:myname];
    
    UILabel *myrank = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.6425,
                                                               [UIScreen mainScreen].bounds.size.width*0.2126,
                                                               [UIScreen mainScreen].bounds.size.width*0.1811,
                                                               [UIScreen mainScreen].bounds.size.width*0.036)];
    myrank.text = @"第1名";
    myrank.textAlignment = NSTextAlignmentRight;
    myrank.font = [UIFont systemFontOfSize:15];
    myrank.textColor = [UIColor colorWithRed:250.0/255.0 green:162.0/255.0 blue:174.0/255.0 alpha:1];
    [self.view addSubview:myrank];
}

-(void)dismissView{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
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


//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 20;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [UIScreen mainScreen].bounds.size.width*0.175;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self.tabelView customizeCell:cell];
    //    [self.tabelView appearCell:cell andDirection:directionRight andRow:indexPath.row];
    //    [self.tabelView appearCell:cell andDirection:directionRight];
//    if (showRankViewOnce) {
//         [lltableView appearCell:cell andScale:0.1];
//        showRankViewOnce = NO;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id1"];
    
 
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id1"];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = NO;

    
        cell.backgroundColor = [UIColor clearColor];
        UIImageView *cellbackgroundView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.02416,
                                                                                       0,
                                                                                       [UIScreen mainScreen].bounds.size.width*0.9517,
                                                                                       [UIScreen mainScreen].bounds.size.width*0.15)];
        cellbackgroundView.image = [UIImage imageNamed:@"info_layer_others.png"];
        [cell addSubview:cellbackgroundView];
        
        UILabel *ranklabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.03865,
                                                                      cellbackgroundView.bounds.size.height/2-[UIScreen mainScreen].bounds.size.width*0.0483,
                                                                      [UIScreen mainScreen].bounds.size.width*0.097,
                                                                      [UIScreen mainScreen].bounds.size.width*0.097)];
        ranklabel.text = [NSString stringWithFormat:@"%ld",indexPath.section+1];
        ranklabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:20];
    
        ranklabel.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        [cellbackgroundView addSubview:ranklabel];
        
        UILabel *userNickName = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.22,
                                                                         cellbackgroundView.bounds.size.height/2-20,
                                                                         [UIScreen mainScreen].bounds.size.width*0.3623,
                                                                         [UIScreen mainScreen].bounds.size.width*0.097)];
       // userNickName.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:20];
        userNickName.font = [UIFont systemFontOfSize:19];
        userNickName.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        userNickName.text = [LLusernameArray objectAtIndex:indexPath.section];
    
    
        UIImageView *userIconBg = [[UIImageView alloc ]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.107,
                                                                                [UIScreen mainScreen].bounds.size.width*0.03,
                                                                                [UIScreen mainScreen].bounds.size.width*0.086,
                                                                                [UIScreen mainScreen].bounds.size.width*0.086)];
        userIconBg.image = [UIImage imageNamed:@"photo_layer_small.png"];
        [cellbackgroundView addSubview:userIconBg];
    
    
        UIImageView *usericon = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.11,
                                                                             [UIScreen mainScreen].bounds.size.width*0.036,
                                                                             [UIScreen mainScreen].bounds.size.width*0.08,
                                                                             [UIScreen mainScreen].bounds.size.width*0.08)];
        int judge = indexPath.section%2;
        if (judge == 0 ) {
            usericon.image = [UIImage imageNamed:@"liuliu.JPG"];
        }else{
            usericon.image = [UIImage imageNamed:@"boluo.JPG"];
        }
        
        [usericon.layer setMasksToBounds:YES];
        [usericon.layer setCornerRadius:usericon.bounds.size.width/2];
        [cellbackgroundView addSubview:usericon];
        [cellbackgroundView addSubview:userNickName];
        
    UILabel *userLight = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.7,
                                                                  cellbackgroundView.bounds.size.height/2-[UIScreen mainScreen].bounds.size.width*0.0483,
                                                                  [UIScreen mainScreen].bounds.size.width*0.2415,
                                                                  [UIScreen mainScreen].bounds.size.width*0.097)];
    userLight.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
    userLight.textAlignment = NSTextAlignmentRight;
    userLight.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    long userLightValue = 1000-indexPath.section*100;
    userLight.text =[NSString stringWithFormat:@"%ld",userLightValue];
    [cell addSubview:userLight];
    

    
    return cell;
    
}
/*
- (void)appearCell:(UITableViewCell *)cell andScale:(CGFloat)scale
{
    CATransform3D rotate = CATransform3DMakeScale( 0.0, scale, scale);
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotate;
    [UIView beginAnimations:@"scale" context:nil];
    [UIView setAnimationDuration:1.0];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}
*/
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
