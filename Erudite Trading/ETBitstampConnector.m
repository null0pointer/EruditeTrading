//
//  ETBitstampConnector.m
//  Erudite Trading
//
//  Created by Sam Watson on 15/05/14.
//  Copyright (c) 2014 Sam Watson. All rights reserved.
//

#import "ETBitstampConnector.h"

#import <Bully/Bully.h>
#import "AFHTTPRequestOperationManager.h"

@interface ETBitstampConnector ()

@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *apiSecret;
@property (strong, nonatomic) NSString *clientID;

@end

@implementation ETBitstampConnector

+ (ETBitstampConnector *)shared
{
    static dispatch_once_t token = 0;
    
    __strong static id _sharedObject = nil;
    
    dispatch_once(&token, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}

- (void)subscribeToLiveTrades:(ETBitstampConnectorTradeBlock)tradeBlock
{
    
}

- (void)subscribeToLiveOrders:(ETBitstampConnectorOrderBlock)orderBlock
{
    
}

- (void)accountBalanceWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo": @"bar"};
    [manager POST:@"https://www.bitstamp.net/api/balance/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
}

- (void)userTransactionsWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
}

- (void)openOrdersWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
}

- (void)cancelOrderWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
}

- (void)buyLimitOrderWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
}

- (void)sellLimitOrderWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
}

- (void)withdrawalRequestsWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
}

- (void)bitcoinWithdrawalWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
}

- (void)bitcoinDepositAddressWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
}

- (void)unconfirmedBitcoinDepositsWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
}

- (void)rippleWithdrawalWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
}

- (void)rippleDepositAddressWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
}

@end
