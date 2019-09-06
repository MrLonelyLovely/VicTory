//
//  CusNavigationController.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/4.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "CusNavigationController.h"

@interface CusNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CusNavigationController

+ (void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:203/255.0 green:27/255.0 blue:69/255.0 alpha:1.0];
    [navBar setTitleTextAttributes:attrs];
    
    //设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    
#warning 没有成功
    /*
    //全屏滑动
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavgationTransition:)];
    
    [self.view addGestureRecognizer:panGes];
    //控制手势什么时候触发，只有非根控制器才需要触发手势
    panGes.delegate = self;
    //禁止之前的手势（边缘滑动手势）
    self.interactivePopGestureRecognizer.enabled = NO;
     */
}

-(void)handleNavgationTransition:(id)someThing
{
    
}
//如果不设置这个方法的话，应用程序就会进入假死状态：程序还在运行，但界面已经卡死了
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
#warning 这里为什么是大于1呢？而不是大于0呢？
    //只有非根控制器才需要触发手势
    return self.childViewControllers.count > 1;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        //只有在非根控制器中才创建返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImageString:@"navigationButtonReturn" highImageString:@"navigationButtonReturnClick" target:self action:@selector(back) title:@"返回"];
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
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
