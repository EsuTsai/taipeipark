//
//  TPDataRequest.m
//  taipeipark
//
//  Created by Esu Tsai on 2017/4/12.
//  Copyright © 2017年 Esu Tsai. All rights reserved.
//

#import "TPDataRequest.h"
#import "TPParkDataManager.h"

@implementation TPDataRequest

+ (TPDataRequest *)sharedInstance
{
    static TPDataRequest *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[TPDataRequest alloc] init];
    });
    return shareInstance;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
    }
    
    return self;
}

//- (NSString *)getApiUrl
//{
//    NSString *apiUrl = @"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812";
//    return apiUrl;
//}

- (void)apiGetWithPath:(NSString *)path
                params:(NSDictionary *)params
      needFailureAlert:(BOOL)alert
               success:(APIFetchResult)successBlock
               failure:(void (^)(NSDictionary *errorData))failureBlock
            completion:(void (^)(void))completionBlock
{
    self.apiFetchResult                    = successBlock;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSArray *parkData = [[responseObject objectForKey:@"result"] objectForKey:@"results"];
        TPParkDataManager *parkDataManager = [[TPParkDataManager alloc] init];
        parkDataManager.parkList           = parkData;
        
        if(successBlock){
            successBlock(parkDataManager.resultParkList);
        }
        if(completionBlock){
            completionBlock();
        }
        self.apiFetchResult = nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary *errorParams = @{@"status":@"fail",
                                      @"message":@"系統連線錯誤！請稍候再試"};
        if(alert){
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[errorParams objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:nil]];
//            [alert show];
        }
        if(failureBlock){
            failureBlock(errorParams);
        }
        if(completionBlock){
            completionBlock();
        }
        self.apiFetchResult = nil;
    }];
}


@end
