//
//  TwoVC.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/19.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "TwoVC.h"

@interface TwoVC ()

@end

@implementation TwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RandomColor;
    
    self.tableView.contentInset = UIEdgeInsetsMake(CusNavH, 0, CusTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarBtnDidClickedAgain) name:CusTabBarBtnDidClickAgainNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleBtnDidClickedAgain) name:CusTitlerBtnDidClickAgainNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    return 30;
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

@end
