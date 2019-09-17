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
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItem:(SquareItem *)item
{
    _item = item;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _nameLbl.text = item.name;
}
@end
