//
//  PostThreeView.m
//  VicTory
//
//  Created by Apui on 2019/10/15.
//  Copyright © 2019 陈沛. All rights reserved.
//

//声音

#import "PostThreeView.h"
#import "Post.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking/AFNetworking.h>
#import "SDImageCache.h"


@interface PostThreeView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLbl;


@end
@implementation PostThreeView

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
    
    //播放数量和播放时长
    if (post.playcount >= 10000) {
        self.playCountLbl.text = [NSString stringWithFormat:@"%.1f万播放", post.playcount / 10000.0];
    } else {
        self.playCountLbl.text = [NSString stringWithFormat:@"%zd万播放",post.playcount];
    }
    
    // %04d : 占据4位，多余的空位用0填补
    self.voiceTimeLbl.text = [NSString stringWithFormat:@"%02zd:%02zd",post.voicetime / 60, post.voicetime % 60];
}

@end
