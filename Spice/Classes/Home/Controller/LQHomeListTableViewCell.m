//
//  LQHomeListTableViewCell.m
//  Spice
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQHomeListTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation LQHomeListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(LQHomeListModel *)model{
    
    _model = model;
    
    _FocusTitleLabel.text = model.title;
    
    _DateTimeLabel.text = model.datetime;
    
    NSString *imagUrl = [model.image_list.firstObject objectForKey:@"url"];
    
    [_TitleImage sd_setImageWithURL:[NSURL URLWithString:imagUrl]];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    LQHomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell"];
    if ( cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LQHomeListTableViewCell" owner:nil options:nil].lastObject;
    }
    return cell;
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
