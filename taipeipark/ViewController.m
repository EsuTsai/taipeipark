//
//  ViewController.m
//  taipeipark
//
//  Created by Esu Tsai on 2017/4/12.
//  Copyright © 2017年 Esu Tsai. All rights reserved.
//

#import "ViewController.h"
#import "TPDataRequest.h"
#import "TPParkTableViewCell.h"
#import <Masonry.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *resultParkData;
@property (nonatomic, strong) UITableView *parkTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareView];
    [self prepareData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareView
{
    _parkTableView                    = [[UITableView alloc] init];
    _parkTableView.delegate           = self;
    _parkTableView.dataSource         = self;
    _parkTableView.estimatedRowHeight = 80.f;
    _parkTableView.rowHeight          = UITableViewAutomaticDimension;
    [self.view addSubview:_parkTableView];
    
    [_parkTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

- (void)prepareData
{
    NSString *apiUrl = @"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812";
    
    [[TPDataRequest sharedInstance] apiGetWithPath:apiUrl params:nil needFailureAlert:YES success:^(NSArray *successData) {
        _resultParkData = successData;
        [_parkTableView reloadData];
        //
    } failure:nil completion:^{
        //
    }];
}

#pragma mark - UITableViewDataSourece
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; //optional
{
    return [_resultParkData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TPParkTableViewCell";
    
    TPParkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell                = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setContent:[_resultParkData objectAtIndex:indexPath.section]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *parkSectionName        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 64)];
    parkSectionName.backgroundColor = [UIColor whiteColor];
    parkSectionName.text            = [[_resultParkData objectAtIndex:section] objectForKey:@"ParkName"];
    
    return parkSectionName;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //code
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64;
    
}
@end
