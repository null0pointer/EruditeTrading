//
//  ETRootViewController.m
//  Erudite Trading
//
//  Created by Sam Watson on 14/05/14.
//  Copyright (c) 2014 Sam Watson. All rights reserved.
//

#import "ETRootViewController.h"

#import <Bully/Bully.h>

@interface ETRootViewController ()

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) BLYClient *bullyClient;

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
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
    
    self.bullyClient = [[BLYClient alloc] initWithAppKey:@"de504dc5763aeef9ff52" delegate:nil];
    BLYChannel *chatChannel = [self.bullyClient subscribeToChannelWithName:@"live_trades"];
    
    [chatChannel bindToEvent:@"trade" block:^(id message) {
        self.textView.text = [self.textView.text stringByAppendingString:[NSString stringWithFormat:@"%@\n\n", [message description]]];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
