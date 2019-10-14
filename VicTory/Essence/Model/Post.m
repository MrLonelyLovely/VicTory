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
    
    //底部工具条
    _cellHeight += 35;
    
    return _cellHeight;
}
@end
