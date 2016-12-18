//
//  LLSearchAroundLocation.m
//  FIndTheLight
//
//  Created by Wll on 16/11/26.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import "LLSearchAroundLocation.h"
#import "AFHTTPSessionManager.h"

@implementation LLSearchAroundLocation
-(void)GetRequestionlongitude:(float)Coordinatelongitude latitude:(float)Coordinatelatitude{
    
    NSString *front         = @"http://yuntuapi.amap.com/datasearch/around?tableid=582deb52305a2a4ab5141366";
    NSString *coordinate    = [NSString stringWithFormat:@"&center=%f,%f",Coordinatelongitude,Coordinatelatitude];
    //     NSString *coordinate = @"&center=114.426664,30.513247";
    NSString *radius        = @"&radius=3000";
    NSString *key           = @"&key=40e3934f0d4df3b26fd6c4f2c405de37";
    NSString *all           = [NSString stringWithFormat:@"%@%@%@%@",front,coordinate,radius,key];
//    NSLog(@"%@",all);
    
     NSURL *URL =[NSURL URLWithString:all];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //解析返回周边的json
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject  options:NSJSONReadingMutableLeaves error:nil];
        // NSLog(@"dic is %@",dic);
        
        NSArray *list = [dic objectForKey:@"datas"];
//        NSLog(@"list is %@",list);
        if(list){
            NSDictionary * name = [list objectAtIndex:0];
            _LLNearestLocation = [name objectForKey:@"_name"];
//            NSLog(@"名字%@",name);
        }


        

//        NSLog(@"%@",_LLNearestLocation);
        
//        for (NSDictionary *dic in list) {
//            NSString *addressname = [dic objectForKey:@"_name"];
//            NSLog(@"%@",addressname);
//        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"FlyElephant-Error: %@", error);
    }];
}

@end
