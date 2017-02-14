//
//  LLMixFilterViewController.m
//  FIndTheLight
//
//  Created by Wll on 17/1/21.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLMixFilterViewController.h"

@interface LLMixFilterViewController (){
    UITableView *llfilterTableView;
    BOOL isOpen;
    NSIndexPath * selectedIndex;
    
}

@end

@implementation LLMixFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:56.0/255.0 blue:87.0/255.0 alpha:1];
    UILabel *pagename = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.12, [UIScreen mainScreen].bounds.size.width*0.36, [UIScreen mainScreen].bounds.size.width*0.15)];
    pagename.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    pagename.text = @".滤镜合成";
    pagename.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    [self.view addSubview:pagename];
    
    UIButton *dismissBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.025, [UIScreen mainScreen].bounds.size.width*0.15, [UIScreen mainScreen].bounds.size.width*0.1, [UIScreen mainScreen].bounds.size.width*0.1)];
    [dismissBtn setImage:[UIImage imageNamed:@"chacha.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    llfilterTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 116, self.view.bounds.size.width, 620)];
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
    
    return 10;
    
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == selectedIndex.section && selectedIndex != nil ) {
        if (isOpen == YES) {
            
            CGFloat f = 10;
            
            if (indexPath.section == 9){
                
                return 183.8+(f - 21);
            }
            
            return 185+(f - 21);
            
        }else{
            return 100;
        }
    }
    return 100;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id1"];
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    

    
    UIImageView *cellbackgroundView = [[UIImageView alloc]init];
    cellbackgroundView.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:38.0/255.0 blue:59.0/255.0 alpha:1];
    cellbackgroundView.frame = CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 100);
    if (indexPath.section == selectedIndex.section && selectedIndex != nil) {
        //如果是展开
        if (isOpen == YES) {
            cellbackgroundView.frame = CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 175);
            NSLog(@"new cell");
        }else{
            cellbackgroundView.frame = CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-20, 100);
            //收起
            NSLog(@"old cell");
        }
        
        //不是自身
    } else {
    }
    
    [cell addSubview:cellbackgroundView];
    
    UILabel *filterNamelabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10 , 180, 40)];
    filterNamelabel.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:15];
    filterNamelabel.textColor = [UIColor colorWithRed:254.0/255.0 green:239.0/255.0 blue:189.0/255.0 alpha:1];
    filterNamelabel.text = @"lulu起义成功打倒PM节";
    [cellbackgroundView addSubview:filterNamelabel];
    
    UIImageView *usericon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 80, 80)];
    usericon.image = [UIImage imageNamed:@"liuliu.JPG"];
    [usericon.layer setMasksToBounds:YES];
    [usericon.layer setCornerRadius:40];
    [cellbackgroundView addSubview:usericon];
    
    
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
