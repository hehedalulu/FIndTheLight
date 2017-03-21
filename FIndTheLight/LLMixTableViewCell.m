//
//  LLMixTableViewCell.m
//  FIndTheLight
//
//  Created by Wll on 17/2/18.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLMixTableViewCell.h"

@implementation LLMixTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
//        filterModel = [[LLFilterModel alloc]init];
//        filterModel.LLFilterModelName = @"情人节";
//        [filterModel setModelContent];
        
//        _SuiPiancount = 0;
//            if (filterModel.suiPian1.SuiPianExist)
//                _SuiPiancount++;
//            if(filterModel.suiPian2.SuiPianExist)
//                _SuiPiancount++;
//            if(filterModel.suiPian3.SuiPianExist)
//                _SuiPiancount++;

        
        _LLMixCellBgV    = [[UIImageView alloc]init];
        _LLMixCellBgV.backgroundColor =[UIColor colorWithRed:17.0/255.0 green:38.0/255.0 blue:59.0/255.0 alpha:1];
        _LLMixCellBgV.frame = CGRectMake(0, 0,
                                         [UIScreen mainScreen].bounds.size.width,
                                         [UIScreen mainScreen].bounds.size.width*0.218);
        _LLMixCellBgV.image = [UIImage imageNamed:@"layer_small.png"];
        
        [self addSubview:_LLMixCellBgV];
        
        
        _LLMixFilterName = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.30,
                                                                    [UIScreen mainScreen].bounds.size.width*0.035,
                                                                    [UIScreen mainScreen].bounds.size.width*0.4347,
                                                                    [UIScreen mainScreen].bounds.size.width*0.0725)];
        _LLMixFilterName.font = [UIFont fontWithName:@"MF TongXin (Noncommercial)" size:18];
        _LLMixFilterName.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        _LLMixFilterName.text = @"情人节";
        [self addSubview:_LLMixFilterName];
        
        _LLMixIcon = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.055,
                                                                  [UIScreen mainScreen].bounds.size.width*0.027,
                                                                  [UIScreen mainScreen].bounds.size.width*0.18,
                                                                  [UIScreen mainScreen].bounds.size.width*0.18)];
        _LLMixIcon.image = [UIImage imageNamed:@"icon_filter.png"];
        [_LLMixIcon.layer setMasksToBounds:YES];
        [self addSubview:_LLMixIcon];
        
        //碎片1
        _LLMixSuiPianImage1 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.30,
                                                                          [UIScreen mainScreen].bounds.size.width*0.14,
                                                                          [UIScreen mainScreen].bounds.size.width*0.045,
                                                                           [UIScreen mainScreen].bounds.size.width*0.045)];
        _LLMixSuiPianImage1.image = [UIImage imageNamed:@"notfound.png"];
        [self addSubview:_LLMixSuiPianImage1];
        
        _LLMixSuiPianLabel1 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.37,
                                                                       [UIScreen mainScreen].bounds.size.width*0.14,
                                                                       [UIScreen mainScreen].bounds.size.width*0.12,
                                                                       [UIScreen mainScreen].bounds.size.width*0.045)];
        _LLMixSuiPianLabel1.text = @"钨丝";
        _LLMixSuiPianLabel1.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        _LLMixSuiPianLabel1.font = [UIFont systemFontOfSize:13];
        [self addSubview:_LLMixSuiPianLabel1];

        
        
        
        //碎片2
        
        _LLMixSuiPianImage2 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.50,
                                                                           [UIScreen mainScreen].bounds.size.width*0.14,
                                                                           [UIScreen mainScreen].bounds.size.width*0.045,
                                                                           [UIScreen mainScreen].bounds.size.width*0.045)];
        _LLMixSuiPianImage2.image = [UIImage imageNamed:@"notfound.png"];
        [self addSubview:_LLMixSuiPianImage2];
        
        _LLMixSuiPianLabel2 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.57,
                                                                       [UIScreen mainScreen].bounds.size.width*0.14,
                                                                       [UIScreen mainScreen].bounds.size.width*0.12,
                                                                       [UIScreen mainScreen].bounds.size.width*0.045)];
        _LLMixSuiPianLabel2.text = @"玻璃";
        _LLMixSuiPianLabel2.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        _LLMixSuiPianLabel2.font = [UIFont systemFontOfSize:13];
        [self addSubview:_LLMixSuiPianLabel2];
        
        
        
        //碎片3
        _LLMixSuiPianImage3 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.70,
                                                                           [UIScreen mainScreen].bounds.size.width*0.14,
                                                                           [UIScreen mainScreen].bounds.size.width*0.045,
                                                                           [UIScreen mainScreen].bounds.size.width*0.045)];
        _LLMixSuiPianImage3.image = [UIImage imageNamed:@"notfound.png"];
        [self addSubview:_LLMixSuiPianImage3];
        
        _LLMixSuiPianLabel3 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.77,
                                                                       [UIScreen mainScreen].bounds.size.width*0.14,
                                                                       [UIScreen mainScreen].bounds.size.width*0.12,
                                                                       [UIScreen mainScreen].bounds.size.width*0.045)];
        _LLMixSuiPianLabel3.text = @"花瓣";
        _LLMixSuiPianLabel3.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
        _LLMixSuiPianLabel3.font = [UIFont systemFontOfSize:13];
        [self addSubview:_LLMixSuiPianLabel3];
        
        _LLMixFilterProgressImg = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.88,
                                                                              [UIScreen mainScreen].bounds.size.width*0.018,
                                                                              [UIScreen mainScreen].bounds.size.width*0.055,
                                                                               [UIScreen mainScreen].bounds.size.width*0.055)];
        _LLMixFilterProgressImg.image = [UIImage imageNamed:@"circleprogress.png"];
        [self addSubview:_LLMixFilterProgressImg];
        [self DrawCircle];
        
        _LLMixFilterProgress = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.88,
                                                                        [UIScreen mainScreen].bounds.size.width*0.018,
                                                                        [UIScreen mainScreen].bounds.size.width*0.060,
                                                                        [UIScreen mainScreen].bounds.size.width*0.055)];
        _LLMixFilterProgress.text = [NSString stringWithFormat:@"%d％",_LLMixFilterProgressPercent];
        _LLMixFilterProgress.textAlignment = NSTextAlignmentCenter;
        _LLMixFilterProgress.textColor = [UIColor colorWithRed:194.0/255.0 green:221.0/255.0 blue:255.0/255.0 alpha:1];
        _LLMixFilterProgress.font = [UIFont systemFontOfSize:12];
        [self addSubview:_LLMixFilterProgress];
        
        
        
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)removeView{
    [_LLMixSuiPianImage1 removeFromSuperview];
    [_LLMixSuiPianLabel1 removeFromSuperview];
    [_LLMixSuiPianImage2 removeFromSuperview];
    [_LLMixSuiPianLabel2 removeFromSuperview];
    [_LLMixSuiPianImage3 removeFromSuperview];
    [_LLMixSuiPianLabel3 removeFromSuperview];
}

