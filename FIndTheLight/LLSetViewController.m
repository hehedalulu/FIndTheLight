//
//  LLSetViewController.m
//  FIndTheLight
//
//  Created by Wll on 17/2/11.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLSetViewController.h"
#import "LLCustomeSwitch.h"
#import <BmobSDK/Bmob.h>

@interface LLSetViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
{
    UITableView *setTableview;
}

@end

@implementation LLSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.view.backgroundColor = [UIColor colorWithRed:23.0/255.0 green:27.0/255.0 blue:47.0/255.0 alpha:1];
    
    
    UILabel *pagename = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.12,
                                                                 [UIScreen mainScreen].bounds.size.width*0.05,
                                                                 [UIScreen mainScreen].bounds.size.width*0.36,
                                                                 [UIScreen mainScreen].bounds.size.width*0.15)];
    pagename.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:25];
    pagename.text = @".个人中心";
    pagename.textColor = [UIColor colorWithRed:214.0/255.0 green:208.0/255.0 blue:242.0/255.0 alpha:1];
    [self.view addSubview:pagename];
    
    UIButton *dismissBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.025,
                                                                     [UIScreen mainScreen].bounds.size.width*0.08,
                                                                     [UIScreen mainScreen].bounds.size.width*0.1,
                                                                     [UIScreen mainScreen].bounds.size.width*0.1)];
    [dismissBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    
    
    setTableview = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                [UIScreen mainScreen].bounds.size.width*0.4106,
                                                                [UIScreen mainScreen].bounds.size.width,
                                                                [UIScreen mainScreen].bounds.size.height-
                                                                [UIScreen mainScreen].bounds.size.width*0.4106)];
    setTableview.delegate = self;
    setTableview.dataSource = self;
    setTableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:setTableview];
    

    
    SelfButton = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.3856,
                                                           [UIScreen mainScreen].bounds.size.width*0.19,
                                                           [UIScreen mainScreen].bounds.size.width*0.2289,
                                                           [UIScreen mainScreen].bounds.size.width*0.2289)];
    [SelfButton setBackgroundImage:[UIImage imageNamed:@"default-photo.png"] forState:UIControlStateNormal];
    [SelfButton.layer setCornerRadius:[UIScreen mainScreen].bounds.size.width*0.2289/2];
    [SelfButton.layer setMasksToBounds:YES];
    [SelfButton addTarget:self action:@selector(Changeicon) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SelfButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissView{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - UITableView代理协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 3;
    if (section == 1) {
        return 2;
    }
    if (section == 2) {
        return 3;
    }
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
    
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.03814,
                                                                   [UIScreen mainScreen].bounds.size.width*0.02814,
                                                                   [UIScreen mainScreen].bounds.size.width*0.5,
                                                                   [UIScreen mainScreen].bounds.size.width*0.03814)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    if (section == 0 ) {
        titleLabel.text = @"个人信息";
    }else if (section == 1){
        titleLabel.text = @"系统设置";
    }else{
        titleLabel.text = @"关于我们";
    }
    [view addSubview:titleLabel];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return  [UIScreen mainScreen].bounds.size.width*0.092;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [UIScreen mainScreen].bounds.size.width*0.12;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id1"];
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = NO;
    
    UIImageView *cellbackgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,
                                                                                   [UIScreen mainScreen].bounds.size.width,
                                                                                   [UIScreen mainScreen].bounds.size.width*0.11)];
