//
//  OneVC.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/19.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "OneVC.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "Post.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "PostCell.h"

@interface OneVC ()

@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, strong) NSMutableArray<Post *> *posts;

//@property (nonatomic, assign) NSUInteger page;
//当前最后一条帖子数据的描述信息，用于加载下一页的数据（更早的数据）
@property (nonatomic, copy) NSString *maxtime;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, weak) UIView *header;         //上拉刷新控件
@property (nonatomic, weak) UILabel *headerLbl;     //上拉刷新文字
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;  //下拉刷新控件是否正在刷新

@property (nonatomic, weak) UIView *footer;
@property (nonatomic, weak) UILabel *footerLbl;
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;

@end

@implementation OneVC

static NSString * const PostCellID = @"PostCellID";

//懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return  _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.dataCount = 5;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //对于iPhone xs/x
//    self.tableView.contentInset = UIEdgeInsetsMake(88, 0, 83, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(CusNavH + CusTitlesViewH, 0, CusTabBarH, 0);
//    NSLog(@"%f",CusNavH + CusTitlesViewH);
    //设置滚动条与显示的cell一致，避免也跟着cell穿透
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PostCell class]) bundle:nil] forCellReuseIdentifier:PostCellID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidClickedAgain) name:CusTabBarBtnDidClickAgainNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnDidClickedAgain) name:CusTitlerBtnDidClickAgainNotification object:nil];
    
    [self setupRefresh];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//上拉刷新加载更多
- (void)setupRefresh
{
    //header
    UIView *header = [[UIView alloc] init];
    header.frame = CGRectMake(0, -35, self.tableView.cusWidth, 35);
    self.header = header;
    [self.tableView addSubview:header];
    
    UILabel *headerLbl = [[UILabel alloc] init];
    headerLbl.frame = header.bounds;
    headerLbl.backgroundColor = [UIColor redColor];
    headerLbl.text = @"下拉刷新";
    headerLbl.textColor = [UIColor whiteColor];
    headerLbl.textAlignment = NSTextAlignmentCenter;
    [header addSubview:headerLbl];
    self.headerLbl = headerLbl;
    
    //让header 自动刷新（一次）
    [self headerBeginRefreshing];
    
//    self.tableView.tableHeaderView = header;
    
    //footer
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.cusWidth, 30);
    self.footer = footer;
    
    UILabel *footerLbl = [[UILabel alloc] init];
    footerLbl.frame = footer.bounds;
    footerLbl.backgroundColor = [UIColor redColor];
    footerLbl.text = @"上拉刷新";
    footerLbl.textColor = [UIColor whiteColor];
    footerLbl.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:footerLbl];
    self.footerLbl = footerLbl;
    
    self.tableView.tableFooterView = footer;
}

#pragma mark - 监听
//监听tabBarBtn的重复点击
-(void)tabBarBtnDidClickedAgain
{
    //如果重复点击的不是主页按钮，则直接返回
    if(self.view.window == nil) return;
    
    //如果显示的不是 全部 对应的界面，则直接返回
    if(self.tableView.scrollsToTop == NO) return;
    
//    NSLog(@"%s",__func__);
    [self headerBeginRefreshing];
}

//监听titleBtn的重复点击
-(void)titleBtnDidClickedAgain
{
    [self tabBarBtnDidClickedAgain];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击cell后灰色高亮会逐渐变淡消失
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.footer.hidden = (self.posts.count == 0);
    return self.posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    Post *post = self.posts[indexPath.row];
    cell.textLabel.text = post.name;
    cell.detailTextLabel.text = post.text;
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd",self.class, indexPath.row];
    */
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:PostCellID];
    
    cell.post = self.posts[indexPath.row];
    
    return cell;
}

#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f",self.tableView.contentOffset.y);
    //处理header的操作
    [self handleHeader];
    
    //处理footer的操作
    [self handleFooter];
}

//（拖到合适的位置，）用户松开scrollView时调用该方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //如果正在下拉刷新，则直接返回 (避免修改的内边距不断增大)
    if(self.isHeaderRefreshing) return;
    
    //下拉时偏移量为负数
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.cusHeight);
    if (self.tableView.contentOffset.y <= offsetY) {
//        CusLogFunc;
        [self headerBeginRefreshing];
    }
}

