//
//  LLMixFilterViewController.m
//  FIndTheLight
//
//  Created by Wll on 17/1/21.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLMixFilterViewController.h"
#import "LLMixTableViewCell.h"
@interface LLMixFilterViewController (){
    UITableView *llfilterTableView;
    BOOL isOpen;
    NSIndexPath * selectedIndex;
    
}

@end

@implementation LLMixFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        if (isOpen == YES) {
            
//            CGFloat f = 10;
            
            if (indexPath.section == 9){
                
//                return 183.8+(f - 21);
                return [UIScreen mainScreen].bounds.size.width*0.3815;
            }
            
//            return 185+(f - 21);
            return [UIScreen mainScreen].bounds.size.width*0.3815;
            
        }else{
            return [UIScreen mainScreen].bounds.size.width*0.218;
        }
    }
    return  [UIScreen mainScreen].bounds.size.width*0.218;
    
}
- (LLMixTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLMixTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id1"];
    
    
    cell = [[LLMixTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id1"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = NO;
    //init每一行滤镜的模型
    filtermodel = [[LLFilterModel alloc]init];
    switch (indexPath.section) {
        case 0:{
            filtermodel.LLFilterModelName = @"开学季";
            break;
        }
        case 1:{
            filtermodel.LLFilterModelName = @"测试滤镜1";
            break;
        }
        case 2:{
            filtermodel.LLFilterModelName = @"未知滤镜";
            break;
        }
        case 3:{
            filtermodel.LLFilterModelName = @"未知滤镜";
            break;
        }
        case 4:{
            filtermodel.LLFilterModelName = @"未知滤镜";
            break;
        }
        default:
            break;
    }
    [filtermodel setModelContent];
    
    cell.LLMixFilterName.text = filtermodel.LLFilterModelName;
    //碎片1
    if (filtermodel.suiPian1.SuiPianHasShow == NO) {
        cell.LLMixSuiPianImage1.image = [UIImage imageNamed:@"notfound.png"];
    }else{
        cell.LLMixSuiPianImage1.image = [UIImage imageNamed:@"icon_rank.png"];
    }
    cell.LLMixSuiPianLabel1.text = filtermodel.suiPian1.LLFilterSuiPianName;
    
    //碎片2
    if (filtermodel.suiPian2.SuiPianHasShow == NO) {
        cell.LLMixSuiPianImage2.image = [UIImage imageNamed:@"notfound.png"];
    }else{
        cell.LLMixSuiPianImage2.image = [UIImage imageNamed:@"icon_flower.png"];
    }
    cell.LLMixSuiPianLabel2.text = filtermodel.suiPian2.LLFilterSuiPianName;
    
    //碎片3
    if (filtermodel.suiPian3.SuiPianHasShow == NO) {
        cell.LLMixSuiPianImage3.image = [UIImage imageNamed:@"notfound.png"];
    }else{
        cell.LLMixSuiPianImage3.image = [UIImage imageNamed:@"icon_glass.png"];
    }
    cell.LLMixSuiPianLabel3.text = filtermodel.suiPian3.LLFilterSuiPianName;
    
    if (indexPath.section == selectedIndex.section && selectedIndex != nil) {
        //如果是展开
        if (isOpen == YES) {
            cell.LLMixCellBgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.width*0.3815);
            [cell removeView];
            cell.SuiPianProgress1 = filtermodel.LLMixSuiPianHad1;
            cell.SuiPianNeedProg1 = filtermodel.LLMixSuiPianNeed1;
            cell.SuiPianStoreCount1 = filtermodel.suiPian1.LLSuiPianTotalCount;
            cell.SuiPianProgress2 = filtermodel.LLMixSuiPianHad2;
            cell.SuiPianNeedProg2 = filtermodel.LLMixSuiPianNeed2;
            cell.SuiPianStoreCount2 = filtermodel.suiPian2.LLSuiPianTotalCount;
            cell.SuiPianProgress3 = filtermodel.LLMixSuiPianHad3;
            cell.SuiPianNeedProg3 = filtermodel.LLMixSuiPianNeed3;
            cell.SuiPianStoreCount3 = filtermodel.suiPian3.LLSuiPianTotalCount;
            
            [cell initNewView];
            cell.LLMixFilterName.text = filtermodel.LLFilterModelName;
            //碎片1
            if (filtermodel.suiPian1.SuiPianHasShow == NO) {
                cell.LLMixSuiPianImage1.image = [UIImage imageNamed:@"notfound.png"];
            }else{
                cell.LLMixSuiPianImage1.image = [UIImage imageNamed:@"icon_rank.png"];
            }
            cell.LLMixSuiPianLabel1.text = filtermodel.suiPian1.LLFilterSuiPianName;

            
            
            //碎片2
            if (filtermodel.suiPian2.SuiPianHasShow == NO) {
                cell.LLMixSuiPianImage2.image = [UIImage imageNamed:@"notfound.png"];
            }else{
                cell.LLMixSuiPianImage2.image = [UIImage imageNamed:@"icon_flower.png"];
            }
            cell.LLMixSuiPianLabel2.text = filtermodel.suiPian2.LLFilterSuiPianName;

            
            //碎片3
            if (filtermodel.suiPian3.SuiPianHasShow == NO) {
                cell.LLMixSuiPianImage3.image = [UIImage imageNamed:@"notfound.png"];
            }else{
                cell.LLMixSuiPianImage3.image = [UIImage imageNamed:@"icon_glass.png"];
            }
            cell.LLMixSuiPianLabel3.text = filtermodel.suiPian3.LLFilterSuiPianName;

            
            
            NSLog(@"第二个碎片%d 需要%d",filtermodel.LLMixSuiPianHad2,filtermodel.LLMixSuiPianNeed2);
            
            NSLog(@"new cell");
        }else{
            cell.LLMixCellBgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.218);
            //收起
            NSLog(@"old cell");
        }
        
        //不是自身
    } else {
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
    //刷新
    [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}


@end
