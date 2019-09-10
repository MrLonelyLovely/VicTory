//
//  LoginRegisterVC.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/10.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "LoginRegisterVC.h"
#import "LoginRegisterView.h"
@interface LoginRegisterVC ()
@property (weak, nonatomic) IBOutlet UIView *middleView;

@end

@implementation LoginRegisterVC
- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    LoginRegisterView *loginView = [LoginRegisterView loginView];
//    [self.middleView addSubview: loginView];
    
    LoginRegisterView *registerView = [LoginRegisterView registerView];
    [self.middleView addSubview:registerView];
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
