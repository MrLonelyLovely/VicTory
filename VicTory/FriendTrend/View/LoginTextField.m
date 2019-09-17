//
//  LoginTextField.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/11.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "LoginTextField.h"
#import "UITextField+Placeholder.h"

@implementation LoginTextField

/*
 1.文本框光标变成baise
 2.文本框开始编辑时，占位文字颜色变成白色
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];
    
    //监听文本编辑: 1.代理 2.通知 3.target
    //开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    //结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    //方法2
    self.placeholderColor = [UIColor redColor];
    
    
    /*方法1
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
     */
}

//文本框开始编辑调用
-(void)textBegin
{
    //方法2
    //设置占位文字颜色变成白色
    self.placeholderColor = [UIColor whiteColor];
    
    /*方法1
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
     */
}

-(void)textEnd
{
    //方法2
    self.placeholderColor = [UIColor redColor];

    /*方法1
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
     */
}
@end
