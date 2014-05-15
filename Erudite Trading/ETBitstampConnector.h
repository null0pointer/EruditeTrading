//
//  ETBitstampConnector.h
//  Erudite Trading
//
//  Created by Sam Watson on 15/05/14.
//  Copyright (c) 2014 Sam Watson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

typedef void (^ETBitstampConnectorTradeBlock)(id trade);
typedef void (^ETBitstampConnectorOrderBlock)(id orders);
typedef void (^ETBitstampConnectorSuccessBlock)(id responseObject);
typedef void (^ETBitstampConnectorFailureBlock)(NSError *error);

@interface ETBitstampConnector : NSObject

+ (ETBitstampConnector *)shared;

#pragma mark - Subscribe to live data -

- (void)subscribeToLiveTrades:(ETBitstampConnectorTradeBlock)tradeBlock;
- (void)subscribeToLiveOrders:(ETBitstampConnectorOrderBlock)orderBlock;

#pragma mark - Private API Functions -

- (void)accountBalanceWithSuccess:(ETBitstampConnectorSuccessBlock)success
                          failure:(ETBitstampConnectorFailureBlock)failure;

- (void)userTransactionsWithOffset:(NSInteger)offset limit:(NSInteger)limit
                           success:(ETBitstampConnectorSuccessBlock)success
                           failure:(ETBitstampConnectorFailureBlock)failure;

- (void)openOrdersWithSuccess:(ETBitstampConnectorSuccessBlock)success
                      failure:(ETBitstampConnectorFailureBlock)failure;

#pragma mark Orders

- (void)cancelOrder:(NSInteger)orderID
            success:(ETBitstampConnectorSuccessBlock)success
            failure:(ETBitstampConnectorFailureBlock)failure;

- (void)buyLimitOrderWithAmount:(NSNumber *)amount
                          price:(NSNumber *)price
                        success:(ETBitstampConnectorSuccessBlock)success
                        failure:(ETBitstampConnectorFailureBlock)failure;

- (void)sellLimitOrderWithAmount:(NSNumber *)amount
                          price:(NSNumber *)price
                        success:(ETBitstampConnectorSuccessBlock)success
                        failure:(ETBitstampConnectorFailureBlock)failure;

#pragma mark Withdrawals

- (void)withdrawalRequestsWithSuccess:(ETBitstampConnectorSuccessBlock)success
                              failure:(ETBitstampConnectorFailureBlock)failure;

- (void)bitcoinWithdrawalAmount:(NSNumber *)amount
                        address:(NSString *)address
                        success:(ETBitstampConnectorSuccessBlock)success
                        failure:(ETBitstampConnectorFailureBlock)failure;

- (void)rippleWithdrawalAmount:(NSNumber *)amount
                           address:(NSString *)address
                      currency:(NSString *)currency
                       success:(ETBitstampConnectorSuccessBlock)success
                       failure:(ETBitstampConnectorFailureBlock)failure;

#pragma mark Deposits

- (void)bitcoinDepositAddressWithSuccess:(ETBitstampConnectorSuccessBlock)success
                                 failure:(ETBitstampConnectorFailureBlock)failure;

- (void)unconfirmedBitcoinDepositsWithSuccess:(ETBitstampConnectorSuccessBlock)success
                                      failure:(ETBitstampConnectorFailureBlock)failure;

- (void)rippleDepositAddressWithSuccess:(ETBitstampConnectorSuccessBlock)success
                                failure:(ETBitstampConnectorFailureBlock)failure;

@end
