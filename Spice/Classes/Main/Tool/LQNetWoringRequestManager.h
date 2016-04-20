//
//  LQNetWoringRequestManager.h
//  Spice
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 spice. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求类型
typedef NS_ENUM(NSUInteger, RequestType) {
    POST,
    GET,
};

//请求成功
typedef void(^RequestSuccess)(NSData *data);

//请求失败
typedef void(^RequestError)(NSError *error);

@interface LQNetWoringRequestManager : NSObject


+ (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parmas:(NSDictionary *)parmas success:(RequestSuccess)success error:(RequestError)error;


@end
