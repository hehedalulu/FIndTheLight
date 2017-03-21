//
//  LLMixFilterViewController.m
//  FIndTheLight
//
//  Created by Wll on 17/1/21.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLMixFilterViewController.h"
#import "LLMixTableViewCell.h"
#import "LLFilter.h"
#import "LLSuiPian.h"

@interface LLMixFilterViewController (){
    UITableView *llfilterTableView;
    BOOL isOpen;
    NSIndexPath * selectedIndex;
//    int canOpenIndex;
    NSMutableArray *canOpenArray;
    
}

@end

@implementation LLMixFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    canOpenArray  = [[NSMutableArray alloc]initWithObjects:@"NO",@"NO",@"NO",@"NO",@"NO", nil];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.view.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:27.0/255.0 blue:47.0/255.0 alpha:1];
    
    
    UILabel *pagename = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12,
                                                                 [UIScreen mainScreen].bounds.size.width*0.05,
                                                                 [UIScreen mainScreen].bounds.size.width*0.36,
                                                                 [UIScreen mainScreen].bounds.size.width*0.15)];
    pagename.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    pagename.text = @".滤镜合成";
    pagename.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    [self.view addSubview:pagename];
    
    UIButton *dismissBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.025,
                                                                     [UIScreen mainScreen].bounds.size.width*0.08,
                                                                     [UIScreen mainScreen].bounds.size.width*0.1,
                                                                     [UIScreen mainScreen].bounds.size.width*0.1)];
    [dismissBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    llfilterTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                     [UIScreen mainScreen].bounds.size.width*0.16,
                                                                     [UIScreen mainScreen].bounds.size.width,
                                                                     [UIScreen mainScreen].bounds.size.height-[UIScreen mainScreen].bounds.size.width*0.22)];
    llfilterTableView.delegate = self;
    llfilterTableView.dataSource = self;
    llfilterTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:llfilterTableView];
    isOpen = YES;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.view = nil;
}

