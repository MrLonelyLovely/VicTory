//
//  Post.m
//  VicTory
//
//  Created by Apui on 2019/9/27.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "Post.h"

@implementation Post

- (CGFloat)cellHeight
{
    //如果已经计算过，就直接返回
    if(_cellHeight) return _cellHeight;
    
    //文字的Y值
    _cellHeight += 55;
    
    //文字的高度
    CGSize textMaxSize = CGSizeMake(SCREEN_W - 20, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height + 20;
    
    //中间的内容
    //1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
    if (self.type != 29) {
        /*
        self.width     middleW
        ----------- == -------
        self.height    middleH
        
        self.width * middleH == middleW * self.height
        */
        
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        CGFloat middleY = _cellHeight;
        CGFloat middleX = 10;
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellHeight += middleH + 10;
    }
    
    //最热评论
    if (self.top_cmt.count) {
        //标题
        _cellHeight += 17;
        
        //内容
        NSDictionary *comment = self.top_cmt.firstObject;
        NSString *content = comment[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = comment[@"user"][@"username"];
        NSString *commentText = [NSString stringWithFormat:@"%@ : %@", username, content];
        _cellHeight += [commentText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height + 20;
    }
    
    //底部工具条
    _cellHeight += 35;
    
    return _cellHeight;
}
@end
