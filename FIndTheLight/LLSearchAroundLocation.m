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
    
    NSMutableArray *locationNameArray = [[NSMutableArray alloc]init];
    
    NSString *front         = @"https://yuntuapi.amap.com/datasearch/around?tableid=582deb52305a2a4ab5141366";
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
         NSLog(@"dic is %@",dic);
        /*
         之前这边爆出来空指针异常
         判断一下附近有多少个基站
         */
        NSString *count = [dic objectForKey:@"count"];
        NSLog(@"返回附近的基站的数目%@",count);
        if ([count isEqualToString:@"0"]) {
            [[NSUserDefaults standardUserDefaults]setValue:@"附近无基站" forKey:@"LLNearestLocation"];
            [[NSUserDefaults standardUserDefaults]setValue:@"附近无基站" forKey:@"LLSecondNearestLocation"];
            [[NSUserDefaults standardUserDefaults]setValue:@"附近无基站" forKey:@"LLThirdNearestLocation"];
        }else if([count isEqualToString:@"1"]){
            NSArray *list = [dic objectForKey:@"datas"];
            //        NSLog(@"list is %@",list);
            if(list){
                //最近的一个基站
                if ([list objectAtIndex:0]) {
                    
                    NSDictionary * name = [list objectAtIndex:0];
                    NSString *NameStr1 = [name objectForKey:@"_name"];
                    //unicode转中文
                    //            NameStr1 = [NameStr1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    //unicode
                    NameStr1 = [NameStr1 stringByRemovingPercentEncoding];
                    [locationNameArray addObject:NameStr1];
                    _LLNearestLocation = NameStr1;
                    NSLog(@"最近的基站%@",NameStr1);
                    [[NSUserDefaults standardUserDefaults]setValue:NameStr1 forKey:@"LLNearestLocation"];
                }
            }
        }else if([count isEqualToString:@"2"]){
            NSArray *list = [dic objectForKey:@"datas"];
            //        NSLog(@"list is %@",list);
            if(list){
                //最近的一个基站
                if ([list objectAtIndex:0]) {
                    
                    NSDictionary * name = [list objectAtIndex:0];
                    NSString *NameStr1 = [name objectForKey:@"_name"];
                    //unicode转中文
                    //            NameStr1 = [NameStr1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    //unicode
                    NameStr1 = [NameStr1 stringByRemovingPercentEncoding];
                    [locationNameArray addObject:NameStr1];
                    _LLNearestLocation = NameStr1;
                    NSLog(@"最近的基站%@",NameStr1);
                    [[NSUserDefaults standardUserDefaults]setValue:NameStr1 forKey:@"LLNearestLocation"];
                    
                }
                if ([list objectAtIndex:1]) {
                    NSDictionary * name = [list objectAtIndex:1];
                    NSString *NameStr2 = [name objectForKey:@"_name"];
                    //unicode转中文
                    //            NameStr1 = [NameStr1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    NameStr2 = [NameStr2 stringByRemovingPercentEncoding];
                    [locationNameArray addObject:NameStr2];
                    [[NSUserDefaults standardUserDefaults]setValue:NameStr2 forKey:@"LLSecondNearestLocation"];
                    NSLog(@"第二近的基站%@",NameStr2);
                }
            }
        }else{
            NSArray *list = [dic objectForKey:@"datas"];
            //        NSLog(@"list is %@",list);
            if(list){
                //最近的一个基站
                if ([list objectAtIndex:0]) {
                    
                    NSDictionary * name = [list objectAtIndex:0];
                    NSString *NameStr1 = [name objectForKey:@"_name"];
                    //unicode转中文
                    //            NameStr1 = [NameStr1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    //unicode
                    NameStr1 = [NameStr1 stringByRemovingPercentEncoding];
                    [locationNameArray addObject:NameStr1];
                    _LLNearestLocation = NameStr1;
                    NSLog(@"最近的基站%@",NameStr1);
                    [[NSUserDefaults standardUserDefaults]setValue:NameStr1 forKey:@"LLNearestLocation"];
                    
                }
                if ([list objectAtIndex:1]) {
                    NSDictionary * name = [list objectAtIndex:1];
                    NSString *NameStr2 = [name objectForKey:@"_name"];
                    //unicode转中文
                    //            NameStr1 = [NameStr1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    NameStr2 = [NameStr2 stringByRemovingPercentEncoding];
                    [locationNameArray addObject:NameStr2];
                    [[NSUserDefaults standardUserDefaults]setValue:NameStr2 forKey:@"LLSecondNearestLocation"];
                    NSLog(@"第二近的基站%@",NameStr2);
                }
                if ([list objectAtIndex:2]) {
                    //第三近的基站
                    NSDictionary * name3 = [list objectAtIndex:2];
                    NSString *NameStr3 = [name3 objectForKey:@"_name"];
                    //unicode转中文
                    NameStr3 = [NameStr3 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    NameStr3 = [NameStr3 stringByRemovingPercentEncoding];
                    [locationNameArray addObject:NameStr3];
                    [[NSUserDefaults standardUserDefaults]setValue:NameStr3 forKey:@"LLThirdNearestLocation"];
                    NSLog(@"第三近的基站%@",NameStr3);
                }
                //            NSLog(@"%@",locationNameArray);
            }

        }
        
 //        NSLog(@"%@",_LLNearestLocation);
        
//        for (NSDictionary *dic in list) {
//            NSString *addressname = [dic objectForKey:@"_name"];
//            NSLog(@"%@",addressname);
//        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"FlyElephant-Error: %@", error);
/*        NSMutableArray *temp = [[NSMutableArray alloc]initWithObjects:
                         @"第一个未找到",
                         @"第二个未找到",
                         @"第三个未找到",nil];
        [locationNameArray addObjectsFromArray:temp];
 */
 }];
 
//    if (locationNameArray.count == 0) {
//                   locationNameArray = [[NSMutableArray alloc]initWithObjects:
//                                @"启明学院",
//                                @"重新定位",
//                                @"重新定位",nil];
//    }
//    NSLog(@"最后的array%@",locationNameArray);
//    return locationNameArray;
}




@end
