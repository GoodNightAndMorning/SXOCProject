//
//  SXBaseViewController.h
//  SXBaseLayer
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXBaseViewController : UIViewController

/**
 点击导航栏返回按触发事件

 @return YES:返回，NO:不返回
 */
-(BOOL)backAction;
/**
 是否需要显示无网络提示页面
 YES：显示
 NO：不显示
 默认NO
 */
@property(nonatomic,assign)BOOL shouldSHowNetWorkFailView;

/**
 开启网络状态变化监听
 需在appdelegate中开启
 */
+(void)startNetMonitoring;

/**
 空视图
 */
@property (nonatomic, strong) UIView *emptyView;

/**
 加载数据，统一方法
 */
- (void)refreshData;
@end

