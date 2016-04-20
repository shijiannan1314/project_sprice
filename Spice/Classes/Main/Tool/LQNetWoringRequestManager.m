//
//  LQNetWoringRequestManager.m
//  Spice
//
//  Created by lanou3g on 16/4/16.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQNetWoringRequestManager.h"

@implementation LQNetWoringRequestManager


+ (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parmas:(NSDictionary *)parmas success:(RequestSuccess)success error:(RequestError)error{
    LQNetWoringRequestManager *manager = [[LQNetWoringRequestManager alloc] init];
    
    [manager requestWithType:type urlString:urlString parmas:parmas success:success errorReq:error];
}


//网络请求方法
- (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parmas:(NSDictionary *)parmas success:(RequestSuccess)success errorReq:(RequestError)errorReq{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (type == POST) {
        [request setHTTPMethod:@"POST"];
        if (parmas.count > 0) {
            NSData *data = [self parDicToDataWithDic:parmas];
            [request setHTTPBody:data];
        }
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            success(data);
        }
        if (error) {
            errorReq(error);
        }
    }];
    [task resume];
}


//将参数列表格式化
- (NSData *)parDicToDataWithDic:(NSDictionary *)dic{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *key in dic) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",key, dic[key]];
        [array addObject:str];
    }
    NSString *parString = [array componentsJoinedByString:@"&"];
    NSData *data = [parString dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;
    
}







@end
