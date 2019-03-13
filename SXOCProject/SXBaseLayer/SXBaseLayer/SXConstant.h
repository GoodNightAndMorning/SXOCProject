//
//  SXConstant.h
//  SXBaseLayer
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019年 zsx. All rights reserved.
//

#ifndef SXConstant_h
#define SXConstant_h

#define WeakSelf __weak typeof(self) weakSelf
#define StrongSelf __strong typeof(weakSelf) strongSelf

#define APP_WIDTH [UIScreen mainScreen].bounds.size.width
#define APP_HEIGHT [UIScreen mainScreen].bounds.size.height

#define FONT_SIZE24 [UIFont systemFontOfSize:24]

#define COLOR_GRAY [UIColor colorWithRed:99.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:1.0]
#endif /* SXConstant_h */
