//
//  ViewController.m
//  GHWAppLaunchManager
//
//  Created by 黑化肥发灰 on 2019/9/10.
//  Copyright © 2019 黑化肥发灰. All rights reserved.
//

#import "ViewController.h"
#import <GHWPodDemo/GHWExport.h>

__attribute__((constructor))
void premain() {
    NSLog(@"\n\n------------------------  Pre_main start ------------------------\n\n");

    [[GHWExport sharedInstance] executeArrayForKey:@"Pre_main"];
}

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configViews];
    [self configData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    NSDate *date1 = [NSDate date];
    NSLog(@"\n\n------------------------  Stage_A start ------------------------\n\n");
    [[GHWExport sharedInstance] executeArrayForKey:@"Stage_A"];
//    NSDate *date2 = [NSDate date];
//    NSTimeInterval interval = [date2 timeIntervalSinceDate:date1];
//    NSLog(@"stage_a timeInterval = %@", @(interval));
//    NSLog(@"stage_a timeInterval = %@", @(interval));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    NSDate *date1 = [NSDate date];
    NSLog(@"\n\n------------------------  Stage_B start ------------------------\n\n");
    [[GHWExport sharedInstance] executeArrayForKey:@"Stage_B"];
//    NSDate *date2 = [NSDate date];
//    NSTimeInterval interval = [date2 timeIntervalSinceDate:date1];
//    NSLog(@"stage_b timeInterval = %@", @(interval));
//    NSLog(@"stage_b timeInterval = %@", @(interval));
    
}
#pragma mark - Setup View / Data

- (void)configViews {

}

- (void)configData {

}






@end
