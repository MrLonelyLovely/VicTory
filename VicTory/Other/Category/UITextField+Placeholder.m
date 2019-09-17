//
//  UITextField+Placeholder.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/11.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //获取占位文字label控件
    UILabel *placeHolderLabel = [self valueForKey:@"placeholderLabel"];
    //设置占位文字颜色
    placeHolderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor
{
    return nil;
}
@end
