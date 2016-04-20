//
//  LQVedioCell.m
//  Spice
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQVedioCell.h"
#import "LQVedion.h"
#import <UIImageView+WebCache.h>
@interface LQVedioCell ()

@property (weak, nonatomic) IBOutlet UIImageView *vedioImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *vontLabel;


@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;


@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *playButton;


@end


@implementation LQVedioCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}


- (void)setVedio:(LQVedion *)vedio{
    _vedio = vedio;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.vedioImage sd_setImageWithURL:[NSURL URLWithString:self.vedio.image] placeholderImage:nil];
    self.titleLabel.text = self.vedio.title;
//    self.titleLabel.text = @"hhgghgfgfg";
//    self.titleLabel.backgroundColor = [UIColor redColor];
    self.playCountLabel.text = [NSString stringWithFormat:@"%@", self.vedio.play_count];
    self.commentCountLabel.text = [NSString stringWithFormat:@"%@", self.vedio.comment_count];
    self.vontLabel.text = [NSString stringWithFormat:@"%@", self.vedio.vote_count];

}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *reuseID = @"cell";
    LQVedioCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LQVedioCell" owner:nil options:nil] firstObject];
    }
    return cell;
}










@end
