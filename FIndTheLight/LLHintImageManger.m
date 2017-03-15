//
//  LLHintImageManger.m
//  FIndTheLight
//
//  Created by Wll on 17/3/8.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLHintImageManger.h"

@implementation LLHintImageManger

-(NSMutableArray *)ShowImagesArray{
    RLMRealm * realm = [RLMRealm defaultRealm];
    RLMResults * tempArray = [LLARPicsModel allObjectsInRealm:[RLMRealm defaultRealm]];
    
    NSMutableArray *PicNameArray = [[NSMutableArray alloc]init];
    [realm transactionWithBlock:^{
        for (LLARPicsModel *model  in tempArray) {
            if ([model.ARPicLocation isEqualToString:@"东九"]) {
                [PicNameArray addObject:model.ARPicName];
            }
        }
        [realm commitWriteTransaction]; //注意  这里不能写在for循环里面 写入数据库， 要在循环改变完只好
    }];
    
    
    for (NSString*string in PicNameArray) {
      NSLog(@"模型中的图片名称%@",string);
    }
    return PicNameArray;
}

@end
