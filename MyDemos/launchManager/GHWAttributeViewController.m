//
//  GHWAttributeViewController.m
//  MyDemos
//
//  Created by 黑化肥发灰 on 2019/8/14.
//  Copyright © 2019 Jingyao. All rights reserved.
//

#import "GHWAttributeViewController.h"
#import "GHWAttributeTestObject.h"
//#import "RAMExport.h"
#import "GHWExport.h"

@interface GHWAttributeViewController ()


@end

@implementation GHWAttributeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    GHWAttributeTestObject *testObj = [[GHWAttributeTestObject alloc] init];
//    [testObj testMethod1];  // NS_UNAVAILABLE
//    [testObj testMethod2];  // unavailable
    [testObj testWithSex:@"1" address:@"2" age:4];
//    [testObj testWithSex:nil address:nil age:4];   // nonnull

    [testObj work];
    NSString *testCleanUp __attribute__((cleanup(printTestString))) = @"测试一下";
    testCleanUp = @"1";
    
    NSLog(@"testObj class: %@",NSStringFromClass([testObj class]));
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDate *date1 = [NSDate date];
    [[GHWExport sharedInstance] executeArrayForKey:@"Stage_A"];
    NSDate *date2 = [NSDate date];
    NSTimeInterval interval = [date2 timeIntervalSinceDate:date1];
    NSLog(@"stage_a timeInterval = %@", @(interval));
    NSLog(@"stage_a timeInterval = %@", @(interval));

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSDate *date1 = [NSDate date];
    [[GHWExport sharedInstance] executeArrayForKey:@"Stage_B"];
    NSDate *date2 = [NSDate date];
    NSTimeInterval interval = [date2 timeIntervalSinceDate:date1];
    NSLog(@"stage_b timeInterval = %@", @(interval));
    NSLog(@"stage_b timeInterval = %@", @(interval));

}

void printTestString(NSString **string){
    NSLog(@" 打印信息string:%@",*string);
}

__attribute__((constructor))
void premain() {
    [[GHWExport sharedInstance] executeArrayForKey:@"pre_main"];
}


@end
