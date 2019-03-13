//
//  SXRequest.h
//  SXBaseLayer
//
//  Created by apple on 2019/3/13.
//  Copyright © 2019年 zsx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SXBaseModel;
typedef void(^SuccessCallBack)(SXBaseModel *respone);
typedef void(^FailureCallBack)(NSError *error);

@interface SXRequest : NSObject

@end

