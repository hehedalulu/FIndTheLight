//
//  RandomSetARPics.m
//  FIndTheLight
//
//  Created by Wll on 17/3/5.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "RandomSetARPics.h"



@implementation RandomSetARPics

-(void)SetImages{
    //如果是当天6:00到18:00
    //根据类别更新
    /*       东九(0)     西十二(1)     中间(2)
     图书馆(0)    2                    3
     教学楼(1)    3        2
     食堂(2)      2        2           1
     */
    
    //图书馆 两个东九
    
    realm = [RLMRealm defaultRealm];
    
    self.ARImagesArray = [[NSMutableArray alloc]init];
    [self initCategoryLibraryImages];
}


-(void)initCategoryLibraryImages{
    //图书馆 东九
    //随机生成两个图片并保证两个图片并不重复
    
    int randomNumeber1 = arc4random()%4;
    int randomNumeber2 = arc4random()%4;
    while (randomNumeber1 == randomNumeber2 ) {
            randomNumeber2 = arc4random()%4;
    }
    NSString *randomString1 = [NSString stringWithFormat:@"%d",randomNumeber1];
    NSString *randomString2 = [NSString stringWithFormat:@"%d",randomNumeber2];
    
    NSMutableArray *randomNumberArray1 = [[NSMutableArray alloc]initWithObjects:randomString1,randomString2,nil];
    
   
    for (int i=0; i<2; i++) {
        LLARPicsModel *model = [[LLARPicsModel alloc]init];
        NSString *imageString = [NSString stringWithFormat:@"Library_dongjiu%@.jpg",randomNumberArray1[i]];
        model.ARPicName = imageString;
        model.ARPicLocation = @"东九";
        model.ARPicCategory = @"图书馆";
        model.HasbeenScan = 0;
        model.ARPicsAMOrPM = self.AMOrPM;
        [self.ARImagesArray addObject:model];
        [self addtoPics:model];
        
    }
    
    //图书馆 中间
    int randomNumeber11 = arc4random()%4;
    int randomNumeber22 = arc4random()%4;
    int randomNumeber33 = arc4random()%4;
    while (randomNumeber11 == randomNumeber22) {
        randomNumeber22 = arc4random()%4;
    }
    while (randomNumeber33 == randomNumeber22||randomNumeber33 == randomNumeber11) {
        randomNumeber33 = arc4random()%4;
    }
    
    NSString *randomString11 = [NSString stringWithFormat:@"%d",randomNumeber11];
    NSString *randomString22 = [NSString stringWithFormat:@"%d",randomNumeber22];
    NSString *randomString33 = [NSString stringWithFormat:@"%d",randomNumeber33];

    NSMutableArray *randomNumberArray2 = [[NSMutableArray alloc]initWithObjects:randomString11,randomString22,randomString33,nil];
    
    
    for (int i=0; i<3; i++) {
        LLARPicsModel *model = [[LLARPicsModel alloc]init];
        NSString *imageString = [NSString stringWithFormat:@"Library_zhongjian%@.jpg",randomNumberArray2[i]];
        model.ARPicName = imageString;
        model.ARPicLocation = @"中间";
        model.ARPicCategory = @"图书馆";
        model.HasbeenScan = 0;
        model.ARPicsAMOrPM = self.AMOrPM;
        [self.ARImagesArray addObject:model];
        [self addtoPics:model];
    }
    [self initCategoryBuildingImages];
    
}

-(void)initCategoryBuildingImages{
    //教学楼 东九
    int randomNumeber11 = arc4random()%4;
    int randomNumeber22 = arc4random()%4;
    int randomNumeber33 = arc4random()%4;
    while (randomNumeber11 == randomNumeber22) {
        randomNumeber22 = arc4random()%4;
    }
    while (randomNumeber33 == randomNumeber22||randomNumeber33 == randomNumeber11) {
        randomNumeber33 = arc4random()%4;
    }
    
    NSString *randomString11 = [NSString stringWithFormat:@"%d",randomNumeber11];
    NSString *randomString22 = [NSString stringWithFormat:@"%d",randomNumeber22];
    NSString *randomString33 = [NSString stringWithFormat:@"%d",randomNumeber33];
    
    NSMutableArray *randomNumberArray2 = [[NSMutableArray alloc]initWithObjects:randomString11,randomString22,randomString33,nil];
    
    
    for (int i=0; i<3; i++) {
        LLARPicsModel *model = [[LLARPicsModel alloc]init];
        NSString *imageString = [NSString stringWithFormat:@"TeachBuilding_dongjiu%@.jpg",randomNumberArray2[i]];
        model.ARPicName = imageString;
        model.ARPicLocation = @"东九";
        model.ARPicCategory = @"教学楼";
        model.HasbeenScan = 0;
        model.ARPicsAMOrPM = self.AMOrPM;
        [self.ARImagesArray addObject:model];
         [self addtoPics:model];
    }
    
    
    //教学楼 西十二
    int randomNumeber1 = arc4random()%4;
    int randomNumeber2 = arc4random()%4;
    while (randomNumeber1 == randomNumeber2 ) {
        randomNumeber2 = arc4random()%4;
    }
    NSString *randomString1 = [NSString stringWithFormat:@"%d",randomNumeber1];
    NSString *randomString2 = [NSString stringWithFormat:@"%d",randomNumeber2];
    
    NSMutableArray *randomNumberArray1 = [[NSMutableArray alloc]initWithObjects:randomString1,randomString2,nil];
    
    
    for (int i=0; i<2; i++) {
        LLARPicsModel *model = [[LLARPicsModel alloc]init];
        NSString *imageString = [NSString stringWithFormat:@"TeachBuilding_xishier%@.jpg",randomNumberArray1[i]];
        model.ARPicName = imageString;
        model.ARPicLocation = @"西十二";
        model.ARPicCategory = @"教学楼";
        model.HasbeenScan = 0;
        model.ARPicsAMOrPM = self.AMOrPM;
        [self.ARImagesArray addObject:model];
         [self addtoPics:model];
    }
    [self initCategoryResturantImages];
}

