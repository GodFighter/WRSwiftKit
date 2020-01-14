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
    
    
    UIImage *image = [UIImage.Rotate vertical:[UIImage imageNamed:@"wuren"]];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    imageview.frame = CGRectMake(0, 100, 102.4, 136.5);
    [self.view addSubview:imageview];
    
    /*
    WRFolder.cacheUrl = [NSBundle mainBundle].bundleURL;

    NSString *email = @"586261110000@qq.com";

    NSLog(@"%d",email.wr.isEmail);
     */
    
    
    UIImage *image1 = [UIImage cuttingWithImage:image :CGRectMake(0, 0, 100, 100)];
    imageview.image = image1;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
