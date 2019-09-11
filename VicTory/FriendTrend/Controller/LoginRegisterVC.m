//
//  LoginRegisterVC.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/10.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "LoginRegisterVC.h"
#import "LoginRegisterView.h"
#import "UIView+Frame.h"
#import "FastLoginView.h"
@interface LoginRegisterVC ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation LoginRegisterVC
- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    //初始状态点击：向左平移middleView，距离为middle.width的一半
    //已有账号界面：向右平移middleView，距离为middle.width的一半
    _leadingConstraint.constant = _leadingConstraint.constant == 0 ? -self.middleView.cusWidth * 0.5 : 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoginRegisterView *loginView = [LoginRegisterView loginView];
    [self.middleView addSubview: loginView];
    
    LoginRegisterView *registerView = [LoginRegisterView registerView];
    [self.middleView addSubview:registerView];
    
    FastLoginView *fastLoginView = [FastLoginView fastLoginView];
    [self.bottomView addSubview:fastLoginView];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    LoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.cusWidth * 0.5, self.middleView.cusHeight);
    
    LoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.cusWidth * 0.5, 0, self.middleView.cusWidth * 0.5, self.middleView.cusHeight);

    FastLoginView *fastLoginView = self.bottomView.subviews.firstObject;
    fastLoginView.frame = self.bottomView.bounds;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
