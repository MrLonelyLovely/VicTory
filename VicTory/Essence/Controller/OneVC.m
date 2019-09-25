//
//  OneVC.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/19.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "OneVC.h"

@interface OneVC ()
@property (nonatomic, assign) NSInteger dataCount;
@property (nonatomic, weak) UIView *footer;
@property (nonatomic, weak) UILabel *footerLbl;
@property (nonatomic, assign, getter=isfooterRefreshing) BOOL footerRefreshing;

@end

@implementation OneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataCount = 30;
    
    self.view.backgroundColor = RandomColor;
    
    //对于iPhone xs/x
//    self.tableView.contentInset = UIEdgeInsetsMake(88, 0, 83, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(CusNavH, 0, CusTabBarH, 0);
    //设置滚动条与显示的cell一致，避免也跟着cell穿透
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
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
    
    NSLog(@"%s",__func__);
}

//监听titleBtn的重复点击
-(void)titleBtnDidClickedAgain
{
    [self tabBarBtnDidClickedAgain];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.footer.hidden = (_dataCount == 0);
    return self.dataCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd",self.class, indexPath.row];
    
    return cell;
}

#pragma mark - delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //还没有任何内容时，不需要判断
    if(self.tableView.contentSize.height == 0) return;
    
    //如果正在刷新，直接返回（避免多次刷新，发送请求数据操作）
    if(self.isfooterRefreshing) return;
    
    //当tableView的偏移量y值 >= offsetY时，代表footer已经完全出现
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.cusHeight;
    
    if (self.tableView.contentOffset.y >= offsetY) {
        //进入刷新状态（操作）
        self.footerRefreshing = YES;
        self.footerLbl.text = @"正在刷新";
        self.footerLbl.backgroundColor = [UIColor blueColor];
        
        //发送请求给服务器
        NSLog(@"发送请求给服务器 - 加载更多数据");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //服务器请求回来了
            self.dataCount += 5;
            [self.tableView reloadData];
            
            //结束刷新
            self.footerRefreshing = NO;
            self.footerLbl.text = @"上拉刷新";
            self.footerLbl.backgroundColor = [UIColor redColor];
        });
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
