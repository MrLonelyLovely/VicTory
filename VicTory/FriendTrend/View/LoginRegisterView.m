//
//  LoginRegisterView.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/10.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "LoginRegisterView.h"

@interface LoginRegisterView()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
@implementation LoginRegisterView

+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    //让按钮背景图片不要被拉伸
    UIImage *image = _loginBtn.currentBackgroundImage;
#warning budong
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [_loginBtn setBackgroundImage:image forState:UIControlStateNormal];
}

@end
