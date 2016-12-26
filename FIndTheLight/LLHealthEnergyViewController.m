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

//    if (energy == nil) {
//        _testHealthLabel.text = @"没有获取步数";
//
//    }else{
//        NSString *energyint = (NSString *)energy;
    LLGetStep *getstep = [[LLGetStep alloc]init];
    [getstep CreatHealth];
    
    NSString *energy = [[NSUserDefaults standardUserDefaults] objectForKey:@"Energy"];
    NSLog(@"vc中获取的额步数%@",energy);
        _testHealthLabel.text = energy;
//    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
