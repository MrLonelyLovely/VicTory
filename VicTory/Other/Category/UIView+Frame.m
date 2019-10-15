//
//  UIView+Frame.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/11.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(void)setCusHeight:(CGFloat)cusHeight
{
    CGRect rect = self.frame;
    rect.size.height = cusHeight;
    self.frame = rect;
}

-(CGFloat)cusHeight
{
    return self.frame.size.height;
}

-(void)setCusWidth:(CGFloat)cusWidth
{
    CGRect rect = self.frame;
    rect.size.width = cusWidth;
    self.frame = rect;
}

-(CGFloat)cusWidth
{
    return self.frame.size.width;
}

-(void)setCusX:(CGFloat)cusX
{
    CGRect rect = self.frame;
    rect.origin.x = cusX;
    self.frame = rect;
}

-(CGFloat)cusX
{
    return self.frame.origin.x;
}

-(void)setCusY:(CGFloat)cusY
{
    CGRect rect = self.frame;
    rect.origin.y = cusY;
    self.frame = rect;
}

-(CGFloat)cusY
{
    return self.frame.origin.y;
}

- (void)setCusCenterX:(CGFloat)cusCenterX
{
    CGPoint center = self.center;
    center.x = cusCenterX;
    self.center = center;
}
- (CGFloat)cusCenterX
{
    return self.center.x;
}

- (void)setCusCenterY:(CGFloat)cusCenterY
{
    CGPoint center = self.center;
    center.y = cusCenterY;
    self.center = center;
}

- (CGFloat)cusCenterY
{
    return self.center.y;
}

+ (instancetype)cusViewFromXIb
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
