//
//  UIBarButtonItem+Item.h
//  VicTory
//
//  Created by 陈沛 on 2019/9/4.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Item)
+(UIBarButtonItem *)itemWithImageString:(NSString *)imageString highImageString:(NSString *)highImageString target:(nullable id)target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithImageString:(NSString *)imageString highImageString:(NSString *)highImageString target:(nullable id)target action:(SEL)action title:(NSString *)title;

+ (UIBarButtonItem *)itemWithImageString:(NSString *)imageString selectedImageString:(NSString *)selectedImageString target:(nullable id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
