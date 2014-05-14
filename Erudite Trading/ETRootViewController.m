//
//  ETRootViewController.m
//  Erudite Trading
//
//  Created by Sam Watson on 14/05/14.
//  Copyright (c) 2014 Sam Watson. All rights reserved.
//

#import "ETRootViewController.h"

@interface ETRootViewController ()

@property (strong, nonatomic) UITextView *textView;

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
    [self.view addSubview:self.textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
