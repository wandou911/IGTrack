//
//  IGViewController.m
//  IGTrack
//
//  Created by wandou911 on 12/08/2020.
//  Copyright (c) 2020 wandou911. All rights reserved.
//

#import "IGViewController.h"
#import <IGTrackManager.h>

@interface IGViewController ()

@end

@implementation IGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    IGTrackManager *mg = [[IGTrackManager alloc] init];
    [mg testPrint:@"test"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"测试埋点" forState:UIControlStateNormal];
    btn.frame = CGRectMake(200, 200, 100, 40);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)sender
{
    NSLog(@"btnClick");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
