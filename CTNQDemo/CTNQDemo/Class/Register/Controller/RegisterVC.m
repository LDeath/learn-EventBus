//
//  RegisterVC.m
//  asf
//
//  Created by 高赛 on 2017/3/7.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "RegisterVC.h"
#import "ANHttpTool.h"
#import "RegisterModel.h"

@interface RegisterVC ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) RegisterModel *model;

@end

@implementation RegisterVC

#pragma 懒加载
- (UIAlertView *)alertView {
    if (_alertView == nil) {
        _alertView = [[UIAlertView alloc] initWithTitle:@"注册成功" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"马上登陆", nil];
    }
    return _alertView;
}
- (RegisterModel *)model {
    if (_model == nil) {
        _model = [[RegisterModel alloc] init];
    }
    return _model;
}

#pragma 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        self.block(self.model.mobile,self.pwdText.text);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma 自定义方法
- (IBAction)clickBackBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickRegisterBtn:(id)sender {
    if ([self.userText.text isEqualToString:@""]) {
        [ANCommon setAlertViewWithMessage:@"请输入账号"];
        return;
    } else if ([self.pwdText.text isEqualToString:@""]) {
        [ANCommon setAlertViewWithMessage:@"请输入密码"];
        return;
    }
    [self netWork];
}
#pragma 网络请求
- (void)netWork{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.userText.text forKey:@"mobile"];
    [params setObject:self.pwdText.text forKey:@"userpassword"];
    [ANHttpTool postWithUrl:@"clientmobile/addUser" params:params successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        
        self.model = [RegisterModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.alertView.message = responseObject[@"message"];
        [self.alertView show];
        
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
