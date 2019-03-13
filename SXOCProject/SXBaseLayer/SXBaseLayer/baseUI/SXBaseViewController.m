//
//  SXBaseViewController.m
//  SXBaseLayer
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import "SXBaseViewController.h"
#import "SXConstant.h"
#import <AFNetworking.h>
@interface SXBaseViewController ()
@property(nonatomic,assign)BOOL hasNet;
@property(nonatomic,strong)UIView *noNetView;
@end

@implementation SXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavi];
    //网络控制
    [self initNetControl];

}
-(void)refreshData {
    
}
-(BOOL)backAction {
    return YES;
}
#pragma mark - 设置navigationController
-(void)setUpNavi{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    UIImage *icon = [UIImage imageNamed:@"leftkey"];
    icon = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationController.navigationBar setBackIndicatorImage:icon];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:icon];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}
#pragma mark - 没有网络处理代码
+(void)startNetMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
-(void)initNetControl {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChangeAction:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    _hasNet = [AFNetworkReachabilityManager sharedManager].reachable;
    WeakSelf;
    dispatch_after(DISPATCH_TIME_NOW + 0.5, dispatch_get_main_queue(), ^{
        StrongSelf;
        if (!strongSelf.hasNet && strongSelf.shouldSHowNetWorkFailView) {
            
            [strongSelf.view addSubview:strongSelf.noNetView];
        }
    });
}
-(void)netWorkChangeAction:(NSNotification *)noti {
    if (!_hasNet && [AFNetworkReachabilityManager sharedManager].reachable && self.shouldSHowNetWorkFailView){
        [self.noNetView removeFromSuperview];
    }
}
- (UIView *)noNetView {
    if (!_noNetView) {
        _noNetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
        _noNetView.backgroundColor = [UIColor whiteColor];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (APP_HEIGHT - 424.0/750.0 * APP_WIDTH) / 2 - 150, APP_WIDTH, 424.0/750.0 * APP_WIDTH)];
        
        imageView.image = [UIImage imageNamed:@"NoNetWork_icon.png" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        
        [_noNetView addSubview:imageView];
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, _noNetView.frame.size.width, 25)];
        lb.text = @"抱歉！暂无网络";
        lb.font = FONT_SIZE24;
        lb.textColor = COLOR_GRAY;
        lb.textAlignment = NSTextAlignmentCenter;
        
        [_noNetView addSubview:lb];
    }
    return _noNetView;
}
#pragma mark - 无数据提示页面
- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
        _emptyView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_emptyView];
        _emptyView.hidden = YES;
        
        UIImageView * emptyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (APP_HEIGHT - 424.0/750.0 * APP_WIDTH) / 2 - 150, APP_WIDTH, 424.0/750.0 * APP_WIDTH)];
        
        emptyImageView.image = [UIImage imageNamed:@"empty_icon.png" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
        
        [_emptyView addSubview:emptyImageView];
        
        UILabel * emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(emptyImageView.frame)+10, _emptyView.frame.size.width, 25)];
        emptyLabel.text = @"抱歉！暂无数据";
        emptyLabel.font = FONT_SIZE24;
        emptyLabel.textColor = COLOR_GRAY;
        emptyLabel.textAlignment = NSTextAlignmentCenter;
        
        [_emptyView addSubview:emptyLabel];
        
    }
    return _emptyView;
}
@end