//    cellbackgroundView.backgroundColor = [UIColor colorWithRed:17.0/255.0 green:38.0/255.0 blue:59.0/255.0 alpha:1];
    cellbackgroundView.image = [UIImage imageNamed:@"center_info_layer.png"];
    [cell addSubview:cellbackgroundView];
    
    UILabel *userLight = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.07,
                                                                  cellbackgroundView.bounds.size.height/2 -
                                                                  [UIScreen mainScreen].bounds.size.width*0.0483,
                                                                  [UIScreen mainScreen].bounds.size.width*0.3623,
                                                                  [UIScreen mainScreen].bounds.size.width*0.0966)];
    userLight.font = [UIFont systemFontOfSize:17];
    userLight.textColor = [UIColor colorWithRed:152.0/255.0 green:153.0/255.0 blue:221.0/255.0 alpha:1];
    
    UIButton *closureBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.90,
                                                                    cellbackgroundView.bounds.size.height/2 -
                                                                    [UIScreen mainScreen].bounds.size.width*0.019,
                                                                    [UIScreen mainScreen].bounds.size.width*0.022,
                                                                     [UIScreen mainScreen].bounds.size.width*0.0381)];
    [closureBtn setBackgroundImage:[UIImage imageNamed:@"center_Arrow.png"] forState:UIControlStateNormal];
    [cell addSubview:closureBtn];
//    userLight.text = @"音效";
    UILabel *nickLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5174,
                                                                  cellbackgroundView.bounds.size.height/2 -
                                                                  [UIScreen mainScreen].bounds.size.width*0.0483,
                                                                  [UIScreen mainScreen].bounds.size.width*0.3623,
                                                                  [UIScreen mainScreen].bounds.size.width*0.0966)];
    nickLabel.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    nickLabel.font = [UIFont systemFontOfSize:17];
    nickLabel.textAlignment = NSTextAlignmentRight;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                userLight.text = @"昵称";
                nickLabel.text = @"lulu";
                [cell addSubview:nickLabel];
                break;
            }
            case 1:{
                userLight.text = @"所属学校";
                nickLabel.text = @"华中科技大学";
                [cell addSubview:nickLabel];
                break;
            }
            case 2:{
                userLight.text = @"密码设置";
            }
            default:
                break;
        }
    }else if (indexPath.section == 1){
            switch (indexPath.row) {
                case 0:{
                    userLight.text = @"音效";
                    closureBtn.hidden = YES;
//                    UISwitch *SwitchSound = [[UISwitch alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.75,
//                                                                                     cellbackgroundView.bounds.size.height/2 -
//                                                                                     [UIScreen mainScreen].bounds.size.width*0.0245,
//                                                                                     [UIScreen mainScreen].bounds.size.width*0.1744,
//                                                                                      [UIScreen mainScreen].bounds.size.width*0.049)];
//                    [SwitchSound setOn:YES];
//                    [SwitchSound setOnImage:[UIImage imageNamed:@"center_button_layer.png"]];
//                    SwitchSound.tintColor = [UIColor clearColor];
                    
                    LLCustomeSwitch *SwitchSound = [[LLCustomeSwitch alloc] initWithOnImage:[UIImage imageNamed:@"center_button_on.png"] offImage:[UIImage imageNamed:@"center_button_off.png"] frame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.75,
                                                                                                                                                                                                                                                                                                           cellbackgroundView.bounds.size.height/2 -
                                                                                                                                                                                                                                                                                                           [UIScreen mainScreen].bounds.size.width*0.0245,
                                                                                                                                                                                                                                                                                                           [UIScreen mainScreen].bounds.size.width*0.1744,
                                                                                                                                                                                                                                                                                                            [UIScreen mainScreen].bounds.size.width*0.049)];
                    SwitchSound.backgroundColor = [UIColor clearColor];
//                    [SwitchSound addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
                    [cell addSubview:SwitchSound];
                    break;
                }
                case 1:{
                    userLight.text = @"每日运动目标量";
                    nickLabel.text = @"10000步";
                    [cell addSubview:nickLabel];
                }
                default:
                    break;
        }
    }else if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                userLight.text = @"新手指导";
                break;
            case 1:
                userLight.text = @"关于拾光";
                break;
            case 2:
                userLight.text = @"联系我们";
            default:
                break;
        }
    }else {
        UIButton *LogOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,
                                                                        [UIScreen mainScreen].bounds.size.width,
                                                                        [UIScreen mainScreen].bounds.size.width*0.12)];
        [LogOutBtn setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
        [LogOutBtn addTarget:self action:@selector(backtoregist) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:LogOutBtn];
        
    }
    
    [cell addSubview:userLight];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中效果
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = [UIScreen mainScreen].bounds.size.width*0.092;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else
        if(scrollView.contentOffset.y >= sectionHeaderHeight){
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 更改头像
-(void)Changeicon{
    //生成一个选择菜单 从手机相册选择图片或者是拍照
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //声明一个拍照的按钮
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //拍照
        [self chosephoto];
    }];
    [alertController addAction:photo];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //从相册选择
        [self choseAlbum];
    }];
    [alertController addAction:album];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)chosephoto{
    //判断设备是否装配相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        //设置照片来源是设备上的相机
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //设置imagepicker的代理是自己
        imagePicker.delegate = self;
        //打开相机界面
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)choseAlbum{
    UIPopoverPresentationController *popover;
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    //设置照片来源为移动设备内的相册
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    //设置显示模式popover
    imagePicker.modalPresentationStyle = UIModalPresentationPopover;
    popover = imagePicker.popoverPresentationController;
    
    //设置popover窗口与哪一个view组件有关联
    popover.sourceView = SelfButton;
    
    //以下两行处理popover的箭头位置
    popover.sourceRect = SelfButton.bounds;
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}


