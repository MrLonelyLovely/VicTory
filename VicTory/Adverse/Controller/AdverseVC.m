//
//  AdverseVC.m
//  VicTory
//
//  Created by 陈沛 on 2019/9/5.
//  Copyright © 2019 陈沛. All rights reserved.
//

#import "AdverseVC.h"
#import <AFNetworking/AFNetworking.h>
#import "AdItem.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "TabBarController.h"
#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface AdverseVC ()
@property (weak, nonatomic) IBOutlet UIImageView *LaunchImageView;
@property (weak, nonatomic) IBOutlet UIView *AdverseContainView;

@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property (nonatomic,weak) UIImageView *adView;
@property (nonatomic,strong) AdItem *item;
@property (nonatomic,weak) NSTimer *timer;

@end

@implementation AdverseVC
- (IBAction)jumpBtnClick:(id)sender {
    //销毁广告界面，进入tabBar界面
    TabBarController *tabBarVC = [[TabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    //销毁定时器
    [_timer invalidate];
}


/*
//销毁广告界面，进入tabBar界面
TabBarController *tabBarVC = [[TabBarController alloc]init];
[UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
//销毁定时器
[_timer invalidate];
*/
-(UIImageView *)adView
{
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.AdverseContainView addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        _adView = imageView;
    }
    return _adView;
}

-(void)tapClick
{
    //跳转到广告详情页面 Safari
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:_item.winurl];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#warning 这里有一个屏幕适配的问题呀呀呀呀呀呀
    //设置启动图片之后的广告图片
#warning 这里设置为空字符串就可以正常显示了 为什么呀呀呀呀呀呀呀
    //好像还是有个显示的bug惹
    _LaunchImageView.image = [UIImage imageNamed:@""];
    
    //加载广告数据
    [self loadAdverseData];
    
    //创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

-(void)timeChange
{
//    NSLog(@"%s",__func__);
    static int i = 3;
    if (i == 0) {
        [self jumpBtnClick:nil];
    }
    i--;
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳转（%d）",i] forState:UIControlStateNormal];
}

-(void)loadAdverseData
{
    /*
     报错：Error Domain=com.alamofire.error.serialization.response Code=-1016
     "Request failed: unacceptable content-type: text/html"
     解决办法：找到AFJSONResponseSerializer方法里在对应位置上添加上@"text/html"
    */
    //创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //拼接参数
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"code2"] = code2;
    //发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/dylanchan/Desktop/VicTory/VicTory/Adverse/Adverse.plist" atomically:YES];
        
        //请求数据 -> 解析数据(写成plist文件) -> 设计模型 -> 字典转模型 -> 展示数据
        //获取字典
        NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        //字典转模型
        _item = [AdItem mj_objectWithKeyValues:adDict];
        //创建UIImageView展示图片
//        CGFloat h = SCREEN_W / item.w * item.h;
        self.adView.frame = CGRectMake(0, 0,SCREEN_W , SCREEN_H);
        //加载广告界面
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
//        NSLog(@"%@",_item);
//        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 http://mobads.baidu.com/cpro/ui/mads.php ?
 code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
 */

@end
