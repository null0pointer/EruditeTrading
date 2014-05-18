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
#import <CommonCrypto/CommonHMAC.h>

NSString* const kBitstampPusherKey = @"de504dc5763aeef9ff52";
NSString* const kBitstampPusherTradeChannel = @"live_trades";
NSString* const kBitstampPusherOrderBookChannel = @"order_book";
NSString* const kBitstampPusherTradeEvent = @"trade";
NSString* const kBitstampPusherOderEvent = @"data";

NSString* const kBitstampTickerPath = @"https://www.bitstamp.net/api/ticker/";
NSString* const kBitstampOrderBookPath = @"https://www.bitstamp.net/api/order_book/";
NSString* const kBitstampAccountBalancePath = @"https://www.bitstamp.net/api/balance/";
NSString* const kBitstampUserTransactionsPath = @"https://www.bitstamp.net/api/user_transactions/";
NSString* const kBitstampOpenOrdersPath = @"https://www.bitstamp.net/api/open_orders/";
NSString* const kBitstampCancelOrderPath = @"https://www.bitstamp.net/api/cancel_order/";
NSString* const kBitstampBuyLimitOrderPath = @"https://www.bitstamp.net/api/buy/";
NSString* const kBitstampSellLimitOrderPath = @"https://www.bitstamp.net/api/sell/";
NSString* const kBitstampWithdrawalRequestPath = @"https://www.bitstamp.net/api/withdrawal_requests/";
NSString* const kBitstampBitcoinWithdrawalPath = @"https://www.bitstamp.net/api/bitcoin_withdrawal/";
NSString* const kBitstampRippleWithdrawalPath = @"https://www.bitstamp.net/api/ripple_withdrawal/";
NSString* const kBitstampBitcoinDepositAddressPath = @"https://www.bitstamp.net/api/bitcoin_deposit_address/";
NSString* const kBitstampUnconfirmedBitcoinDepositPath = @"https://www.bitstamp.net/api/unconfirmed_btc/";
NSString* const kBitstampRippleDepositAddressPath = @"https://www.bitstamp.net/api/ripple_address/";

@interface ETBitstampConnector ()

@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *apiSecret;
@property (strong, nonatomic) NSString *clientID;

@property (strong, nonatomic) BLYClient *bullyClient;

@end

@implementation ETBitstampConnector

+ (ETBitstampConnector *)shared
{
    static dispatch_once_t token = 0;
    
    __strong static id _sharedObject = nil;
    
    dispatch_once(&token, ^{
        _sharedObject = [[self alloc] init];
        [(ETBitstampConnector *)_sharedObject setClientID:@"682431"];
        [(ETBitstampConnector *)_sharedObject setApiKey:@"mMlcVBuvXetaBBW02eLqRAqDwgrr0NMt"];
        [(ETBitstampConnector *)_sharedObject setApiSecret:@"jmZYtGmzCt8mQuNP73w1ajQTOIG0SOIY"];
    });
    
    return _sharedObject;
}

- (BLYClient *)bullyClient
{
    if (_bullyClient == nil)
    {
        _bullyClient = [[BLYClient alloc] initWithAppKey:kBitstampPusherKey delegate:nil];
    }
    
    return _bullyClient;
}

- (NSString *)signatureForNonce:(NSInteger)nonce
{
    NSString *secret = self.apiSecret;
    NSString *parameters = [NSString stringWithFormat:@"%d%@%@", nonce, self.clientID, self.apiKey];
    NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *paramData = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, secretData.bytes, secretData.length, paramData.bytes, paramData.length, hash.mutableBytes);
    NSString *hexString = [[self hexadecimalStringFromData:hash] uppercaseString];
    NSLog(@"signature: %@", hexString);
    return hexString;
}

- (NSString *)hexadecimalStringFromData:(NSData *)data {
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */
    
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}

#pragma mark - Subscribe to live data -

- (void)subscribeToLiveTrades:(ETBitstampConnectorTradeBlock)tradeBlock
{
    BLYChannel *channel = [self.bullyClient subscribeToChannelWithName:kBitstampPusherTradeChannel];
    [channel bindToEvent:kBitstampPusherTradeEvent block:tradeBlock];
}

- (void)subscribeToLiveOrders:(ETBitstampConnectorOrderBlock)orderBlock
{
    BLYChannel *channel = [self.bullyClient subscribeToChannelWithName:kBitstampPusherOrderBookChannel];
    [channel bindToEvent:kBitstampPusherOderEvent block:orderBlock];
}

#pragma mark - Public API Functions -

- (void)getTickerWithSuccess:(ETBitstampConnectorSuccessBlock)success
                     failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

- (void)getOrderBookWithSuccess:(ETBitstampConnectorSuccessBlock)success
                        failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

#pragma mark - Private API Functions -

- (void)accountBalanceWithSuccess:(ETBitstampConnectorSuccessBlock)success
                          failure:(ETBitstampConnectorFailureBlock)failure
{
    NSInteger nonce = [NSDate timeIntervalSinceReferenceDate];
    NSString *signature = [self signatureForNonce:nonce];
    NSString *key = self.apiKey;
    
    NSDictionary *parameters = @{@"key": key,
                                 @"nonce": @(nonce),
                                 @"signature": signature};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:kBitstampAccountBalancePath parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)userTransactionsWithOffset:(NSInteger)offset limit:(NSInteger)limit
                           success:(ETBitstampConnectorSuccessBlock)success
                           failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

- (void)openOrdersWithSuccess:(ETBitstampConnectorSuccessBlock)success
                      failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

#pragma mark Orders

- (void)cancelOrder:(NSInteger)orderID
            success:(ETBitstampConnectorSuccessBlock)success
            failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

- (void)buyLimitOrderWithAmount:(NSNumber *)amount
                          price:(NSNumber *)price
                        success:(ETBitstampConnectorSuccessBlock)success
                        failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

- (void)sellLimitOrderWithAmount:(NSNumber *)amount
                           price:(NSNumber *)price
                         success:(ETBitstampConnectorSuccessBlock)success
                         failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

#pragma mark Withdrawals

- (void)withdrawalRequestsWithSuccess:(ETBitstampConnectorSuccessBlock)success
                              failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

- (void)bitcoinWithdrawalAmount:(NSNumber *)amount
                        address:(NSString *)address
                        success:(ETBitstampConnectorSuccessBlock)success
                        failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

- (void)rippleWithdrawalAmount:(NSNumber *)amount
                       address:(NSString *)address
                      currency:(NSString *)currency
                       success:(ETBitstampConnectorSuccessBlock)success
                       failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

#pragma mark Deposits

- (void)bitcoinDepositAddressWithSuccess:(ETBitstampConnectorSuccessBlock)success
                                 failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

- (void)unconfirmedBitcoinDepositsWithSuccess:(ETBitstampConnectorSuccessBlock)success
                                      failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

- (void)rippleDepositAddressWithSuccess:(ETBitstampConnectorSuccessBlock)success
                                failure:(ETBitstampConnectorFailureBlock)failure
{
    
}

@end
