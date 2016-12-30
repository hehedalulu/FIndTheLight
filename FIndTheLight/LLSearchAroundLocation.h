//
//  LLSearchAroundLocation.h
//  FIndTheLight
//
//  Created by Wll on 16/11/26.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLSearchAroundLocation : NSObject

@property (nonatomic,strong) NSString *LLNearestLocation;
-(void)GetRequestionlongitude:(float)Coordinatelongitude latitude:(float)Coordinatelatitude;
@end
