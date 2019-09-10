//
//  GHWBaseViewController.m
//  MyDemos
//
//  Created by 黑化肥发灰 on 2019/8/14.
//  Copyright © 2019 Jingyao. All rights reserved.
//

#import "GHWBaseViewController.h"

@interface GHWBaseViewController ()

@end

@implementation GHWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configViews];
}

- (void)configViews {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleStr;
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
}

@end
