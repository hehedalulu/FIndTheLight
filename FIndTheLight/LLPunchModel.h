//
//  LLPunchModel.h
//  
//
//  Created by Wll on 17/3/12.
//
//

#import <Realm/Realm.h>

@interface LLPunchModel : RLMObject

@property (copy) NSString *PunchDate;

@property (copy) NSString *PunchPlace;

@property (assign) int LibraryPunchAM;

@property (assign) int LibraryPunchPM;

@property (assign) int ResturantPunchAM;

@property (assign) int ResturantPunchPM;

@property (assign) int TeachPunchAM;

@property (assign) int TeachPunchPM;


@end
