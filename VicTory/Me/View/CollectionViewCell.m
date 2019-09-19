//
//  CollectionViewCell.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/17.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "CollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "SquareItem.h"

@interface CollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *meIconView;
@property (weak, nonatomic) IBOutlet UILabel *meNameLbl;



@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItem:(SquareItem *)item
{
    _item = item;
    
#warning terrible mistake !!!!!
//    [_meIconView sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:[UIImage imageNamed:@"meDefaultIcon"]];
//    _meNameLbl.text = item.name;
//    NSLog(@"%@",item.icon);
//    NSLog(@"%@",item);
}

/*
if([[NSString stringWithFormat:@"%@",[user.name class]] isEqualToString:@"__NSCFString"]){
    //user.name的json数据没有双引号，格式为_NSCFString
    user.userName = [NSString stringWithFormat:@"%@",user.name];
}
*/
@end
