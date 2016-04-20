//
//  LQVedion.h
//  Spice
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 spice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQVedion : NSObject


/** 视频播放地址 */
@property(nonatomic, copy) NSString *first_url;
/** 视频播放标题 */
@property(nonatomic, copy) NSString *title;
/** 视频播放时长 */
@property(nonatomic, copy) NSNumber *play_time;
/** 视频播放次数 */
@property(nonatomic, copy) NSNumber *play_count;
/** 视频播放缩略图 */
@property(nonatomic, copy) NSString *image;
/** 视频评论次数 */
@property(nonatomic, copy) NSNumber *comment_count;
/** 视频点赞次数 */
@property(nonatomic, copy) NSNumber *vote_count;



@end
