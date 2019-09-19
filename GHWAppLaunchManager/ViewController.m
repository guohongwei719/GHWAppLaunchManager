//
//  ViewController.m
//  GHWAppLaunchManager
//
//  Created by 黑化肥发灰 on 2019/9/10.
//  Copyright © 2019 黑化肥发灰. All rights reserved.
//

#import "ViewController.h"
#import <GHWPodDemo/GHWLaunchManager.h>

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

    [[GHWLaunchManager sharedInstance] executeArrayForKey:@"Stage_A"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[GHWLaunchManager sharedInstance] executeArrayForKey:@"Stage_B"];
    
}
#pragma mark - Setup View / Data

- (void)configViews {

}

- (void)configData {

}






@end
