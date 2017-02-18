//
//  LLLocalSuiPian.h
//  FIndTheLight
//
//  Created by Wll on 17/2/16.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LLLocalSuiPian : NSObject{
    LLLocalSuiPian *suiPian;
}

@property (nonatomic) UIImage  *LLLocalSuiPianImage;
@property (nonatomic) NSString *LLLocalSuiPianNameString;
@property (nonatomic) NSString *LLLocalSuiPianCount;

-(void)RandomSetLocalSuiPian;
@end