//处理cell的高度
/*
 默认情况下，
 每次刷新表格时，有多少数据，此方法就一次性调用多少次（比如有100条数据，每次reloadData，这个方法就会一次性调用100次）；
 每当有cell进入屏幕视野范围内（上拉或者下拉），就会调用一次此方法。
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 398;
    return self.posts[indexPath.row].cellHeight;
}

#pragma mark - hanlde refresh

-(void)handleHeader
{
    //如果正在下拉刷新，则直接返回
    if(self.isHeaderRefreshing) return;
    
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.cusHeight);
    if (self.tableView.contentOffset.y <= offsetY) {  //header已经完全出现
        self.headerLbl.text = @"松开立即刷新";
        self.headerLbl.backgroundColor = [UIColor grayColor];
    } else {
        self.headerLbl.text = @"下拉刷新";
        self.headerLbl.backgroundColor = [UIColor redColor];
    }
}

-(void)handleFooter
{
    //还没有任何内容时，不需要判断
    if(self.tableView.contentSize.height == 0) return;
    
    //如果正在刷新，直接返回（避免多次刷新，发送请求数据操作）
    if(self.isFooterRefreshing) return;
    
    //当tableView的偏移量y值 >= offsetY时，代表footer已经完全出现
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.cusHeight;
    
    //&& self.tableView.contentOffset.y > -123
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > -123) {
        //footer完全出现 且 是往上拽的时候
        //进入刷新状态（操作）
        [self footerBeginRefreshing];
    }
}

#pragma mark - header
-(void)headerBeginRefreshing
{
    //如果正在下拉刷新，则直接返回
    if(self.isHeaderRefreshing) return;
    
    //进入下拉刷新状态
    self.headerLbl.text = @"正在刷新...";
    self.headerLbl.backgroundColor = [UIColor blueColor];
    self.headerRefreshing = YES;
    //增加内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.header.cusHeight;
        self.tableView.contentInset = inset;
        
#warning question 1
        //修改偏移量 ？？？
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, - inset.top);
    }];
    
    [self loadNewPosts];
}

//结束刷新
-(void)headerEndRefreshing
{
    //1.标志状态要改为NO
    //2.减少内边距
    //3.将文字还原 这一步可以不用写
    //1.
    self.headerRefreshing = NO;
    
    //2.
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.header.cusHeight;
        self.tableView.contentInset = inset;
    }];
    
    //3.
    //            self.headerLbl.text = @"下拉刷新";
    //            self.headerLbl.backgroundColor = [UIColor redColor];
}

#pragma mark - footer
//进入刷新状态
-(void)footerBeginRefreshing
{
    //如果正在上拉刷新，直接返回（避免多次刷新，发送请求数据操作）
    if(self.isFooterRefreshing) return;
    
    self.footerRefreshing = YES;
    self.footerLbl.text = @"正在刷新";
    self.footerLbl.backgroundColor = [UIColor blueColor];
    
    //发送请求给服务器
    [self loadMorePosts];
}

-(void)footerEndRefreshing
{
    self.footerRefreshing = NO;
    self.footerLbl.text = @"上拉刷新";
    self.footerLbl.backgroundColor = [UIColor redColor];
}

#pragma mark - 刷新数据处理
//发送请求给服务器，下拉刷新数据
-(void)loadNewPosts
{
    //发送请求给服务器，下拉刷新数据
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //取消之前（上拉）的请求任务, 避免与下拉冲突
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"list";
    para[@"c"] = @"data";
    para[@"type"] = @"1";
//    para[@"mintime"] = @"";
    
    [self.manager GET:CusCommonURL parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//        NSLog(@"请求成功 - %@", responseObject);
        [responseObject writeToFile:@"/Users/dylanchan/Desktop/VicTory/VicTory/Essence/newPosts.plist" atomically:YES];
        
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 -> 模型数组 (直接覆盖）
        self.posts = [Post mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
//        NSMutableArray *newPosts = [Post mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        if (self.posts) {
//            [self.posts insertObjects:newPosts atIndexes:[NSIndexSet indexSetWithIndex:0]];
//        } else {
//            self.posts = newPosts;
//        }
        
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self headerEndRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败 - %@", error);
        if (error.code != NSURLErrorCancelled) {
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
        //结束刷新
        [self headerEndRefreshing];
    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //服务器的数据回来了
//        self.dataCount = 20;
//        [self.tableView reloadData];
//
//        //结束刷新
//        [self headerEndRefreshing];
//    });
}

//发送请求给服务器，上拉加载更多数据
-(void)loadMorePosts
{
    //发送请求给服务器 - 加载更多数据
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //取消之前（下拉）的请求任务, 避免与上拉冲突
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"list";
    para[@"c"] = @"data";
    para[@"type"] = @"1";
    para[@"maxtime"] = self.maxtime;
    
//    para[@"page"] = @(self.page + 1);
    
    [self.manager GET:CusCommonURL parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id   _Nullable responseObject) {
        //NSLog(@"请求成功 - %@", responseObject);
        [responseObject writeToFile:@"/Users/dylanchan/Desktop/VicTory/VicTory/Essence/morePosts.plist" atomically:YES];
        
        //更新maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 -> 模型数组
        NSArray *morePosts = [Post mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //累加
        [self.posts addObjectsFromArray:morePosts];
        
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self footerEndRefreshing];
        
//        self.page = [para[@"page"] integerValue];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"请求失败 - %@", error);
        if (error.code != NSURLErrorCancelled) {
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
        //结束刷新
        [self footerEndRefreshing];
    }];
    
//    NSLog(@"发送请求给服务器 - 加载更多数据");
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //服务器请求回来了
//        self.dataCount += 5;
//        [self.tableView reloadData];
//
//        //结束刷新
//        [self footerEndRefreshing];
//    });
}

@end
