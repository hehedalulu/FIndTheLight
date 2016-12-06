//
//  LLHealthEnergyViewController.m
//  FIndTheLight
//
//  Created by Wll on 16/12/5.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLHealthEnergyViewController.h"
#import "LLGetStep.h"
@interface LLHealthEnergyViewController ()
@property (strong, nonatomic) IBOutlet UILabel *testHealthLabel;

@end

@implementation LLHealthEnergyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LLGetStep *getstep = [[LLGetStep alloc]init];
    [getstep CreatHealth];
    [self initHealthLabel];

}

-(void)initHealthLabel{
    id energy = [[NSUserDefaults standardUserDefaults] objectForKey:@"Energy"];
    NSLog(@"vc中获取的额步数%@",energy);
//    if (energy == nil) {
//        _testHealthLabel.text = @"没有获取步数";
    [self initHealthLabel];
//
//    }else{
//        NSString *energyint = (NSString *)energy;
//        _testHealthLabel.text = energyint;
//    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
