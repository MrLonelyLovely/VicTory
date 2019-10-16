//
//  UIImageView+Download.h
//  VicTory
//
//  Created by Apui on 2019/10/16.
//  Copyright © 2019 陈沛. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Download)

- (void)setRawImage:(NSString *)rawImageURL thumbnail:(NSString *)thumbnailURL placeholder:(UIImage *)placeholder;

//设置圆形头像
- (void)setRoundImageView;
@end


NS_ASSUME_NONNULL_END
