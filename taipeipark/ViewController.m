//
//  ViewController.m
//  taipeipark
//
//  Created by Esu Tsai on 2017/4/12.
//  Copyright © 2017年 Esu Tsai. All rights reserved.
//

#import "ViewController.h"
#import "TPDataRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareData
{
    NSString *apiUrl = @"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812";
    
    [[TPDataRequest sharedInstance] apiGetWithPath:apiUrl params:nil needFailureAlert:YES success:^(NSArray *successData) {
        
        //
    } failure:^(NSDictionary *errorData) {
        //
    } completion:^{
        //
    }];
}

@end
