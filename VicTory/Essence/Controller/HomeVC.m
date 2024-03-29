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

@interface HomeVC () <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
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
    
    [self addChildVcIntoScrollView:0];
    
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
    
    scrollView.delegate = self;
    
    //不允许自动修改UIScrollView的内边距
    scrollView.contentInsetAdjustmentBehavior = NO;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO;   //点击状态栏时，scrollView不会滚动到顶部
    [self.view addSubview:scrollView];
    
    self.scrollView = scrollView;
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
//    CGFloat scrollViewH = scrollView.cusHeight;
//
//    for (NSInteger i=0; i<count; i++) {
//        UIView *childVCView = self.childViewControllers[i].view;
//        childVCView.frame = CGRectMake(i * scrollViewW, -88, scrollViewW, scrollViewH);
//        [scrollView addSubview:childVCView];
//    }
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
    
//    NSLog(@"%@",NSStringFromCGRect([[UIViewController alloc] init].view.frame));
//    NSLog(@"%@",NSStringFromCGRect([[UITableViewController alloc] init].view.frame));
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
        titleBtn.tag = i;
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
//点击标题按钮
- (IBAction)titleBtnClick:(CusTitleButton *)titleBtn
{
    //处理重复点击标题按钮进行刷新对应界面
#warning bug found - 点击cell，自动调用了titleBtnClick方法  found:2019-10-10 but not handled
    if (self.previousTitleBtnClicked == titleBtn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CusTitlerBtnDidClickAgainNotification object:nil];
    }
    
    [self dealTitleBtnClick:titleBtn];
}

//处理标题按钮点击
-(void)dealTitleBtnClick:(CusTitleButton *)titleBtn
{
    //切换按钮状态
    self.previousTitleBtnClicked.selected = NO;
    titleBtn.selected = YES;
    self.previousTitleBtnClicked = titleBtn;
        
    [UIView animateWithDuration:0.25 animations:^{
    //        self.titleUnderLine.cusWidth = [titleBtn.currentTitle sizeWithFont:titleBtn.titleLabel.font].width;
    //        self.titleUnderLine.cusWidth = [titleBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName : titleBtn.titleLabel.font}].width;
    
        //处理下划线的滚动
        self.titleUnderLine.cusWidth = titleBtn.titleLabel.cusWidth + 10;
        self.titleUnderLine.cusCenterX = titleBtn.cusCenterX;
            
    //        NSInteger index = [self.titlesView.subviews indexOfObject:titleBtn];
    //        NSLog(@"%ld",(long)index);
    //        CGFloat offsetX = self.scrollView.cusWidth * index;

        //滚动scrollView
        CGFloat offsetX = self.scrollView.cusWidth * titleBtn.tag;
    //        NSLog(@"%ld",(long)titleBtn.tag);
        //通过确定点标来确定偏移量
    #warning bug - cell显示有bug
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        //添加子控制器的view
        [self addChildVcIntoScrollView:titleBtn.tag];
        /*
        //添加子控制器的view
        UIView *childView = self.childViewControllers[titleBtn.tag].view;
        childView.frame = CGRectMake(titleBtn.tag * self.scrollView.cusWidth, -88, self.scrollView.cusWidth, self.scrollView.cusHeight);
        [self.scrollView addSubview:childView];
        */
    }];
        
    //设置index对应位置的tableView.scrollsToTop = YES，其他都设置为NO
    for (NSInteger i=0; i<self.childViewControllers.count; i++) {
        UIViewController *childVC = self.childViewControllers[i];
        //如果view还没有被创建，就不用去处理
        if(!childVC.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVC.view;
        if(![scrollView isKindOfClass:[UIScrollView class]]) continue;
        scrollView.scrollsToTop = (i == titleBtn.tag);
    }
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //求出标题按钮的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.cusWidth;
    
    //点击对应的标题按钮
    CusTitleButton *titleBtn = self.titlesView.subviews[index];
//    CusTitleButton *titleBtn = [self.titlesView viewWithTag:index];  //这个会报错
//    [self titleBtnClick:titleBtn];
    [self dealTitleBtnClick:titleBtn];
}

#pragma mark - other functions

-(void)addChildVcIntoScrollView:(NSInteger)index
{
    UIViewController *childVC = self.childViewControllers[index];
    if(childVC.isViewLoaded) return;
    
    //取出index位置对应的子控制器view
    UIView *childVCView = childVC.view;
//    if(childVCView.superview) return;
//    if(childVCView.window) return;
    
    //设置子控制器view的frame
    CGFloat scrollViewW = self.scrollView.cusWidth;
    childVCView.frame = CGRectMake(index * self.scrollView.cusWidth, -88, self.scrollView.cusWidth, self.scrollView.cusHeight);
    //添加子控制器的view到scrollView中
    [self.scrollView addSubview:childVCView];
}


@end
