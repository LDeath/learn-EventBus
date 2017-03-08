//
//  LoginVC.m
//  asf
//
//  Created by 高赛 on 2017/3/7.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "ANHttpTool.h"
#import "LoginModel.h"

@interface LoginVC ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (nonatomic, strong) LoginModel *model;

@end

@implementation LoginVC

#pragma 懒加载
- (LoginModel *)model {
    if (_model == nil) {
        _model = [[LoginModel alloc] init];
    }
    return _model;
}
#pragma 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma 自定义方法
- (IBAction)clickLoginBtn:(id)sender {
    
    if ([self.userText.text isEqualToString:@""]) {
        [ANCommon setAlertViewWithMessage:@"请输入账号"];
        return;
    } else if ([self.pwdText.text isEqualToString:@""]) {
        [ANCommon setAlertViewWithMessage:@"请输入密码"];
        return;
    }
    [self netWork];
}
- (IBAction)clickRegisterBtn:(id)sender {
    
    RegisterVC *registerVC = [[RegisterVC alloc] init];
    registerVC.block = ^(NSString *mobile,NSString *pwd){
        self.userText.text = mobile;
        self.pwdText.text = pwd;
    };
    [self presentViewController:registerVC animated:YES completion:nil];
    
}
#pragma 网络请求
- (void)netWork {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.userText.text forKey:@"mobile"];
    [params setObject:self.pwdText.text forKey:@"userpassword"];
    [ANHttpTool postWithUrl:@"clientmobile/loginByClient" params:params successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        [[ANCommon alloc] setAlertView:responseObject[@"message"]];
        self.model = [LoginModel mj_objectWithKeyValues:responseObject[@"data"]];
        [[NSUserDefaults standardUserDefaults] setObject:self.model.mobile forKey:@"mobile"];
        [[NSUserDefaults standardUserDefaults] setObject:[self.model.ID stringValue] forKey:@"ID"];
        [ANNotificationCenter postNotificationName:@"loginSuccess" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    } errorBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        ANLog(@"%@",responseObject);
        [ANCommon setAlertViewWithMessage:responseObject[@"message"]];
    } failBlock:^(NSURLSessionDataTask *operation, NSError *error) {
        ANLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
