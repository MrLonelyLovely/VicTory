//
//  HomeVC.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/2.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "HomeVC.h"
#import "CusTitleButton.h"
#import "OneVC.h"
#import "TwoVC.h"
#import "ThreeVC.h"
#import "FourVC.h"
#import "FiveVC.h"

@interface HomeVC ()
@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) UIView *titleUnderLine;
@property (nonatomic, weak) CusTitleButton *previousTitleBtnClicked;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllChildVCs];
    
    [self setupNavBar];
    
    [self setupScrollView];
    
    [self setupTitlesView];
    
    
    
}

//初始化5个子控制器
- (void)setupAllChildVCs
{
    [self addChildViewController:[[OneVC alloc] init]];
    [self addChildViewController:[[TwoVC alloc] init]];
    [self addChildViewController:[[ThreeVC alloc] init]];
    [self addChildViewController:[[FourVC alloc] init]];
    [self addChildViewController:[[FiveVC alloc] init]];

}
- (void)setupNavBar
{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageString:@"nav_item_game_icon" highImageString:@"nav_item_game_click_icon" target:self action:@selector(clickGame)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageString:@"navigationButtonRandom" highImageString:@"navigationButtonRandomClick" target:self action:nil];
    
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.navigationItem.title = @"Victory";
    /*
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:203/255.0 green:27/255.0 blue:69/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:attrs];
    */
}

- (void)setupScrollView
{
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.frame = self.view.bounds;
    //不允许自动修改UIScrollView的内边距
    scrollView.contentInsetAdjustmentBehavior = NO;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
//    for (NSInteger i = 0; i < 5; i++) {
//        UITableView *tableView = [[UITableView alloc] init];
//        tableView.cusWidth = scrollView.cusWidth;
//        tableView.cusHeight = scrollView.cusHeight;
//        tableView.cusY = 0;
//        tableView.cusX = i * scrollView.cusWidth;
//        tableView.backgroundColor = RandomColor;
//        [scrollView addSubview:tableView];
//    }
    
    NSInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.cusWidth;
    CGFloat scrollViewH = scrollView.cusHeight;
    
    for (NSInteger i=0; i<count; i++) {
        UIView *childVCView = self.childViewControllers[i].view;
        childVCView.frame = CGRectMake(i * scrollViewW, -88, scrollViewW, scrollViewH);
        [scrollView addSubview:childVCView];
    }
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
    
    NSLog(@"%@",NSStringFromCGRect([[UIViewController alloc] init].view.frame));
    NSLog(@"%@",NSStringFromCGRect([[UITableViewController alloc] init].view.frame));
}

- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //    titlesView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    
    //    titlesView.alpha = 0.5;  //不要这样设置
    titlesView.frame = CGRectMake(0, 88, self.view.cusWidth, 35);
    [self.view addSubview:titlesView];
    
    self.titlesView = titlesView;
    
    [self setTitleButtons];
    
    [self setTitleUnderLine];
}

- (void)setTitleButtons
{
    NSArray *titles = @[@"全部", @"视频", @"音频", @"图片", @"小文"];
    NSInteger count = titles.count;
    
    for (NSInteger i = 0; i < count; i++) {
        CusTitleButton *titleBtn = [[CusTitleButton alloc] init];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleBtn];
        titleBtn.frame = CGRectMake(i * (SCREEN_W / 5), 0, SCREEN_W / 5, self.titlesView.cusHeight);
        
//        titleBtn.backgroundColor = RandomColor;
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        
//        titleBtn.highlighted = NO;   //这样并不能取消按钮的高亮状态
    }
}

- (void)setTitleUnderLine
{
    //获得第一个按钮
    CusTitleButton *firstTitleBtn = self.titlesView.subviews.firstObject;
    
#warning question - 为什么这里的宽度打印是 0 呢？
//    NSLog(@"%f",firstTitleBtn.titleLabel.cusWidth);
    
    UIView *titleUnderLine = [[UIView alloc] init];
    titleUnderLine.cusHeight = 2;
    titleUnderLine.cusY = self.titlesView.cusHeight - titleUnderLine.cusHeight;
    titleUnderLine.backgroundColor = [firstTitleBtn titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderLine];
    self.titleUnderLine = titleUnderLine;
    
    //调用点击按钮响应方法，初始化第一个按钮的状态
    [firstTitleBtn.titleLabel sizeToFit];  //加这一行代码就可以显示下划线了，因为会强制先算出来lbl的宽度
    [self titleBtnClick:firstTitleBtn];
}

#pragma mark - btn selector

- (void)titleBtnClick:(CusTitleButton *)titleBtn
{
    self.previousTitleBtnClicked.selected = NO;
    titleBtn.selected = YES;
    self.previousTitleBtnClicked = titleBtn;
    
    [UIView animateWithDuration:0.1 animations:^{
//        self.titleUnderLine.cusWidth = [titleBtn.currentTitle sizeWithFont:titleBtn.titleLabel.font].width;
//        self.titleUnderLine.cusWidth = [titleBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName : titleBtn.titleLabel.font}].width;
        self.titleUnderLine.cusWidth = titleBtn.titleLabel.cusWidth + 10;
        self.titleUnderLine.cusCenterX = titleBtn.cusCenterX;
    }];
}



/*
- (void)titleBtnClick:(CusTitleButton *)titleBtn
{
    [self.previousTitleBtnClicked setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.previousTitleBtnClicked = titleBtn;
}
*/
- (void)clickGame
{
    NSLog(@"%s",__func__);
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
