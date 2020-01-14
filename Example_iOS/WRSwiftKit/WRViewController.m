//
//  WRViewController.m
//  WRSwiftKit
//
//  Created by GodFighter on 01/14/2020.
//  Copyright (c) 2020 GodFighter. All rights reserved.
//

#import "WRViewController.h"
@import WRSwiftKit;

@interface WRViewController ()

@end

@implementation WRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WRFolder.cacheUrl = [NSBundle mainBundle].bundleURL;

    NSString *email = @"586261110000@qq.com";

    NSLog(@"%d",email.wr.isEmail);
    
    
    //    NSLog(@"%@", [WRDevice space]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
