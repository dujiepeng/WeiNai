//
//  ViewController.m
//  WeiNai
//
//  Created by Ji Fang on 7/13/15.
//  Copyright (c) 2015 Ji Fang. All rights reserved.
//

#import "ViewController.h"
#import "EMDBManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // for testing purpose.
    EMDBManager *dbman = [EMDBManager sharedInstance];
    dbman = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
