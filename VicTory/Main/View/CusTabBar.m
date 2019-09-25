//
//  CusTabBar.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/3.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "CusTabBar.h"

#define BTN_TABBAR_BUTTON_H 49

//懒加载
@interface CusTabBar ()

@property (nonatomic,weak) UIButton *plusButton;
@property (nonatomic,weak) UIControl *previousClickedTabBarBtn;
@end

@implementation CusTabBar

-(UIButton *)plusButton
{
    if (!_plusButton) {
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [plusButton sizeToFit];
        _plusButton = plusButton;
        [self addSubview:plusButton];
    }
    return _plusButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //获取tabBar个数，为4个
    NSInteger count = self.items.count;
    CGFloat btnW = self.frame.size.width / (count + 1);
#warning TODO:适配
//    CGFloat btnH = self.frame.size.height - 30;
    CGFloat btnX = 0;
    
    NSInteger i = 0;
    //布局tabBarButton
//    NSLog(@"%@",self.subviews);
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            NSLog(@"%@",tabBarButton);
            
            //初始化第一个按钮
            if (i == 0 && self.previousClickedTabBarBtn == nil)
                self.previousClickedTabBarBtn = tabBarButton;
            
            if(i == 2) {
                i += 1;
            }
            btnX = i * btnW;
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, BTN_TABBAR_BUTTON_H);
            i++;
//            NSLog(@"%@",tabBarButton.superclass);
            
            //监听点击
            [tabBarButton addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    self.plusButton.center = CGPointMake(self.frame.size.width/2, BTN_TABBAR_BUTTON_H/2);
}

//处理重复点击tabBarBtn的操作
-(void)tabBarBtnClick:(UIControl *)tabBarBtn
{
    
    if(self.previousClickedTabBarBtn == tabBarBtn) {
//        NSLog(@"%s",__func__);
        //发出通知，告知外界tabBarButton被重复点击了
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CusTabBarBtnDidClickAgainNotification object:nil];
    }
    self.previousClickedTabBarBtn = tabBarBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
