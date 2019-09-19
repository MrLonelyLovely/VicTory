//
//  MeTVC.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/2.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "MeTVC.h"
#import "SettingsVC.h"
#import <AFNetworking/AFNetworking.h>
#import "SquareItem.h"
#import <MJExtension/MJExtension.h>
#import "CollectionViewCell.h"

static NSString * const CollectionID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH  (SCREEN_W - (cols - 1) * margin) / cols

@interface MeTVC ()<UICollectionViewDataSource>
@property (nonatomic, strong)NSArray *squareItems;
@property (nonatomic, weak)UICollectionView *collectionView;
@end

@implementation MeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setupNavBar];
    
    //设置tableView底部视图
    [self setupFooterView];
    
    //展示cell的内容 -> 请求数据（查看接口文档）
    [self loadData];
    
    //处理cell间距，默认tableView分组样式，有额外头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

-(void)loadData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"square";
    para[@"c"] = @"topic";
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        [responseObject writeToFile:@"/Users/dylanchan/Desktop/VicTory/VicTory/Me/square.plist" atomically:YES];
        
        NSArray *dicArr = responseObject[@"square_list"];
        _squareItems = [SquareItem mj_objectArrayWithKeyValuesArray:dicArr];
        
//        [self resloveData];
        
        //计算collectionView高度 = rows * itemWH
        //行数 - rows = （count - 1) / cols + 1
        NSInteger count = self.squareItems.count;
        NSInteger rows = (count -1) / cols + 1;
        self.collectionView.cusHeight = rows * itemWH;
        //设置tableView滚动范围（高度）
        //这样可以的原因是 tableview不需要手动管理滚动，之前设置高度为300
        self.tableView.tableFooterView = self.collectionView;
        
        //以下这个方法有bug
//        self.tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.collectionView.frame));
        
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 处理请求完的数据
//-(void)resloveData
//{
//    NSInteger count = self.squareItems.count;
//    NSInteger extra = count % cols;
//    if (extra) {
//        extra = cols - extra;
//        for (int i=0; i<extra; i++) {
//            SquareItem *item = [[SquareItem alloc] init];
//            [self.squareItems addObject:item];
//        }
//    }
//}

#pragma mark - 设置tableView底部视图
-(void)setupFooterView
{
    //这里不是UICollectionViewLayout，而应该是UICollectionViewFlowLayout !!!!!
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell尺寸
    
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;   //横向的间距，对于从左到右，从上到下的布局
    layout.minimumLineSpacing = margin;        //纵向的间距，对于从左到右，从上到下的布局
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    
    self.tableView.tableFooterView = collectionView;
    
    collectionView.dataSource = self;
    collectionView.scrollEnabled = NO;
    //注册cell
    /*
     两种注册cell的方法：
     1.从对应的xib中加载
     2.系统的
     */
    [collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CollectionID];
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //从缓存池去取
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.item = self.squareItems[indexPath.row];
    return cell;
}

- (void)setupNavBar
{
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImageString:@"mine-setting-icon" highImageString:@"mine-setting-icon-click" target:self action:@selector(settingsClick)];
    
    UIBarButtonItem *nightModeItem = [UIBarButtonItem itemWithImageString:@"mine-moon-icon" selectedImageString:@"mine-moon-icon-click" target:self action:@selector(beNight:)];
    
//    UIBarButtonItem *nightModelItem = UIBarButtonItem item
    self.navigationItem.rightBarButtonItems = @[settingItem,nightModeItem];
    
//    [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:nil];
    
    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.navigationItem.title = @"我的";
    
    /*
     只要是通过模型设置，都是通过富文本来设置
     设置导航条标题（内容除外） -> UINavigationBar
     */
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:203/255.0 green:27/255.0 blue:69/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    /*
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:203/255.0 green:27/255.0 blue:69/255.0 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:attrs];
    */
}

-(void)settingsClick
{
    SettingsVC *settingsVC = [[SettingsVC alloc]init];
    //必须要在跳转到settingsVC界面之前设置该属性
    settingsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingsVC animated:YES];
    
    /*
     底部条没有隐藏
     处理返回按钮样式
     */
}

//按钮的选中状态必须要通过手动来设置才能有效
-(void)beNight:(UIButton *)button
{
    button.selected = !button.selected;
}

@end
