//
//  LQVedioCell.h
//  Spice
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 spice. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQVedion;
@interface LQVedioCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic, strong)LQVedion *vedio;

@end