-(void)initCategoryResturantImages{
    //食堂 东九
    int randomNumeber1 = arc4random()%4;
    int randomNumeber2 = arc4random()%4;
    while (randomNumeber1 == randomNumeber2 ) {
        randomNumeber2 = arc4random()%4;
    }
    NSString *randomString1 = [NSString stringWithFormat:@"%d",randomNumeber1];
    NSString *randomString2 = [NSString stringWithFormat:@"%d",randomNumeber2];
    
    NSMutableArray *randomNumberArray1 = [[NSMutableArray alloc]initWithObjects:randomString1,randomString2,nil];
    
    for (int i=0; i<2; i++) {
        LLARPicsModel *model = [[LLARPicsModel alloc]init];
        NSString *imageString = [NSString stringWithFormat:@"restaurant_dongjiu%@.jpg",randomNumberArray1[i]];
        model.ARPicName = imageString;
        model.ARPicLocation = @"东九";
        model.ARPicCategory = @"食堂";
        model.HasbeenScan = 0;
        model.ARPicsAMOrPM = self.AMOrPM;
        [self.ARImagesArray addObject:model];
         [self addtoPics:model];
    }
    //食堂 西十二
    int randomNumeber11 = arc4random()%4;
    int randomNumeber22 = arc4random()%4;
    while (randomNumeber11 == randomNumeber22 ) {
        randomNumeber22 = arc4random()%4;
    }
    NSString *randomString11 = [NSString stringWithFormat:@"%d",randomNumeber11];
    NSString *randomString22 = [NSString stringWithFormat:@"%d",randomNumeber22];
    
    NSMutableArray *randomNumberArray2 = [[NSMutableArray alloc]initWithObjects:randomString11,randomString22,nil];
    
    
    for (int i=0; i<2; i++) {
        LLARPicsModel *model = [[LLARPicsModel alloc]init];
        NSString *imageString = [NSString stringWithFormat:@"restaurant_xishier%@.jpg",randomNumberArray2[i]];
        model.ARPicName = imageString;
        model.ARPicLocation = @"西十二";
        model.ARPicCategory = @"食堂";
        model.HasbeenScan = 0;
        model.ARPicsAMOrPM = self.AMOrPM;
        [self.ARImagesArray addObject:model];
         [self addtoPics:model];
    }
    
    //食堂 中间
    int randomNumeber111 = arc4random()%4;
    NSString *randomString111 = [NSString stringWithFormat:@"%d",randomNumeber111];
    
//    NSMutableArray *randomNumberArray3 = [[NSMutableArray alloc]initWithObjects:randomString111,nil];
//    for (int i=0; i<2; i++) {
        LLARPicsModel *model = [[LLARPicsModel alloc]init];
        NSString *imageString = [NSString stringWithFormat:@"restaurant_zhongjian%@.jpg",randomString111];
        model.ARPicName = imageString;
        model.ARPicLocation = @"中间";
        model.ARPicCategory = @"食堂";
        model.HasbeenScan = 0;
        model.ARPicsAMOrPM = self.AMOrPM;
        [self.ARImagesArray addObject:model];
        [self addtoPics:model];
//    }
   
//    for (int i=0; i<15; i++) {
//        LLARPicsModel *model = [self.ARImagesArray objectAtIndex:i];
//        NSString *test = model.ARPicName;
//        NSLog(@"生成的AR识别图：%@",test);
//    }
    
}


-(void)addtoPics:(LLARPicsModel *)model{
//    [realm beginWriteTransaction];
    
    [realm transactionWithBlock:^{
        //存储数据
        [realm  addObject:model];
        //写入数据库
        [realm commitWriteTransaction];
    }];
    
}

@end
