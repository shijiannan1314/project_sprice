//
//  LQHomeListTableViewCell.h
//  Spice
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 spice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQHomeListModel.h"
@interface LQHomeListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *FocusTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *DateTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *TitleImage;

@property(nonatomic,strong)LQHomeListModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
