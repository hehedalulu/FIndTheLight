//
//  LLMixFilterViewController.h
//  FIndTheLight
//
//  Created by Wll on 17/1/21.
//  Copyright © 2017年 CherryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLFilterModel.h"
@interface LLMixFilterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    LLFilterModel *filtermodel;
}
@end
