//
//  SubTagCell.h
//  VicTory
//
//  Created by 陈沛 on 2019/9/9.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubTagItem.h"
NS_ASSUME_NONNULL_BEGIN
@class SubTagItem;  //这里为什么还要声明这个类呢
@interface SubTagCell : UITableViewCell
@property (nonatomic, strong) SubTagItem *item;
@end

NS_ASSUME_NONNULL_END
