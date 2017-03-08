//
//  RegisterVC.h
//  asf
//
//  Created by 高赛 on 2017/3/7.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^callBlock)(NSString *mobile,NSString *pwd);

@interface RegisterVC : UIViewController

@property (nonatomic, copy) callBlock block;

@end
