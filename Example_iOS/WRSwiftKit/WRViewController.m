//
//  WRViewController.m
//  WRSwiftKit
//
//  Created by GodFighter on 01/14/2020.
//  Copyright (c) 2020 GodFighter. All rights reserved.
//

#import "WRSwiftKit/WRSwiftKit-Swift.h"

#import "WRViewController.h"
@import WRSwiftKit;

@interface WRViewController ()

@end

@implementation WRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"size = %@", [NSValue valueWithCGSize:WRDevice.current.size]);
    NSLog(@"model = %@", WRDevice.current.model);
    NSLog(@"inches = %@", @(WRDevice.current.inches).stringValue);

    NSLog(@"free = %@, %@", @([WRDevice.current storageValue:StorageFree]).stringValue, [WRDevice.current storageString:StorageFree]);
    NSLog(@"total = %@, %@", @([WRDevice.current storageValue:StorageTotal]).stringValue, [WRDevice.current storageString:StorageTotal]);

    NSLog(@"memory free = %@, %@", @([WRDevice.current memoryValue:MemoryFree]).stringValue, [WRDevice.current memoryString:MemoryFree]);
    NSLog(@"memory total = %@, %@", @([WRDevice.current memoryValue:MemoryTotal]).stringValue, [WRDevice.current memoryString:MemoryTotal]);
    NSLog(@"wifi = %@", WRDevice.current.wifi);
    
    UIColor *hexColor = [UIColor Hex:0x00ff00 alpha:1]; //[[UIColor alloc] initWithHex:0x00ff00 alpha:1];
    UIColor *hexStringColor = [UIColor HexString:@"0000ff" alpha:1]; //[[UIColor alloc] initWithHexString:@"ff00ff" alpha:1];
    
    
    
//    NSLog(@"total = %@", @(WRDevi))
    
//    UIImage *image = [UIImage.Rotate vertical:[UIImage imageNamed:@"wuren"]];
//    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
//    imageview.frame = CGRectMake(0, 100, 102.4, 136.5);
//    [self.view addSubview:imageview];
    
    /*
    WRFolder.cacheUrl = [NSBundle mainBundle].bundleURL;

    NSString *email = @"586261110000@qq.com";

    NSLog(@"%d",email.wr.isEmail);
     */
    
    
//    UIImage *image1 = [UIImage cuttingWithImage:image :CGRectMake(0, 0, 100, 100)];
//    imageview.image = image1;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 50, 50);
    button.backgroundColor = hexStringColor;
    button.titleLabel.textColor = hexColor;
    [button setTitle:@"button" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wunused-result"

    [[button event:UIControlEventTouchDown handler:^(UIControl * control, UIControlEvents event) {
        NSLog(@"down");
    }] event:UIControlEventTouchUpInside handler:^(UIControl * control, UIControlEvents event) {
        NSLog(@"inside");
    }];

    #pragma clang diagnostic pop

    
//    [self.view.indicator startAnimating:WRActivityIndicatorTypeRing size:CGSizeMake(40, 40) padding:0 message:nil messageFont:nil color:nil backgroundColor:nil textColor:nil fadeInAnimation:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
