//
//  TabBarController.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/3.
//  Copyright © 2019 陈沛. All rights reserved.
//

/*
 在创建tabBarController自定义类时，找不到对应父类，
 解决办法：菜单栏->product->clean build folder->build
 */
#import "TabBarController.h"
#import "HomeVC.h"
#import "NewVC.h"
#import "FriendTrendVC.h"
#import "MeTVC.h"
#import "PublishVC.h"
#import "UIImage+Image.h"
#import "CusTabBar.h"
#import "CusNavigationController.h"

@interface TabBarController ()

@end

@implementation TabBarController
//只会调用一次
+ (void)load
{
    /*
     appearance
     1.需遵守UIAppearance协议
     2.哪些属性可通过appearance设置：只有被UI_APPEARANCE_SELECTOR宏修饰的属性，才能设置
     3.只能在控件显示之前设置，才有作用
     4.使用场景：如夜间模式
     */
    //获取整个应用程序下的UITabBarItem（包括其他子控制器下的），所以不建议用这个
//    UITabBarItem *item = [UITabBarItem appearance];
    
    //获取哪个类中的UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //设置底部按钮标题的颜色:富文本：描述一个文字颜色，字体，阴影，空心，图文混排
    //创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:50];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    //设置字体尺寸:只有正常状态下（unselected状态下），才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
    
}

////可能会调用多次
//+ (void)initialize
//{
//    //要判断
//    if (self == [TabBarController class]) {
//        <#statements#>
//    }
//}
/*
 问题：
 1.选中按钮的图片被渲染
   ->原因：iOS7以后默认tabBar上的按钮图片都会被渲染
   -> 解决办法：1.修改图片（Assets.xcassets选中图片，右框属性栏Render as->Original Image） 2.通过代码
 2.选中按钮的标题颜色应该是黑色 标题字体过小 ->tabBarItem
 3.发布按钮显示不出来
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///2.1 添加子控制器
    [self addAllChildViewController];
    
    //2.2 设置tabBar上按钮内容 ->tabBarItem
    [self setupAllButton];
    
    //调整系统TabBar上按钮的位置，均分五等份，再把加号（发布）按钮显示在中间就好
    //调整系统自带控件的子控件的位置 -> 只能通过自定义tabBar
    //要保证在TabBarButton添加上去前，将UITabBar替换为CusTabBar
    [self setupTabBar];

//    NSLog(@"%@",self.tabBar.subviews);
}

//系统的tabBarButton在viewWillAppear时添加到self.tabBar
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog(@"%@",self.tabBar.subviews);
//}

#pragma mark - 添加所有子控制器
- (void) addAllChildViewController
{
    HomeVC *homeVC = [[HomeVC alloc] init];
    CusNavigationController *nav1 = [[CusNavigationController alloc] initWithRootViewController:homeVC];
    [self addChildViewController:nav1];
    
    NewVC *newVC = [[NewVC alloc] init];
    CusNavigationController *nav2 = [[CusNavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:nav2];
    
    /*
    PublishVC *publishVC = [[PublishVC alloc] init];
    //    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:publishVC];
    [self addChildViewController:publishVC];
    */
    
    FriendTrendVC *friendTrendVC = [[FriendTrendVC alloc] init];
    CusNavigationController *nav4 = [[CusNavigationController alloc] initWithRootViewController:friendTrendVC];
    [self addChildViewController:nav4];
    
    MeTVC *meTVC = [[MeTVC alloc] init];
    CusNavigationController *nav5 = [[CusNavigationController alloc] initWithRootViewController:meTVC];
    [self addChildViewController:nav5];
}

- (void) setupAllButton
{
    UINavigationController *nav1 = self.childViewControllers[0];
    nav1.tabBarItem.title = @"主页";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithStringName:@"tabBar_essence_click_icon"];
    
    UINavigationController *nav2 = self.childViewControllers[1];
    nav2.tabBarItem.title = @"新帖";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalWithStringName:@"tabBar_new_click_icon"];
    
//    UIViewController *publishVC = self.childViewControllers[2];
////    publishVC.tabBarItem.title = @"发布";
//    publishVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
//    publishVC.tabBarItem.selectedImage = [UIImage imageOriginalWithStringName:@"tabBar_publish_click_icon"];
//    publishVC.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    UINavigationController *nav4 = self.childViewControllers[2];
    nav4.tabBarItem.title = @"关注";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithStringName:@"tabBar_friendTrends_click_icon"];
    
    UINavigationController *nav5 = self.childViewControllers[3];
    nav5.tabBarItem.title = @"我";
    nav5.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav5.tabBarItem.selectedImage = [UIImage imageOriginalWithStringName:@"tabBar_me_click_icon"];
}

- (void) setupTabBar
{
    CusTabBar *ctabBar = [[CusTabBar alloc] init];
    
    /*
     系统的UITabBar对应的tabBar是readOnly属性，不能通过点语法将当前的tabBar置为CusTabBar
     但可用KVC
     */
    [self setValue:ctabBar forKeyPath:@"tabBar"];
    
//    NSLog(@"%@",self.tabBar);
//    NSLog(@"%@",ctabBar);
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

