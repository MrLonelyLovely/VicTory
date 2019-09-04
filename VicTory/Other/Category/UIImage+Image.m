//
//  UIImage+Image.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/3.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)
+ (UIImage *)imageOriginalWithStringName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
