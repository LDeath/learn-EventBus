//
//  MyViewController.m
//  test
//
//  Created by 高赛 on 2017/3/9.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "MyViewController.h"
#import "EventBus.h"
#import "EventPublisher.h"
#import "EventSubscriber.h"

@interface MyViewController ()<UITableViewDelegate, UITableViewDataSource, EventAsyncPublisher, EventAsyncSubscriber>

@property (weak, nonatomic) IBOutlet UITableView *subScriberTableView;
@property (weak, nonatomic) IBOutlet UITableView *publisherTableView;

@property (nonatomic, strong) NSMutableArray *subScriberArr;
@property (nonatomic, strong) NSMutableArray *publisherArr;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, assign) int num;

@end

@implementation MyViewController

- (NSMutableArray *)subScriberArr {
    if (_subScriberArr == nil) {
        _subScriberArr = [NSMutableArray array];
    }
    return _subScriberArr;
}
- (NSMutableArray *)publisherArr {
    if (_publisherArr == nil) {
        _publisherArr = [NSMutableArray array];
    }
    return _publisherArr;
}
- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
- (void)eventOccurred:(NSString *)eventName event:(Event *)event {
    NSLog(@"%@",eventName);
}
- (void)eventsOccurred:(NSArray *)eventNames event:(NSArray *)events {
    for (NSString *str in eventNames) {
        NSLog(@"%@",str);
    }
}
- (IBAction)clickCleanBtn:(id)sender {
    self.num = 0;
    [self.subScriberArr removeAllObjects];
    [self.publisherArr removeAllObjects];
    [self.dataArr removeAllObjects];
    [self.subScriberTableView reloadData];
    [self.publisherTableView reloadData];
}
/**
 接收订阅
 */
- (IBAction)clickReceiveSubscriberBtn:(id)sender {
    EVENT_CHECK_ANY(self, self.dataArr);
//    [self.dataArr removeAllObjects];
}
/**
 发布订阅
 */
- (IBAction)clickPublisherBtn:(id)sender {
    NSString *str = [NSString stringWithFormat:@"订阅%d",self.num++];
    [self.dataArr addObject:str];
//    [self.dataArr insertObject:str atIndex:0];
    EVENT_SUBSCRIBE(self, str);
    NSString *subscribeStr = [NSString stringWithFormat:@"添加%@",str];
    [self.subScriberArr insertObject:subscribeStr atIndex:0];
    [self.subScriberTableView reloadData];
    
    EVENT_PUBLISH_WITHDATA(self, str, @"啦啦啦,发布订阅了");
    EVENT_PUBLISH_WITHDATA_LIFE(self, str, @"啦啦啦,发布订阅了", 1);
    NSString *publisherStr = [NSString stringWithFormat:@"发布%@",str];
    [self.publisherArr insertObject:publisherStr atIndex:0];
    [self.publisherTableView reloadData];
}
#pragma tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.subScriberTableView) {
        return self.subScriberArr.count;
    } else {
        return self.publisherArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.subScriberTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subScriberCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"subScriberCell"];
        }
        NSString *str = self.subScriberArr[indexPath.row];
        cell.textLabel.text = str;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"publisherCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"publisherCell"];
        }
        NSString *str = self.publisherArr[indexPath.row];
        cell.textLabel.text = str;
        return cell;
    }
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
