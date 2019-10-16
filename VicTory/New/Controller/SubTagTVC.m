//
//  SubTagTVC.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/9.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "SubTagTVC.h"
#import <AFNetworking/AFNetworking.h>
#import "SubTagItem.h"
#import <MJExtension/MJExtension.h>
#import "SubTagCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

static NSString * const ID = @"cell";
@interface SubTagTVC ()
@property (nonatomic, strong) NSArray *subTags;
@property (nonatomic, weak) AFHTTPSessionManager *mgr;

@end

@implementation SubTagTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"SubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.title = @"推荐标签";
    
    //处理cell分割线,长度小于屏幕的宽度了
    /*
     方法1.自定义分割线
     方法2.利用系统属性(但只支持iOS8以上的）
     方法3.重写cell的setFrame方法
     */
    
    /*方法2
    //清空tableView分割线内边距 再去清空cell的约束边缘
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
     //然后在SubTagCell.m 的 awakeFromNib 中
     self.layoutMargins = UIEdgeInsetsZero;
     */
    
    /*方法3
     1.取消系统自带分割线
     2.把tableView背景色设置为分割线的背景色
     3.重写setFrame
     */
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:220/250.0 green:220/250.0 blue:221/250.0 alpha:1];
    
    //提示用户当前正在加载数据  SVProgressHUD (2.2.5)
    [SVProgressHUD showWithStatus:@"正在加载中...."];
    
}

/*打印分割线的上 左 下 右的间距
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.separatorInset));
}
 */

//界面即将消失时调用
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //销毁指示器
    [SVProgressHUD dismiss];
    //取消之前的请求
    [_mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}
-(void)loadData
{
    //1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    _mgr = mgr;
    //2.拼接参数
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"tag_recommend";
    para[@"action"] = @"sub";
    para[@"c"] = @"topic";

    //模拟网络延迟2秒（再去执行发送请求）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //3.发送请求
        [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            
            [responseObject writeToFile:@"/Users/dylanchan/Desktop/VicTory/VicTory/New/tag.plist" atomically:YES];
            
//            NSLog(@"%@",responseObject);
            //字典数组转换成模型数组
            _subTags = [SubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
            
            //啊 记得要刷新表格
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
        }];
    });
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.subTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    SubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
//    NSLog(@"%p",cell);
//    if(cell == nil){
//        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SubTagCell class]) owner:nil options:nil][0];
//    }
    
    SubTagItem *item = self.subTags[indexPath.row];
    cell.item = item;
//    cell.textLabel.text = item.theme_name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