//把从popover上取得的照片放在imageview上
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    UIImage *newimage = [self scaleToSize:image size:CGSizeMake(100, 100)];
    //把UIImage转换成NSData再进行本地存储
    NSData *myicondata = [NSKeyedArchiver archivedDataWithRootObject:newimage];
    //将头像保存到本地的UserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:myicondata forKey:@"myicon"];
    
//    [SelfButton setImage:newimage forState:UIControlStateNormal];
    [SelfButton setBackgroundImage:newimage forState:UIControlStateNormal];
    
    //保存到系统临时沙盒中
    //转成二进制文件
    //缩略图
    NSData   *imageData = UIImagePNGRepresentation(newimage);
    //大图
    NSData   *bigimageData = UIImagePNGRepresentation(image);
    NSArray  *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    
    //现在得到path
    NSString *smallpath = [cachePath stringByAppendingPathComponent:@"smallicon.png"];//缩略图
    NSString *bigpath   = [cachePath stringByAppendingPathComponent:@"bigicon.png"];//大图
    [imageData writeToFile:smallpath atomically:NO];
    [bigimageData writeToFile:bigpath atomically:NO];
    //上传到服务器
//    BmobFile *mysmallicon = [[BmobFile alloc]initWithFilePath:smallpath];
//    BmobFile *mybigicon   = [[BmobFile alloc]initWithFilePath:bigpath];
//    BmobUser *bUser = [BmobUser getCurrentUser];
//    [mysmallicon saveInBackground:^(BOOL isSuccessful, NSError *error) {
//        if (isSuccessful) {
//            [bUser setObject:mysmallicon forKey:@"smallicon"];
//            [bUser updateInBackground];
//            NSLog(@"成功保存");
//            NSLog(@"mysmallicon url %@ ",mysmallicon.url);
//        }
//        else{
//            NSLog(@"吃屎没保存成功");
//        }
//    }];
//    [mybigicon saveInBackgroundByDataSharding:^(BOOL isSuccessful, NSError *error) {
//        if (isSuccessful) {
//            //如果成功，保存文件到userFile
//            [bUser setObject:mybigicon  forKey:@"bigicon"];
//            [bUser updateInBackground];
//            NSLog(@"我就知道我最帅连大图都能保存");
//        }else{
//            //失败，打印错误信息
//            NSLog(@"看来不我够帅大图都保存不了");
//        }
//    } ];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//压缩图片
-(UIImage *)scaleToSize:(UIImage *)aImage size:(CGSize)size{
    
    //创建context,并将其设置为正在使用的context
    UIGraphicsBeginImageContext(size);
    //绘制出图片(大小已经改变)
    [aImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //获取改变大小之后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //context出栈
    UIGraphicsEndImageContext();
    return newImage; //返回获得的图片
}

-(void)backtoregist{
    [BmobUser logout];
    [self performSegueWithIdentifier:@"backtoregist" sender:self];
}

@end
