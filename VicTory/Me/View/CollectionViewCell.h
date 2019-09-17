//
//  CollectionViewCell.h
//  VicTory
//
//  Created by 陈沛 on 2019/9/17.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SquareItem;
@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) SquareItem *item;
@end

NS_ASSUME_NONNULL_END
