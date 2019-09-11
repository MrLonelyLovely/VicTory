//
//  FastLoginView.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/11.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "FastLoginView.h"

@implementation FastLoginView
+(instancetype)fastLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