-(void)initNewView{
    _LLMixBtn  = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.083,
                                                           [UIScreen mainScreen].bounds.size.width*0.22,
                                                           [UIScreen mainScreen].bounds.size.width*0.1254,
                                                           [UIScreen mainScreen].bounds.size.width*0.065)];
    [_LLMixBtn setBackgroundImage:[UIImage imageNamed:@"mix_able.png"] forState:UIControlStateNormal];
    [_LLMixBtn setBackgroundImage:[UIImage imageNamed:@"mix_unable.png"] forState:UIControlStateDisabled];
    [_LLMixBtn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_LLMixBtn];

    
    //碎片1
    _LLMixSuiPianImage1 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.30,
                                                                       [UIScreen mainScreen].bounds.size.width*0.14,
                                                                       [UIScreen mainScreen].bounds.size.width*0.045,
                                                                       [UIScreen mainScreen].bounds.size.width*0.045)];
    _LLMixSuiPianImage1.image = [UIImage imageNamed:@"notfound.png"];
    [self addSubview:_LLMixSuiPianImage1];
    
    _LLMixSuiPianLabel1 = [[UILabel alloc]init];
//    _LLMixSuiPianLabel1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.37,
//                                           [UIScreen mainScreen].bounds.size.width*0.14,
//                                           [UIScreen mainScreen].bounds.size.width*0.12,
//                                           [UIScreen mainScreen].bounds.size.width*0.045);
    
    _LLMixSuiPianLabel1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.37,
                                           [UIScreen mainScreen].bounds.size.width*0.125,
                                           [UIScreen mainScreen].bounds.size.width*0.12,
                                           [UIScreen mainScreen].bounds.size.width*0.022);
    
    _LLMixSuiPianLabel1.text = @"钨丝";
    _LLMixSuiPianLabel1.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    _LLMixSuiPianLabel1.font = [UIFont systemFontOfSize:10];
    [self addSubview:_LLMixSuiPianLabel1];
    
    UILabel *KuCunLabel1 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.45,
                                                                   [UIScreen mainScreen].bounds.size.width*0.125,
                                                                   [UIScreen mainScreen].bounds.size.width*0.12,
                                                                   [UIScreen mainScreen].bounds.size.width*0.022)];
    KuCunLabel1.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    KuCunLabel1.font = [UIFont systemFontOfSize:10];
    KuCunLabel1.text = [NSString stringWithFormat:@"库存：%d",_SuiPianStoreCount1];
    [self addSubview:KuCunLabel1];
    
    _LLMixSuiPianProgressBgV1 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.37,
                                                                            [UIScreen mainScreen].bounds.size.width*0.16,
                                                                            [UIScreen mainScreen].bounds.size.width*0.2724,
                                                                            [UIScreen mainScreen].bounds.size.width*0.022)];
    _LLMixSuiPianProgressBgV1.image = [UIImage imageNamed:@"Mixprogress.png"];
    [self addSubview:_LLMixSuiPianProgressBgV1];

    double percentageWidth1 = (double)(_SuiPianProgress1/_SuiPianNeedProg1)*[UIScreen mainScreen].bounds.size.width*0.2724;
    UIImageView *progressImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, percentageWidth1, [UIScreen mainScreen].bounds.size.width*0.022)];
    [progressImg1.layer setCornerRadius:[UIScreen mainScreen].bounds.size.width*0.022/2];
    progressImg1.backgroundColor = [UIColor colorWithRed:82.0/255.0 green:131.0/255.0 blue:191.0/255.0 alpha:1];
    [_LLMixSuiPianProgressBgV1 addSubview:progressImg1];

    _JinduLabel1 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.67,
                                                                  [UIScreen mainScreen].bounds.size.width*0.16,
                                                                  [UIScreen mainScreen].bounds.size.width*0.20,
                                                                  [UIScreen mainScreen].bounds.size.width*0.022)];
    _JinduLabel1.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    _JinduLabel1.font = [UIFont systemFontOfSize:10];
    if (self.SuiPianProgress1 >= self.SuiPianNeedProg1) {
        _JinduLabel1.text = @"完成";
    }else{
        _JinduLabel1.text = [NSString stringWithFormat:@"%d/%d",self.SuiPianProgress1,self.SuiPianNeedProg1];
    }
    
    [self addSubview:_JinduLabel1];
