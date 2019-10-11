//
//  PostCell.h
//  VicTory
//
//  Created by Apui on 2019/10/11.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Post;
@interface PostCell : UITableViewCell

@property (nonatomic, strong) Post *post;

@end

NS_ASSUME_NONNULL_END
