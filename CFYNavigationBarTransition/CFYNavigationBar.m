//
//  CFYNavigationBar.m
//  CFYNavigationBarTransitionDemo
//
//  Created by Caffrey on 2017/3/7.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import "CFYNavigationBar.h"

@interface CFYNavigationBar ()

@property (nonatomic, strong) UIImageView *cfy_shadowImageView;

@property (nonatomic, strong) UIView *cfy_backgroundImageView;

@end

@implementation CFYNavigationBar

@synthesize cfy_navigationBarBackgroundColor = _cfy_navigationBarBackgroundColor;

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cfy_shadowImageView.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), [self getImageViewHeight]);
    self.cfy_backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (CGFloat)getImageViewHeight {
    CGFloat height = 0.5;
    if (self.cfy_shadowImage) {
        height = self.cfy_shadowImage.size.height;
    }
    return height;
}

#pragma mark - getter/setter -
- (UIImageView *)cfy_shadowImageView {
    if (nil == _cfy_shadowImageView) {
        _cfy_shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), [self getImageViewHeight])];
        [self addSubview:_cfy_shadowImageView];
        // 设置默认背景色，和NavigationBar.shadowImage默认背景色相同
        _cfy_shadowImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        if (self.cfy_shadowImage) {
            _cfy_shadowImageView.image = self.cfy_shadowImage;
        }
    }
    
    return _cfy_shadowImageView;
}

- (UIView *)cfy_backgroundImageView {
    if (nil == _cfy_backgroundImageView) {
        _cfy_backgroundImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        [self addSubview:_cfy_backgroundImageView];
        _cfy_backgroundImageView.backgroundColor = [UIColor clearColor];
        if (self.cfy_navigationBarBackgroundImage) {
            _cfy_backgroundImageView.backgroundColor = [UIColor colorWithPatternImage:self.cfy_navigationBarBackgroundImage];
        }
    }
    
    return _cfy_backgroundImageView;
}

- (void)setCfy_shadowImage:(UIImage *)shadowImage {
    _cfy_shadowImage = shadowImage;
    _cfy_shadowImageView.image = self.cfy_shadowImage;
    CGFloat height = shadowImage.size.height;
    UIColor *shadowImageColoer = [UIColor clearColor];
    if (!shadowImage) {
        height = 0.5;
        shadowImageColoer = self.cfy_shadowImageColor;
    }
    self.cfy_shadowImageView.backgroundColor = shadowImageColoer;
    self.cfy_shadowImageView.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), height);
}

- (void)setCfy_shadowImageColor:(UIColor *)shadowImageColor {
    if (!shadowImageColor) {
        shadowImageColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    _cfy_shadowImageColor = shadowImageColor;
    self.cfy_shadowImageView.backgroundColor = shadowImageColor;
    self.cfy_shadowImageView.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), [self getImageViewHeight]);
}

- (UIColor *)cfy_navigationBarBackgroundColor {
    if (nil == _cfy_navigationBarBackgroundColor) {
        _cfy_navigationBarBackgroundColor = [UIColor whiteColor];
    }
    return _cfy_navigationBarBackgroundColor;
}

- (void)setCfy_navigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor {
    if (!navigationBarBackgroundColor) {
        navigationBarBackgroundColor = [UIColor whiteColor];
    }
    _cfy_navigationBarBackgroundColor = navigationBarBackgroundColor;
    self.backgroundColor = navigationBarBackgroundColor;
}

- (void)setCfy_navigationBarBackgroundImage:(UIImage *)navigationBarBackgroundImage {
    _cfy_navigationBarBackgroundImage = navigationBarBackgroundImage;
    self.cfy_backgroundImageView.backgroundColor = [UIColor colorWithPatternImage:navigationBarBackgroundImage];
}

@end