//    //碎片2
//    
    _LLMixSuiPianImage2 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.30,
                                                                       [UIScreen mainScreen].bounds.size.width*0.22,
                                                                       [UIScreen mainScreen].bounds.size.width*0.045,
                                                                       [UIScreen mainScreen].bounds.size.width*0.045)];
    _LLMixSuiPianImage2.image = [UIImage imageNamed:@"notfound.png"];
    [self addSubview:_LLMixSuiPianImage2];
    
    _LLMixSuiPianLabel2 = [[UILabel alloc]init];
//    _LLMixSuiPianLabel2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.37,
//                                                     [UIScreen mainScreen].bounds.size.width*0.22,
//                                                     [UIScreen mainScreen].bounds.size.width*0.12,
//                                                     [UIScreen mainScreen].bounds.size.width*0.045);
    _LLMixSuiPianLabel2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.37,
                                           [UIScreen mainScreen].bounds.size.width*0.205,
                                           [UIScreen mainScreen].bounds.size.width*0.12,
                                           [UIScreen mainScreen].bounds.size.width*0.022);
    _LLMixSuiPianLabel2.text = @"玻璃";
    _LLMixSuiPianLabel2.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    _LLMixSuiPianLabel2.font = [UIFont systemFontOfSize:10];
    [self addSubview:_LLMixSuiPianLabel2];

    UILabel *KuCunLabel2 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.45,
                                                                    [UIScreen mainScreen].bounds.size.width*0.205,
                                                                    [UIScreen mainScreen].bounds.size.width*0.12,
                                                                    [UIScreen mainScreen].bounds.size.width*0.022)];
    KuCunLabel2.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    KuCunLabel2.font = [UIFont systemFontOfSize:10];
    KuCunLabel2.text = [NSString stringWithFormat:@"库存：%d",_SuiPianStoreCount2];
    [self addSubview:KuCunLabel2];
    
    _LLMixSuiPianProgressBgV2 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.37,
                                                                             [UIScreen mainScreen].bounds.size.width*0.24,
                                                                             [UIScreen mainScreen].bounds.size.width*0.2724,
                                                                             [UIScreen mainScreen].bounds.size.width*0.022)];
    _LLMixSuiPianProgressBgV2.image = [UIImage imageNamed:@"Mixprogress.png"];
    [self addSubview:_LLMixSuiPianProgressBgV2];
    double percentageWidth2 = ((double)_SuiPianProgress2/_SuiPianNeedProg2)*[UIScreen mainScreen].bounds.size.width*0.2724;
