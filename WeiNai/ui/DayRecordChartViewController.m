//
//  DayRecordChartViewController.m
//  WeiNai
//
//  Created by Ji Fang on 7/25/15.
//  Copyright (c) 2015 Ji Fang. All rights reserved.
//

#import "DayRecordChartViewController.h"
#import "UUChart.h"
#import "EMActivityManager.h"
#import "EMDayRecord.h"
#import "DayRecordChart.h"

@interface DayRecordChartViewController ()<UUChartDataSource, UITableViewDataSource, UITableViewDelegate, DayRecordChartDelegate> {
    UITableView *_tableview;
    EMDayRecord *_dayRecord;
    DayRecordChart *_dayRecordChart;
    
    NSArray *_xArray;
    NSArray *_yArray;
}

- (void)setupUI;
- (void)configureCell:(UITableViewCell *)cell index:(NSInteger)index;
- (void)configureActivitySelectorCell:(UITableViewCell *)cell;
- (void)configureChartCell:(UITableViewCell *)cell;
- (void)activityTypeSelected:(id)sender;

@end

@implementation DayRecordChartViewController

- (id)init {
    if (self=[super init]) {
        _dayRecordChart = [[DayRecordChart alloc] init];
        _dayRecordChart.delegate = self;
    }
    
    return self;
}

- (void)dealloc {
    _dayRecordChart.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupUI];
}

#pragma mark - helpers
- (void)setupUI {
    _tableview = [[UITableView alloc] initWithFrame:self.view.bounds
                                              style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    [self.view addSubview:_tableview];
}

- (void)configureCell:(UITableViewCell *)cell index:(NSInteger)index {
    switch (index) {
        case 0: {
            [self configureActivitySelectorCell:cell];
        } break;
        case 1: {
            [self configureChartCell:cell];
        } break;
        default: {
        } break;
    }
}

- (void)configureActivitySelectorCell:(UITableViewCell *)cell {
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    EMActivityManager *activityman = [EMActivityManager sharedInstance];
    UISegmentedControl *typesSeg = [[UISegmentedControl alloc] initWithItems:
                                    @[[activityman ActivityType2String:ActivityType_Milk],
                                      [activityman ActivityType2String:ActivityType_Piss],
                                      [activityman ActivityType2String:ActivityType_Excrement],
                                      [activityman ActivityType2String:ActivityType_Sleep],
                                      ]];
    [typesSeg addTarget:self
                 action:@selector(activityTypeSelected:)
       forControlEvents:UIControlEventValueChanged];
    NSInteger segIndex = 0;
    typesSeg.selectedSegmentIndex = segIndex;
    CGRect frame = typesSeg.frame;
    frame.origin.x = (cell.contentView.frame.size.width - frame.size.width) / 2.0;
    frame.origin.y = (cell.contentView.frame.size.height - frame.size.height) / 2.0;
    typesSeg.frame = frame;
    [cell.contentView addSubview:typesSeg];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
}

- (void)configureChartCell:(UITableViewCell *)cell {
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    CGRect frame = cell.contentView.bounds;
    frame.origin.x -= 10;
    frame.size.height *= 4;
    UUChart *chart = [[UUChart alloc] initwithUUChartDataFrame:frame
                                                    withSource:self
                                                     withStyle:UUChartLineStyle];
    [cell.contentView addSubview:chart];
}

#pragma mark - UUChartDataSource
- (NSArray *)UUChart_xLabelArray:(UUChart *)chart {
    NSArray *ret = nil;
    
    ret = _xArray;
    
    return ret;
}

- (NSArray *)UUChart_yValueArray:(UUChart *)chart {
    NSArray *ret = nil;
    
    ret = @[_yArray];
    
    return ret;
}

- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

#pragma makr - tableview datasource/delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2; // one for activity type selector, one for chart.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger ret = 0;
    
    ret = 1;
    
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DayRecordCell";
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    [self configureCell:cell index:row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 1) {
        return 200;
    } else {
        return 44;
    }
}

#pragma mark - DayRecordChartDelegate
- (void)didActivityTypeChanged:(EMActivityType)activityType {
}

- (void)didDatasourceChangedXArray:(NSArray *)xArray yArray:(NSArray *)yArray {
    _xArray = xArray;
    _yArray = yArray;
    [_tableview reloadData];
}

#pragma mark - actions
- (void)activityTypeSelected:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *seg = (UISegmentedControl *)sender;
        NSInteger index = seg.selectedSegmentIndex;
        switch (index) {
            case 0: {
                _dayRecordChart.activityType = ActivityType_Milk;
            } break;
            case 1: {
                _dayRecordChart.activityType = ActivityType_Piss;
            } break;
            case 2: {
                _dayRecordChart.activityType = ActivityType_Excrement;
            } break;
            case 3: {
                _dayRecordChart.activityType = ActivityType_Sleep;
            } break;
            default: {
            } break;
        }
    }
}

//- (void)

@end
