//
//  PostFourView.m
//  VicTory
//
//  Created by Apui on 2019/10/15.
//  Copyright © 2019 陈沛. All rights reserved.
//


//图片

#import "PostFourView.h"
#import "Post.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>
#import "SDImageCache.h"

@interface PostFourView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *getBigPicBtn;


@end

@implementation PostFourView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setPost:(Post *)post
{
    _post = post;
    
    //添加图片
    [self.imageView setRawImage:post.image1 thumbnail:post.image0 placeholder:nil];
    
    //gif
//    self.gifView.hidden = !post.is_gif;
    
//    if ([post.image1.lowercaseString hasSuffix:@"gif"]) {
    if ([post.image1.pathExtension.lowercaseString isEqualToString:@"gif"]) {
        self.gifView.hidden = NO;
    } else {
        self.gifView.hidden = YES;
    }
    
    //点击查看大/长图
    if (post.isLongPicture) {
        self.getBigPicBtn.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.getBigPicBtn.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
    
}

@end
