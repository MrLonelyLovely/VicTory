//
//  FriendTrendVC.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/2.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "FriendTrendVC.h"
#import "LoginRegisterVC.h"

@interface FriendTrendVC ()

@end

@implementation FriendTrendVC
- (IBAction)loginBtnClick:(id)sender {
    LoginRegisterVC *loginRegisterVC = [[LoginRegisterVC alloc] init];
    [self presentViewController:loginRegisterVC animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
}

- (void)setupNavBar
{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageString:@"friendsRecommentIcon" highImageString:@"friendsRecommentIconClick" target:self action:nil];
    
    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.navigationItem.title = @"我的关注";
    /*
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:203/255.0 green:27/255.0 blue:69/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:attrs];
    */
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
