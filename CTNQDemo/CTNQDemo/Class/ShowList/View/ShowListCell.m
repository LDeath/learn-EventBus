//
//  ShowListCell.m
//  CTNQDemo
//
//  Created by 高赛 on 2017/3/8.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "ShowListCell.h"

@interface ShowListCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ShowListCell

+ (instancetype)showListTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier {
    
    ShowListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShowListCell" owner:nil options:nil].lastObject;
    }
    return cell;
    
}

- (void)setModel:(ShowListModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.titleLabel.text = [NSString stringWithFormat:@"物品名称:%@",model.g_name];
    self.describeLabel.text = [NSString stringWithFormat:@"物品描述:%@",model.g_describe];
    self.locationLabel.text = [NSString stringWithFormat:@"丢失位置:%@",model.g_location];
    self.timeLabel.text = [NSString stringWithFormat:@"丢失时间:%@",model.g_losetime];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
