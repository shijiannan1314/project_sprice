//
//  LQtJokeTableViewCell.h
//  Spice
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 spice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQtJokeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *MainLabel;
@property (weak, nonatomic) IBOutlet UIImageView *MainImage;
@property (weak, nonatomic) IBOutlet UIButton *ding;
@property (weak, nonatomic) IBOutlet UIButton *cai;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIButton *Other;

@end
