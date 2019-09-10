//
//  GHWHomeTableViewCell.m
//  MyDemos
//
//  Created by 黑化肥发灰 on 2019/7/25.
//  Copyright © 2019 Jingyao. All rights reserved.
//

#import "GHWHomeTableViewCell.h"


@interface GHWHomeTableViewCell ()

@property (nonatomic, strong) UIView *bottomLineView;
@end

@implementation GHWHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
    }
    return self;
}


- (void)configViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.equalTo(@(1.0/[UIScreen mainScreen].scale));
    }];
    
    [self.contentView addSubview:self.labelTitle];
    [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}



- (UILabel *)labelTitle {
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.font = [UIFont systemFontOfSize:16];
        _labelTitle.textColor = [UIColor blackColor];
    }
    return _labelTitle;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLineView;
}

@end
