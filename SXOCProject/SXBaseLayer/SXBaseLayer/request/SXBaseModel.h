//
//  SXBaseModel.h
//  SXBaseLayer
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXBaseModel : NSObject
@property(nonatomic,assign)int code;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong)id data;
@end