//    NSLog(@"第二个进度条%f",percentageWidth2);
    UIImageView *progressImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, percentageWidth2, [UIScreen mainScreen].bounds.size.width*0.022)];
    [progressImg2.layer setCornerRadius:[UIScreen mainScreen].bounds.size.width*0.022/2];
    progressImg2.backgroundColor = [UIColor colorWithRed:82.0/255.0 green:131.0/255.0 blue:191.0/255.0 alpha:1];
    [_LLMixSuiPianProgressBgV2 addSubview:progressImg2];

    _JinduLabel2 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.67,
                                                                     [UIScreen mainScreen].bounds.size.width*0.24,
                                                                    [UIScreen mainScreen].bounds.size.width*0.20,
                                                                    [UIScreen mainScreen].bounds.size.width*0.022)];
    _JinduLabel2.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    _JinduLabel2.font = [UIFont systemFontOfSize:10];
    
    if (self.SuiPianProgress2 >= self.SuiPianNeedProg2) {
        _JinduLabel2.text = @"完成";
    }else{
        _JinduLabel2.text = [NSString stringWithFormat:@"%d/%d",self.SuiPianProgress2,self.SuiPianNeedProg2];
    }
    [self addSubview:_JinduLabel2];

    //碎片3
    _LLMixSuiPianImage3 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.30,
                                                                       [UIScreen mainScreen].bounds.size.width*0.30,
                                                                       [UIScreen mainScreen].bounds.size.width*0.045,
                                                                       [UIScreen mainScreen].bounds.size.width*0.045)];
    _LLMixSuiPianImage3.image = [UIImage imageNamed:@"notfound.png"];
    [self addSubview:_LLMixSuiPianImage3];
    
    _LLMixSuiPianLabel3 = [[UILabel alloc]init];
