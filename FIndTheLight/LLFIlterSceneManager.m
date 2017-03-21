//
//  LLFIlterSceneManager.m
//  FIndTheLight
//
//  Created by Wll on 17/3/18.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import "LLFIlterSceneManager.h"

@implementation LLFIlterSceneManager
@synthesize  skView;



-(LLCustomeSKView *)setSKView{
    if (!skView) {
        skView = [[LLCustomeSKView alloc]initWithFrame:CGRectMake(0, 0,
                                                                  [UIScreen mainScreen].bounds.size.width,
                                                                  [UIScreen mainScreen].bounds.size.height)];
    }
//    [self ComfirmLevelValue:skView.LLFilterSceneArray];
    
    return skView;
}

-(void)setFilter{
    if ([skView.LLCustomeFilterName isEqualToString:@"filter1"]) {//初始化第一套滤镜
        
        LLFilterScene *scene1 = [[LLFilterScene alloc]initWithSize:skView.bounds.size];
        scene1.LLFilterSceneAtlasName = @"FilterLighting";
        scene1.LLFilterSceneAtlasCount = 50;
        scene1.LLFilterSceneValue = 0;
        
        LLFilterScene *scene2 = [[LLFilterScene alloc]initWithSize:skView.bounds.size];
        scene2.LLFilterSceneAtlasName = @"smallrain";
        scene2.LLFilterSceneAtlasCount = 120;
        scene2.LLFilterSceneValue = 100;
        
        LLFilterScene *scene3 = [[LLFilterScene alloc]initWithSize:skView.bounds.size];
        scene3.LLFilterSceneAtlasName = @"Fliterrainbow";
        scene3.LLFilterSceneAtlasCount = 60;
        scene3.LLFilterSceneValue = 200;
        
        skView.LLFilterSceneArray = [[NSMutableArray alloc]initWithObjects:scene1,scene2,scene3, nil];
    }else{
        //初始化第二套滤镜
        LLFilterScene *scene1 = [[LLFilterScene alloc]initWithSize:skView.bounds.size];
        scene1.LLFilterSceneAtlasName = @"Fliterrainbow";
        scene1.LLFilterSceneAtlasCount = 60;
        scene1.LLFilterSceneValue = 0;
        
        LLFilterScene *scene2 = [[LLFilterScene alloc]initWithSize:skView.bounds.size];
        scene2.LLFilterSceneAtlasName = @"smallrain";
        scene2.LLFilterSceneAtlasCount = 120;
        scene2.LLFilterSceneValue = 100;
        
        LLFilterScene *scene3 = [[LLFilterScene alloc]initWithSize:skView.bounds.size];
        scene3.LLFilterSceneAtlasName = @"FilterLighting";
        scene3.LLFilterSceneAtlasCount = 50;
        scene3.LLFilterSceneValue = 200;
        
        skView.LLFilterSceneArray = [[NSMutableArray alloc]initWithObjects:scene1,scene2,scene3, nil];
    }
}

-(LLFilterScene *)ComfirmLevelValueBackScene{
    //根据当前光量值确定当前场景
//    0  100 500 1000
    LLFilterScene *backScene = [[LLFilterScene alloc]init];
    for (int i = 0; i<skView.LLFilterSceneArray.count; i++) {
        if(i == skView.LLFilterSceneArray.count-1){
            //大于最大后 一直是那个场景
            rightScene = [skView.LLFilterSceneArray objectAtIndex:i];
            if (self.LLSKViewLightValue>=rightScene.LLFilterSceneValue) {
                backScene = [skView.LLFilterSceneArray objectAtIndex:i];
            }
        }else{
            rightScene = [skView.LLFilterSceneArray objectAtIndex:i];
            NextScene = [skView.LLFilterSceneArray objectAtIndex:i+1];
            if (self.LLSKViewLightValue>=rightScene.LLFilterSceneValue&&self.LLSKViewLightValue<=NextScene.LLFilterSceneValue) {
                 backScene = [skView.LLFilterSceneArray objectAtIndex:i];
            }
        }
    }
    return backScene;
}

-(void)removeNowScene{
    [rightScene removeFromParent];
}

-(void)ChangeFilterwithNewFilter:(NSString *)FilterName{
    skView.LLCustomeFilterName = FilterName;
    [self setFilter];
    
}

-(LLFilterScene *)ChangeSKViewWithChangeValue:(double)changeValue{
    LLFilterScene *backScene = [[LLFilterScene alloc]init];
    for (int i = 0; i< skView.LLFilterSceneArray.count; i++) {
        if(i== skView.LLFilterSceneArray.count-1){//大于最大后一直是那个场景
            rightScene = [skView.LLFilterSceneArray objectAtIndex:i];
            if (changeValue >= rightScene.LLFilterSceneValue) {
                backScene = [skView.LLFilterSceneArray objectAtIndex:i];
            }
        }else{
            rightScene = [skView.LLFilterSceneArray objectAtIndex:i];
            NextScene = [ skView.LLFilterSceneArray objectAtIndex:i+1];
            if (changeValue >=rightScene.LLFilterSceneValue&& changeValue<=NextScene.LLFilterSceneValue) {
                backScene = [skView.LLFilterSceneArray objectAtIndex:i];
            }
        }
    }
    return backScene;
}
@end
