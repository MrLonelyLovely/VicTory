//
//  FastLoginBtn.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/11.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "FastLoginBtn.h"

@implementation FastLoginBtn

-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片位置
    self.imageView.cusY = 0;
    self.imageView.cusCenterX = self.cusWidth * 0.5;
    
    //设置标题位置
    self.titleLabel.cusY = self.cusHeight - self.titleLabel.cusHeight;
    //计算文字宽度，设置label宽度
    [self.titleLabel sizeToFit];
    self.titleLabel.cusCenterX = self.cusWidth * 0.5;
}

@end
