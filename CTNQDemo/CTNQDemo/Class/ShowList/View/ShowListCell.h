//
//  ShowListCell.h
//  CTNQDemo
//
//  Created by 高赛 on 2017/3/8.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowListModel.h"

@interface ShowListCell : UITableViewCell

@property (nonatomic, strong) ShowListModel *model;

+ (instancetype)showListTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier;

@end
