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


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[GHWLaunchManager sharedInstance] executeArrayForKey:kGHWLauncherStageA];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[GHWLaunchManager sharedInstance] executeArrayForKey:kGHWLauncherStageB];
    
}




@end
