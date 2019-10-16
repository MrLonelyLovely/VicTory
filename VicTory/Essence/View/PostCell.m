//
//  PostCell.m
//  VicTory
//
//  Created by Apui on 2019/10/11.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"
#import <UIImageView+WebCache.h>

#import "PostTwoView.h"
#import "PostThreeView.h"
#import "PostFourView.h"

@interface PostCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *launchTimeLbl;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *textLbl;

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *dislikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UILabel *hottestCommentLbl;
@property (weak, nonatomic) IBOutlet UIView *hottestCommentView;

// 中间控件
// 视频控件
@property (nonatomic, weak) PostTwoView *videoView;   //two
// 声音控件
@property (nonatomic, weak) PostThreeView *voiceView;   //three
// 图片控件
@property (nonatomic, weak)  PostFourView *pictureView;    //four



@end

@implementation PostCell

#pragma mark - 懒加载

- (PostTwoView *)videoView
{
    if (!_videoView) {
        PostTwoView *videoView = [PostTwoView cusViewFromXIb];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (PostThreeView *)voiceView
{
    if (!_voiceView) {
        PostThreeView *voiceView = [PostThreeView cusViewFromXIb];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (PostFourView *)pictureView
{
    if (!_pictureView) {
        PostFourView *pictureView = [PostFourView cusViewFromXIb];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}





#pragma mark - 添加post内容
- (void) setPost:(Post *)post
{
    _post = post;
    
    //顶部控件的数据
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:post.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nickNameLbl.text = post.name;
    self.launchTimeLbl.text = post.passtime;
    self.textLbl.text = post.text;
    
    //底部按钮的文字
    [self setupBtmBtn:self.likeBtn number:post.ding placeholder:@"赞"];
    [self setupBtmBtn:self.dislikeBtn number:post.cai placeholder:@"弹"];
    [self setupBtmBtn:self.commentBtn number:post.comment placeholder:@"评论"];
    [self setupBtmBtn:self.shareBtn number:post.repost placeholder:@"分享"];

    //最热评论
    if (post.top_cmt.count) {   //有最热评论
        self.hottestCommentView.hidden = NO;
        
        NSDictionary *comment = post.top_cmt.firstObject;
        NSString *content = comment[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = comment[@"user"][@"username"];
        self.hottestCommentLbl.text = [NSString stringWithFormat:@"%@ : %@",username, content];
    } else {     //没有最热评论
        self.hottestCommentView.hidden = YES;
    }
    
    //中间的图片内容
    //1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
    if (post.type == 10) {  //图片
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    } else if (post.type == 31) {    //音频
        self.voiceView.hidden = NO;
#warning point - 记得要传模型数据过来
        self.voiceView.post = post;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if(post.type == 41) {       //视频
        self.videoView.hidden = NO;
        self.videoView.post = post;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    } else if (post.type == 29) {  //避免循环利用的cell错乱
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
}

//处理中间控件的位置大小
- (void)layoutSubviews
{
    if (self.post.type == 10) {  //图片
        self.pictureView.frame = self.post.middleFrame;
    } else if (self.post.type == 31) {    //音频
        self.voiceView.frame = self.post.middleFrame;
    } else if(self.post.type == 41) {       //视频
        self.videoView.frame = self.post.middleFrame;
    }
}

- (void)setupBtmBtn:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    } else {   //赞数为0时
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置圆形头像
    [_headImageView setRoundImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    //调整cell之间垂直间距
    frame.size.height -= 10;
    
    [super setFrame:frame];
}

@end
