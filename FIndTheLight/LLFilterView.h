//
//  LLFilterView.h
//  FIndTheLight
//
//  Created by Wll on 16/12/3.
//  Copyright © 2016年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
@interface LLFilterView : UIImageView{
    
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
}

@property(nonatomic,strong) NSString *LLFilterName;

-(void)LLfilerDraw;

@end
