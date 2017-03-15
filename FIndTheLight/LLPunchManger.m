//
//  LLPunchManger.m
//  FIndTheLight
//
//  Created by Wll on 17/3/12.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLPunchManger.h"

@implementation LLPunchManger
@synthesize  LLPunchLibraryAMCount;
@synthesize  LLPunchLibraryPMCount;
@synthesize  LLPunchRestaurantAMCount;
@synthesize  LLPunchRestaurantPMCount;
@synthesize  LLPunchTeachAMCount;
@synthesize  LLPunchTeachPMCount;


-(void)CheckDatePunch:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    
    RLMRealm * realm = [RLMRealm defaultRealm];
    RLMResults * tempArray = [LLPunchModel allObjectsInRealm:[RLMRealm defaultRealm]];
    [realm transactionWithBlock:^{
        for (LLPunchModel *model  in tempArray) {
            if ([model.PunchDate isEqualToString:dateStr]) {
                if (model.LibraryPunchAM == 1) {
                    self.LLPunchLibraryAMCount++;
                }
                if (model.LibraryPunchPM == 1) {
                    self.LLPunchLibraryPMCount++;
                }
                if (model.ResturantPunchAM == 1) {
                    self.LLPunchRestaurantAMCount++;
                }
                if (model.ResturantPunchPM == 1) {
                    self.LLPunchRestaurantPMCount++;
                }
                if (model.TeachPunchAM == 1) {
                    self.LLPunchTeachAMCount++;
                }
                if (model.TeachPunchPM == 1) {
                    self.LLPunchTeachPMCount++;
                }
            }
        }
        [realm commitWriteTransaction]; //注意  这里不能写在for循环里面 写入数据库， 要在循环改变完只好
    }];
    NSLog(@"%@的图书馆打卡次数，上午%d，下午%d",dateStr,self.LLPunchLibraryAMCount,self.LLPunchLibraryPMCount);
    NSLog(@"%@的食堂打卡次数，上午%d，下午%d",dateStr,self.LLPunchRestaurantAMCount,self.LLPunchRestaurantPMCount);
    NSLog(@"%@的教学楼打卡次数，上午%d，下午%d",dateStr,self.LLPunchTeachAMCount,self.LLPunchTeachPMCount);
}

-(void)TestDatePunch:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    
//    RLMRealm * realm = [RLMRealm defaultRealm];
//    RLMResults * tempArray = [LLPunchModel allObjectsInRealm:[RLMRealm defaultRealm]];
//    [realm transactionWithBlock:^{
//        for (LLPunchModel *model  in tempArray) {
//            if ([model.PunchDate isEqualToString:dateStr]) {
//                if (model.LibraryPunchAM == 1) {
                    self.LLPunchLibraryAMCount = 3;
//                }
//                if (model.LibraryPunchPM == 1) {
                    self.LLPunchLibraryPMCount = 2;
//                }
//                if (model.ResturantPunchAM == 1) {
                    self.LLPunchRestaurantAMCount = 5;
//                }
//                if (model.ResturantPunchPM == 1) {
                    self.LLPunchRestaurantPMCount = 1;
//                }
//                if (model.TeachPunchAM == 1) {
                    self.LLPunchTeachAMCount = 1;
//                }
//                if (model.TeachPunchPM == 1) {
                    self.LLPunchTeachPMCount = 2;
//                }
//            }
//        }
//        [realm commitWriteTransaction]; //注意  这里不能写在for循环里面 写入数据库， 要在循环改变完只好
//    }];
    NSLog(@"%@的图书馆打卡次数，上午%d，下午%d",dateStr,self.LLPunchLibraryAMCount,self.LLPunchLibraryPMCount);
    NSLog(@"%@的食堂打卡次数，上午%d，下午%d",dateStr,self.LLPunchRestaurantAMCount,self.LLPunchRestaurantPMCount);
    NSLog(@"%@的教学楼打卡次数，上午%d，下午%d",dateStr,self.LLPunchTeachAMCount,self.LLPunchTeachPMCount);
}

@end
