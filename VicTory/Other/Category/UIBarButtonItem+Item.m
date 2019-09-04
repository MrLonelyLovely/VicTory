//
//  UIBarButtonItem+Item.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/4.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (UIBarButtonItem *)itemWithImageString:(NSString *)imageString highImageString:(NSString *)highImageString target:(nullable id)target action:(SEL)action
{
    UIButton *btnGame = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnGame setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    [btnGame setImage:[UIImage imageNamed:highImageString] forState:UIControlStateHighlighted];
    [btnGame sizeToFit];
    [btnGame addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btnGame];
}

+ (UIBarButtonItem *)backItemWithImageString:(NSString *)imageString highImageString:(NSString *)highImageString target:(nullable id)target action:(SEL)action title:(NSString *)title
{
//    [UIImage imageNamed:@"navigationButtonReturn"]
//    [UIImage imageNamed:@"navigationButtonReturnClick"]
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:title forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backBtn setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:highImageString] forState:UIControlStateHighlighted];
    [backBtn sizeToFit];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

+ (UIBarButtonItem *)itemWithImageString:(NSString *)imageString selectedImageString:(NSString *)selectedImageString target:(nullable id)target action:(SEL)action
{
    UIButton *btnGame = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnGame setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    [btnGame setImage:[UIImage imageNamed:selectedImageString] forState:UIControlStateSelected];
    [btnGame sizeToFit];
    [btnGame addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btnGame];
}
@end