//    _LLMixSuiPianLabel3.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.37,
//                                           [UIScreen mainScreen].bounds.size.width*0.30,
//                                           [UIScreen mainScreen].bounds.size.width*0.12,
//                                           [UIScreen mainScreen].bounds.size.width*0.045);
    _LLMixSuiPianLabel3.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.37,
                                           [UIScreen mainScreen].bounds.size.width*0.285,
                                           [UIScreen mainScreen].bounds.size.width*0.12,
                                           [UIScreen mainScreen].bounds.size.width*0.022);
    _LLMixSuiPianLabel3.text = @"花瓣";
    _LLMixSuiPianLabel3.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    _LLMixSuiPianLabel3.font = [UIFont systemFontOfSize:10];
    [self addSubview:_LLMixSuiPianLabel3];

    UILabel *KuCunLabel3 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.45,
                                                                    [UIScreen mainScreen].bounds.size.width*0.285,
                                                                    [UIScreen mainScreen].bounds.size.width*0.12,
                                                                    [UIScreen mainScreen].bounds.size.width*0.022)];
    KuCunLabel3.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    KuCunLabel3.font = [UIFont systemFontOfSize:10];
    KuCunLabel3.text = [NSString stringWithFormat:@"库存：%d",_SuiPianStoreCount3];
    [self addSubview:KuCunLabel3];
    
    
    _LLMixSuiPianProgressBgV3 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.37,
                                                                             [UIScreen mainScreen].bounds.size.width*0.32,
                                                                             [UIScreen mainScreen].bounds.size.width*0.2724,
                                                                             [UIScreen mainScreen].bounds.size.width*0.022)];
    _LLMixSuiPianProgressBgV3.image = [UIImage imageNamed:@"Mixprogress.png"];
    [self addSubview:_LLMixSuiPianProgressBgV3];
    
    double percentageWidth3 = (double)(_SuiPianProgress3/_SuiPianNeedProg3)*[UIScreen mainScreen].bounds.size.width*0.2724;
    UIImageView *progressImg3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, percentageWidth3, [UIScreen mainScreen].bounds.size.width*0.022)];
    [progressImg3.layer setCornerRadius:[UIScreen mainScreen].bounds.size.width*0.022/2];
    progressImg3.backgroundColor = [UIColor colorWithRed:82.0/255.0 green:131.0/255.0 blue:191.0/255.0 alpha:1];
    [_LLMixSuiPianProgressBgV3 addSubview:progressImg3];
    _JinduLabel3 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.67,
                                                                    [UIScreen mainScreen].bounds.size.width*0.32,
                                                                    [UIScreen mainScreen].bounds.size.width*0.20,
                                                                    [UIScreen mainScreen].bounds.size.width*0.022)];
    _JinduLabel3.textColor = [UIColor colorWithRed:223.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1];
    _JinduLabel3.font = [UIFont systemFontOfSize:10];
    if (self.SuiPianProgress3 >= self.SuiPianNeedProg3) {
        _JinduLabel3.text = @"完成";
    }else{
        _JinduLabel3.text = [NSString stringWithFormat:@"%d/%d",self.SuiPianProgress3,self.SuiPianNeedProg3];
    }
    [self addSubview:_JinduLabel3];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected) {
//
//        NSLog(@"选中");
//    }else{
//        NSLog(@"为选中");
//    }

    
}

-(void)DrawCircle{
    
    CGPoint center = CGPointMake(_LLMixFilterProgressImg.bounds.size.width/2, _LLMixFilterProgressImg.bounds.size.height/2);
//    float angle_start1 = radians(45);
//    float angle_end1 = radians(135);
    //        drawArc(ctx, center, angle_start1, angle_end1, [UIColor yellowColor],self.radius);
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:center];
    [path1 addArcWithCenter:center radius:20 startAngle:-M_PI_2 endAngle:45 clockwise:YES];
    CAShapeLayer *shaplayer1 = [CAShapeLayer layer];
    [shaplayer1 setPath:path1.CGPath];
    [shaplayer1 setFillColor:[UIColor colorWithRed:33.0/255.0 green:58.0/255.0 blue:92.0/255.0 alpha:0.5].CGColor];
    [shaplayer1 setZPosition:center.x];
    [_LLMixFilterProgressImg.layer addSublayer:shaplayer1];
}

-(void)test{
    NSLog(@"点击合成按钮");
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    customView.backgroundColor = [UIColor blueColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [btn setBackgroundColor:[UIColor grayColor]];
    [customView addSubview:btn];
    [btn addTarget:self action:@selector(hello) forControlEvents:UIControlEventTouchUpInside];
    customAlert = [[JCAlertView alloc] initWithCustomView:customView dismissWhenTouchedBackground:YES];
    [customAlert show];
}
-(void)hello{
    [customAlert dismissWithCompletion:^{
        NSLog(@"结束啦");
    }];
}

@end
