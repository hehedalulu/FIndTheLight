//
//  LLARPicsModel.h
//  FIndTheLight
//
//  Created by Wll on 17/3/7.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <Realm/Realm.h>

@interface LLARPicsModel : RLMObject
@property (nonatomic,copy) NSString *ARPicName;
@property (nonatomic,copy) NSString *ARPicLocation;
@property (nonatomic,copy) NSString *ARPicCategory;
@property (nonatomic,assign) int HasbeenScan;
@property (copy) NSString *ARPicsAMOrPM;

//-(BOOL)isKindOfLocation:(NSString *)locationName;
//-(BOOL)isKindOfCategory:(NSString *)Category;
@end
