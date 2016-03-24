//
//  ViewController.m
//  CountdownDemo
//
//  Created by HanWei on 16/3/24.
//  Copyright © 2016年 AndLiSoft. All rights reserved.
//

#import "ViewController.h"
#import "CountdownLabel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CountdownLabel *countdownLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.countdownLabel.countdownTime = 24*60*60*2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
