//
//  LoginModel.h
//  CTNQDemo
//
//  Created by 高赛 on 2017/3/8.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, copy) NSString *creatime;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *userpassword;

@end
