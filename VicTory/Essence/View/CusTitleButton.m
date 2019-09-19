//
//  CusTitleButton.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/19.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "CusTitleButton.h"

@implementation CusTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

//只要重写了这个方法，按钮就无法进入高亮状态
//目的是为了让按钮在长按时不会出现高亮状态，且按钮本身还是可用的（可点击的）
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