-(void)dismissView{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
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
    
    return 5;
    
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return [UIScreen mainScreen].bounds.size.width*0.05;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == selectedIndex.section && selectedIndex != nil ) {

//        }else{
            if (isOpen == YES) {
                if(indexPath.section==2|indexPath.section==3|indexPath.section==4){
                    return [UIScreen mainScreen].bounds.size.width*0.218;
                }else{
                    if ([[canOpenArray objectAtIndex:indexPath.section] isEqualToString:@"YES"]) {
                        return [UIScreen mainScreen].bounds.size.width*0.3815;
                    }else{
                        return [UIScreen mainScreen].bounds.size.width*0.218;
                    }
                }
            }else{
                return [UIScreen mainScreen].bounds.size.width*0.218;
            }
//        }
    }
    return  [UIScreen mainScreen].bounds.size.width*0.218;
    
}
- (LLMixTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLMixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id1"];
    
    cell = [[LLMixTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id1"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = NO;
    
    RLMRealm * realm = [RLMRealm defaultRealm];
    RLMResults<LLFilter *> *tempArray = [LLFilter allObjectsInRealm:[RLMRealm defaultRealm]];
    NSMutableArray *FilterArray = [[NSMutableArray alloc]init];
    
    [realm transactionWithBlock:^{
        for (LLFilter *model  in tempArray) {
                [FilterArray addObject:model];
        }
        [realm commitWriteTransaction]; //注意  这里不能写在for循环里面 写入数据库， 要在循环改变完只好
    }];
    LLFilter *Filter = [FilterArray objectAtIndex:indexPath.section];
    
    cell.LLMixFilterName.text = Filter.LLFilterName;
    cell.LLMixIcon.image = [UIImage imageNamed:Filter.LLFilterPicName];

    if (Filter.suiPian1) {
        if (Filter.suiPian1.SuiPianHasShow) {
            cell.LLMixSuiPianLabel1.text = Filter.suiPian1.LLSuiPianName;
            cell.LLMixSuiPianImage1.image = [UIImage imageNamed:Filter.suiPian1.LLSuiPianPicName];
        }else{
            cell.LLMixSuiPianLabel1.text = @"未知";
            cell.LLMixSuiPianImage1.image = [UIImage imageNamed:@"notfound.png"];
        }
        if (Filter.suiPian2.SuiPianHasShow) {
            cell.LLMixSuiPianLabel2.text = Filter.suiPian2.LLSuiPianName;
            cell.LLMixSuiPianImage2.image = [UIImage imageNamed:Filter.suiPian2.LLSuiPianPicName];
        }else{
            cell.LLMixSuiPianLabel2.text = @"未知";
            cell.LLMixSuiPianImage2.image = [UIImage imageNamed:@"notfound.png"];
        }
        if (Filter.suiPian3.SuiPianHasShow) {
            cell.LLMixSuiPianLabel3.text = Filter.suiPian3.LLSuiPianName;
            cell.LLMixSuiPianImage3.image = [UIImage imageNamed:Filter.suiPian3.LLSuiPianPicName];
        }else{
            cell.LLMixSuiPianLabel3.text = @"未知";
            cell.LLMixSuiPianImage3.image = [UIImage imageNamed:@"notfound.png"];
        }
    }else{
        cell.LLMixSuiPianLabel1.text = @"未知";
        cell.LLMixSuiPianLabel2.text = @"未知";
        cell.LLMixSuiPianLabel3.text = @"未知";
        cell.LLMixSuiPianImage1.image = [UIImage imageNamed:@"notfound.png"];
        cell.LLMixSuiPianImage2.image = [UIImage imageNamed:@"notfound.png"];
        cell.LLMixSuiPianImage3.image = [UIImage imageNamed:@"notfound.png"];
    }
    
    if(indexPath.section==2|indexPath.section==3|indexPath.section==4){
        cell.LLMixFilterProgressImg.hidden = YES;
        cell.LLMixFilterProgress.hidden = YES;
//
    }

    
    if (indexPath.section == selectedIndex.section && selectedIndex != nil) {
//        //如果是展开
        if(indexPath.section==2|indexPath.section==3|indexPath.section==4){
//            cell.LLMixFilterProgressImg.hidden = YES;
//            cell.LLMixFilterProgress.hidden = YES;
            cell.LLMixCellBgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                 [UIScreen mainScreen].bounds.size.width*0.218);
        }else{//已经找到一个碎片且未合成可以展开
            if (Filter.LLFilterHasbeenFound&&(!(Filter.LLFilterHasBeenMixed))) {
                if (isOpen == YES) {
                    [cell removeView];
                    cell.SuiPianStoreCount1 = Filter.suiPian1.LLSuiPianCount;
                    cell.SuiPianProgress1 = Filter.LLsuiPian1Had;
                    cell.SuiPianNeedProg1 = Filter.LLsuiPian1Need;
                    cell.SuiPianStoreCount2 = Filter.suiPian2.LLSuiPianCount;
                    cell.SuiPianProgress2 = Filter.LLsuiPian2Had;
                    cell.SuiPianNeedProg2 = Filter.LLsuiPian2Need;
                    cell.SuiPianStoreCount3 = Filter.suiPian3.LLSuiPianCount;
                    cell.SuiPianProgress3 = Filter.LLsuiPian3Had;
                    cell.SuiPianNeedProg3 = Filter.LLsuiPian3Need;
                    cell.LLMixFilterProgressPercent = Filter.LLFilterProgress;
                    [cell initNewView];
                    if (Filter.suiPian1) {
                        if (Filter.suiPian1.SuiPianHasShow) {
                            cell.LLMixSuiPianLabel1.text = Filter.suiPian1.LLSuiPianName;
                            cell.LLMixSuiPianImage1.image = [UIImage imageNamed:Filter.suiPian1.LLSuiPianPicName];
                        }else{
                            cell.LLMixSuiPianLabel1.text = @"未知";
                            cell.LLMixSuiPianImage1.image = [UIImage imageNamed:@"notfound.png"];
                        }
                        if (Filter.suiPian2.SuiPianHasShow) {
                            cell.LLMixSuiPianLabel2.text = Filter.suiPian2.LLSuiPianName;
                            cell.LLMixSuiPianImage2.image = [UIImage imageNamed:Filter.suiPian2.LLSuiPianPicName];
                        }else{
                            cell.LLMixSuiPianLabel2.text = @"未知";
                            cell.LLMixSuiPianImage2.image = [UIImage imageNamed:@"notfound.png"];
                        }
                        if (Filter.suiPian3.SuiPianHasShow) {
                            cell.LLMixSuiPianLabel3.text = Filter.suiPian3.LLSuiPianName;
                            cell.LLMixSuiPianImage3.image = [UIImage imageNamed:Filter.suiPian3.LLSuiPianPicName];
                        }else{
                            cell.LLMixSuiPianLabel3.text = @"未知";
                            cell.LLMixSuiPianImage3.image = [UIImage imageNamed:@"notfound.png"];
                        }
                    }else{
                        cell.LLMixSuiPianLabel1.text = @"未知";
                        cell.LLMixSuiPianLabel2.text = @"未知";
                        cell.LLMixSuiPianLabel3.text = @"未知";
                        cell.LLMixSuiPianImage1.image = [UIImage imageNamed:@"notfound.png"];
                        cell.LLMixSuiPianImage2.image = [UIImage imageNamed:@"notfound.png"];
                        cell.LLMixSuiPianImage3.image = [UIImage imageNamed:@"notfound.png"];
                    }
                    cell.LLMixCellBgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                         [UIScreen mainScreen].bounds.size.width*0.3815);
                    NSLog(@"new cell");
                    [canOpenArray replaceObjectAtIndex:indexPath.section withObject:@"YES"];
                }else{
                    cell.LLMixCellBgV.frame = CGRectMake(0, 0,
                                                         [UIScreen mainScreen].bounds.size.width,
                                                         [UIScreen mainScreen].bounds.size.width*0.218);
                    //收起
                    NSLog(@"old cell");
                }
            }else if(!Filter.LLFilterHasbeenFound){//如果这个滤镜没有被发现过
                cell.LLMixFilterProgressImg.hidden = YES;
                cell.LLMixFilterProgress.hidden = YES;
                cell.LLMixCellBgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                     [UIScreen mainScreen].bounds.size.width*0.218);
            }else if(Filter.LLFilterHasBeenMixed){
                cell.LLMixFilterProgressImg.hidden = YES;
                cell.LLMixFilterProgress.hidden = YES;
                cell.LLMixCellBgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                     [UIScreen mainScreen].bounds.size.width*0.218);
            }
        }
    }
    if(!Filter.LLFilterHasbeenFound){//如果这个滤镜没有被发现过
        cell.LLMixFilterProgressImg.hidden = YES;
        cell.LLMixFilterProgress.hidden = YES;
        cell.LLMixCellBgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                             [UIScreen mainScreen].bounds.size.width*0.218);
    }else if(Filter.LLFilterHasBeenMixed){
        cell.LLMixFilterProgressImg.hidden = YES;
        cell.LLMixFilterProgress.hidden = YES;
        cell.LLMixSuiPianLabel1.hidden = YES;
        cell.LLMixSuiPianLabel2.hidden = YES;
        cell.LLMixSuiPianLabel3.hidden = YES;
        cell.LLMixSuiPianImage1.hidden = YES;
        cell.LLMixSuiPianImage2.hidden = YES;
        cell.LLMixSuiPianImage3.hidden = YES;
        cell.LLMixCellBgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                             [UIScreen mainScreen].bounds.size.width*0.218);
    }
    [tableView setTableHeaderView:[[UIView alloc]initWithFrame:CGRectZero]];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中效果
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    //判断选中不同row状态时候
    if (selectedIndex != nil && indexPath.section == selectedIndex.section) {
        //将选中的和所有索引都加进数组中
//        indexPaths = [NSArray arrayWithObjects:indexPath,selectedIndex, nil];
        isOpen = !isOpen;
        
    }else if (selectedIndex != nil && indexPath.section != selectedIndex.section) {
        indexPaths = [NSArray arrayWithObjects:indexPath,selectedIndex, nil];
            isOpen = YES;
    }

    //记下选中的索引
    selectedIndex = indexPath;
    NSLog(@"选中的下标%@",indexPath);
    //刷新
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}


-(void)Mixfilter{
    
}

@end
