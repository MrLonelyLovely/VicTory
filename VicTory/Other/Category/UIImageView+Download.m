//
//  UIImageView+Download.m
//  VicTory
//
//  Created by Apui on 2019/10/16.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "UIImageView+Download.h"
#import <AFNetworkReachabilityManager.h>
#import <UIImageView+WebCache.h>
#import <SDWebImage.h>

//#import <AppKit/AppKit.h>


@implementation UIImageView (Download)

- (void)setRawImage:(NSString *)rawImageURL thumbnail:(NSString *)thumbnailURL placeholder:(UIImage *)placeholder
{

    //根据不同的网络状态加载不同质量的图片
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //从disk（亦即是沙盒）中获得原图，SDWebCache的图片缓存是用图片的url字符串作为key）
    UIImage *rawImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:rawImageURL];
    if (rawImage) {
        self.image = rawImage;
    } else {
        if (manager.isReachableViaWiFi)
            [self sd_setImageWithURL:[NSURL URLWithString:rawImageURL] placeholderImage:placeholder];
        else if (manager.isReachableViaWWAN)
            /*
             flag = 4G下也加载原图
             if(flag) 下载原图
             */
            [self sd_setImageWithURL:[NSURL URLWithString:thumbnailURL] placeholderImage:placeholder];
        else {   //没有可用网络
            //缩略图
            UIImage *thumbnail = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailURL];
            if (thumbnail)     //缩略图已经被下载过
                self.image = thumbnail;
            else      //没有下载过任何图片
                self.image = placeholder;
        }
    }
}

//设置圆形头像
- (void)setRoundImageView
{
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
}

@end
