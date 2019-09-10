//
//  GHWViewController.m
//  MyDemos
//
//  Created by 黑化肥发灰 on 2019/7/25.
//  Copyright © 2019 Jingyao. All rights reserved.
//

#import "GHWHomeViewController.h"

#import "GHWHomeTableViewCell.h"
#import <Masonry/Masonry.h>

#import "GHWBaseViewController.h"
#import "GHWAttributeViewController.h"

//当前控制器
UIViewController *AutoGetRoSourceViewController() {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *topVC = keyWindow.rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        topVC = ((UINavigationController*)topVC).topViewController;
    }
    
    if ([topVC isKindOfClass:[UITabBarController class]]) {
        topVC = ((UITabBarController*)topVC).selectedViewController;
    }
    
    return topVC;
}

UINavigationController* AutoGetNavigationViewController(UIViewController *sourceVC) {
    
    UINavigationController *navigationController = nil;
    if ([sourceVC isKindOfClass:[UINavigationController class]]) {
        navigationController = (id)sourceVC;
    } else {
        UIViewController *superViewController = sourceVC.parentViewController;
        while (superViewController) {
            if ([superViewController isKindOfClass:[UINavigationController class]]) {
                navigationController = (id)superViewController;
                break;
            } else {
                superViewController = superViewController.parentViewController;
            }
        }
    }
    
    return navigationController;
}


@interface GHWHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation GHWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self configView];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    NSDate *date1 = [NSDate date];
//    [[GHWExport sharedInstance] executeArrayForKey:@"Stage_A"];
//    NSDate *date2 = [NSDate date];
//    NSTimeInterval interval = [date2 timeIntervalSinceDate:date1];
//    NSLog(@"stage_a timeInterval = %@", @(interval));
//    NSLog(@"stage_a timeInterval = %@", @(interval));
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSDate *date1 = [NSDate date];
//    [[GHWExport sharedInstance] executeArrayForKey:@"Stage_B"];
//    NSDate *date2 = [NSDate date];
//    NSTimeInterval interval = [date2 timeIntervalSinceDate:date1];
//    NSLog(@"stage_b timeInterval = %@", @(interval));
//    NSLog(@"stage_b timeInterval = %@", @(interval));
//
//}

- (void)configData {
    self.dataArray = @[@{@"启动管理": [GHWAttributeViewController class]}];
}

- (void)configView {
    self.title = @"demos";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(@([UIDevice stautsBarAndNaviBarHeight]));
    }];
}

#pragma mark - tableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSString *dicKey = [dic allKeys][0];
    GHWHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHWHomeTableViewCell"];
    cell.labelTitle.text = [NSString stringWithFormat:@"%@. %@", @(indexPath.row + 1), dicKey];
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSString *dicKey = [dic allKeys][0];
    Class cls = dic[dicKey];
    GHWBaseViewController *vc = [[cls alloc] init];
    vc.titleStr = dicKey;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter & setter

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)){
            _mainTableView.estimatedRowHeight = 0;
            _mainTableView.estimatedSectionFooterHeight = 0;
            _mainTableView.estimatedSectionHeaderHeight = 0;
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_mainTableView registerClass:[GHWHomeTableViewCell class] forCellReuseIdentifier:@"GHWHomeTableViewCell"];
    }
    return _mainTableView;
}

@end
