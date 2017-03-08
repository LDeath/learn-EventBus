//
//  ShowGoodListViewController.m
//  CTNQDemo
//
//  Created by 高赛 on 2017/3/8.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "ShowGoodListViewController.h"
#import "ANHttpTool.h"
#import "ShowListModel.h"
#import "ShowListCell.h"
#import "AddGoodVC.h"

@interface ShowGoodListViewController ()<UITableViewDelegate, UITableViewDataSource, EventAsyncSubscriber>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ShowGoodListViewController

#pragma 懒加载
- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma 生命周期
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    EVENT_CHECK(self, @"addGoods");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [ANNotificationCenter addObserver:self selector:@selector(netWork) name:@"loginSuccess" object:nil];
//    EVENT_CHECK(self, @"addGoods");
    EVENT_SUBSCRIBE(self, @"addGoods");
    if (kMobile) {
        [self netWork];
    }
}
#pragma 自定义方法
- (void)setNav {
    self.title = @"物品列表";
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGood)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}
- (void)addGood {
    AddGoodVC *addGoodVC = [[AddGoodVC alloc] init];
    [self.navigationController pushViewController:addGoodVC animated:YES];
}
#pragma EventSyncSubscriber
- (void)eventOccurred:(NSString *)eventName event:(Event *)event {
    ShowListModel *model = event.eventData;
    [self.dataArr insertObject:model atIndex:0];
    [self.tableView reloadData];
}
#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowListCell *cell = [ShowListCell showListTableView:tableView andIdentifier:@"showListCell"];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
#pragma 网络请求
- (void)netWork {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"user_type"];
    [params setObject:@"0" forKey:@"g_type"];
    [ANHttpTool postWithUrl:@"goodmobile/getGoodList" params:params successBlock:^(NSURLSessionDataTask *operation, id responseObject) {
        ANLog(@"%@",responseObject);
        self.dataArr = [ShowListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
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
- (void)dealloc {
    [ANNotificationCenter removeObserver:self];
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
