//
//  TPParkDataManager.m
//  taipeipark
//
//  Created by Esu Tsai on 2017/4/12.
//  Copyright © 2017年 Esu Tsai. All rights reserved.
//

#import "TPParkDataManager.h"

@implementation TPParkDataManager

- (id)init {
    self = [super init];
    if (self != nil) {
        _resultParkList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)setParkList:(NSArray *)parkList
{
    NSMutableArray *resultMutaParkList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *parkDic in parkList) {
        NSMutableDictionary *parkMutaDic = [parkDic mutableCopy];
        [parkMutaDic setObject:[self prepareRelateLocation:parkDic allParkData:parkList] forKey:@"relateLocation"];
        [resultMutaParkList addObject:parkMutaDic];
    }
    _resultParkList = [NSArray arrayWithArray:resultMutaParkList];
    
}

- (NSMutableArray *)prepareRelateLocation:(NSDictionary *)parkDic allParkData:(NSArray *)allData
{
    NSString *parkName = [parkDic objectForKey:@"ParkName"];
    NSString *parkId   = [parkDic objectForKey:@"_id"];
    
    NSMutableArray *relateLocationList = [[NSMutableArray alloc] init];
    for (NSDictionary *parkRelateDic in allData) {
        if([[parkRelateDic objectForKey:@"ParkName"] isEqualToString:parkName] && ![[parkRelateDic objectForKey:@"_id"] isEqualToString:parkId]){
            [relateLocationList addObject:parkRelateDic];
        }
    }
    
    return relateLocationList;
}

@end
