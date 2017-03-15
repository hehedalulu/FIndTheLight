//
//  RandomSetARPics.h
//  FIndTheLight
//
//  Created by Wll on 17/3/5.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLARPicsModel.h"

@interface RandomSetARPics : NSObject{
    RLMRealm * realm;
}
@property (strong,nonatomic) NSMutableArray *ARImagesArray;
@property (copy) NSString *AMOrPM;

-(void)SetImages;
@end
