//
//  SubTagCell.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/9.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "SubTagCell.h"
#import "SubTagItem.h"
#import <UIImageView+WebCache.h>
@interface SubTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *numLbl;

@end

@implementation SubTagCell
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    //这个方法才是真正给cell赋值,记得要调用
    [super setFrame:frame];
    
}
- (void)setItem:(SubTagItem *)item
{
    _item = item;
    
    _nameLbl.text = item.theme_name;
    
    [self handleNum];
    //设置占位图
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
-(void)handleNum
{
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",_item.sub_number];
    NSInteger num = _item.sub_number.integerValue;  //string转为integer
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];  //.1f 表示保留小数点后一位数字
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];   //将x.0转为x
    }
    _numLbl.text = numStr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //方法一：代码实现
//    _iconView.layer.cornerRadius = _iconView.frame.size.width / 2;
//    _iconView.layer.masksToBounds = YES;
    
    //方法二：在cell的对应xib中的右侧identity inspector中的user defined runtime attribute 中添加,但此方法不推荐
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
