//
//  AddGoodVC.m
//  CTNQDemo
//
//  Created by 高赛 on 2017/3/8.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "AddGoodVC.h"
#import "ANHttpTool.h"
#import "ShowListModel.h"

@interface AddGoodVC ()<EventAsyncPublisher>

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *ppText;
@property (weak, nonatomic) IBOutlet UITextField *colorText;
@property (weak, nonatomic) IBOutlet UITextField *locationText;
@property (weak, nonatomic) IBOutlet UITextField *timeText;
@property (weak, nonatomic) IBOutlet UITextField *featureText;
@property (weak, nonatomic) IBOutlet UITextField *describeText;

@property (weak, nonatomic) IBOutlet UIImageView *loseType;
@property (weak, nonatomic) IBOutlet UIImageView *collectType;
@property (weak, nonatomic) IBOutlet UIImageView *storeType;
@property (weak, nonatomic) IBOutlet UIImageView *otherType;
@property (weak, nonatomic) IBOutlet UIView *dateTime;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@property (nonatomic, copy) NSString *selectType;
@property (nonatomic, copy) NSString *selectDateTime;

@property (nonatomic, strong) NSMutableArray *typeArr;

@end

@implementation AddGoodVC

#pragma 懒加载
- (NSMutableArray *)typeArr {
    if (_typeArr == nil) {
        _typeArr = [NSMutableArray arrayWithObjects:self.loseType,self.collectType,self.storeType,self.otherType, nil];
    }
    return _typeArr;
}

#pragma 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.selectType = @"1";
    [self setNav];
}
#pragma 自定义方法
- (void)setNav {
    self.title = @"添加物品";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addGood)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = rightBtn;
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addGood {
    if ([self.nameText.text isEqualToString:@""]) {
        [ANCommon setAlertViewWithMessage:@"请输入物品名称"];
        return;
    } else if ([self.ppText.text isEqualToString:@""]) {
        [ANCommon setAlertViewWithMessage:@"请输入物品品牌"];
        return;
    } else if ([self.colorText.text isEqualToString:@""]) {
        [ANCommon setAlertViewWithMessage:@"请输入物品颜色"];
        return;
    } else if ([self.locationText.text isEqualToString:@""]) {
        [ANCommon setAlertViewWithMessage:@"请输入丢失地点"];
        return;
    } else if ([self.timeText.text isEqualToString:@""]) {
        [ANCommon setAlertViewWithMessage:@"请输入丢失时间"];
        return;
    }
    [self netWork];
}
- (IBAction)clickTypeBtn:(UIButton *)sender {
    for (int i = 10001; i < 10005; i++) {
        UIImageView *imageV = self.typeArr[i - 10001];
        if (sender.tag == i) {
            imageV.image = [UIImage imageNamed:@"select_circle_Icon"];
            self.selectType = [NSString stringWithFormat:@"%d",i - 10000];
        } else {
            imageV.image = [UIImage imageNamed:@"unselect_circle_Icon"];
        }
    }
}
- (IBAction)showTimeView:(id)sender {
    self.dateTime.hidden = NO;
    [self.view endEditing:YES];
}
- (IBAction)hiddenTimeView:(id)sender {
    self.dateTime.hidden = YES;
}
- (IBAction)sureTimeView:(id)sender {
    self.dateTime.hidden = YES;
    self.timeText.text = [self.datePicker.date getDateYYYYMMddHHmm];
}

#pragma 网络请求
- (void)netWork {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.nameText.text forKey:@"name"];
    [params setObject:self.ppText.text forKey:@"g_pp"];
    [params setObject:self.colorText.text forKey:@"g_color"];
    [params setObject:self.featureText.text forKey:@"g_feature"];
    [params setObject:self.locationText.text forKey:@"location"];
    [params setObject:self.timeText.text forKey:@"losetime"];
    [params setObject:@"117.141807" forKey:@"latitude"];
    [params setObject:@"36.694826" forKey:@"lontitude"];
    [params setObject:self.selectType forKey:@"user_type"];
    [params setObject:kID forKey:@"userid"];
    [params setObject:self.describeText.text forKey:@"describe"];
    
    [ANHttpTool postWithUrl:@"goodmobile/addGoodInfo" params:params successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        ANLog(@"%@",responseObject);
        [ANCommon setAlertViewWithMessage:responseObject[@"message"]];
        ShowListModel *model = [ShowListModel mj_objectWithKeyValues:responseObject[@"data"]];
        EVENT_PUBLISH_WITHDATA(self, @"addGoods", model);
//        EVENT_PUBLISH(self, @"addGoods");
    } errorBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        ANLog(@"%@",responseObject);
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
