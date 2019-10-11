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

@end

@implementation PostCell

- (void) setPost:(Post *)post
{
    _post = post;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:post.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nickNameLbl.text = post.name;
    self.launchTimeLbl.text = post.passtime;
    self.textLbl.text = post.text;
    
    [self setupBtmBtn:self.likeBtn number:post.ding placeholder:@"赞"];
    [self setupBtmBtn:self.dislikeBtn number:post.cai placeholder:@"弹"];
    [self setupBtmBtn:self.commentBtn number:post.comment placeholder:@"评论"];
    [self setupBtmBtn:self.shareBtn number:post.repost placeholder:@"分享"];

    
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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
