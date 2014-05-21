//
//  ETRootViewController.m
//  Erudite Trading
//
//  Created by Sam Watson on 14/05/14.
//  Copyright (c) 2014 Sam Watson. All rights reserved.
//

#import "ETRootViewController.h"

#import "ETBitstampConnector.h"

@interface ETRootViewController ()

@property (strong, nonatomic) UILabel *lastPriceLabel;
@property (strong, nonatomic) UILabel *bidLabel;
@property (strong, nonatomic) UILabel *askLabel;

@end

@implementation ETRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.lastPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100.0)];
    self.bidLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.lastPriceLabel.frame.size.height, self.view.frame.size.width / 2, 44.0)];
    self.askLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, self.lastPriceLabel.frame.size.height, self.view.frame.size.width / 2, 44.0)];
    
    self.lastPriceLabel.text = @"$0.00";
    self.bidLabel.text = @"$0.00";
    self.askLabel.text = @"$0.00";
    
    self.lastPriceLabel.textAlignment = NSTextAlignmentCenter;
    self.lastPriceLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:54.0];
    self.lastPriceLabel.textColor = [UIColor blackColor];
    
    self.bidLabel.textAlignment = NSTextAlignmentCenter;
    self.bidLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:24.0];
    self.bidLabel.textColor = [UIColor greenColor];
    
    self.askLabel.textAlignment = NSTextAlignmentCenter;
    self.askLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:24.0];
    self.askLabel.textColor = [UIColor redColor];
    
    [self.view addSubview:self.lastPriceLabel];
    [self.view addSubview:self.bidLabel];
    [self.view addSubview:self.askLabel];
    
    [[ETBitstampConnector shared] subscribeToLiveTrades:^(id trade) {
        NSNumber *price = [trade valueForKey:@"price"];
        self.lastPriceLabel.text = [NSString stringWithFormat:@"$%@", price];
    }];
    
    [[ETBitstampConnector shared] subscribeToLiveOrders:^(id orders) {
        NSArray *bids = [orders valueForKey:@"bids"];
        NSArray *asks = [orders valueForKey:@"asks"];
        
        NSArray *highestBid = [bids objectAtIndex:0];
        NSArray *lowestAsk = [asks objectAtIndex:0];
        
        self.bidLabel.text = [NSString stringWithFormat:@"$%@", [highestBid objectAtIndex:0]];
        self.askLabel.text = [NSString stringWithFormat:@"$%@", [lowestAsk objectAtIndex:0]];
    }];
    
//    [[ETBitstampConnector shared] accountBalanceWithSuccess:^(id responseObject) {
//        
//    } failure:^(NSError *error) {
//        NSLog(@"ERROR: %@", error.description);
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
