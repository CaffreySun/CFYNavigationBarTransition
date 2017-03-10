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

@end

@implementation CFYNavigationBar

@synthesize cfy_navigationBarAlpha = _cfy_navigationBarAlpha;
@synthesize cfy_navigationBarBackgroundColor = _cfy_navigationBarBackgroundColor;

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    
//    return self;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.cfy_shadowImageView.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), [self getImageViewHeight]);
}

- (CGFloat)getImageViewHeight {
    CGFloat height = 0.5;
    if (self.cfy_shadowImage) {
        height = self.cfy_shadowImage.size.height;
    }
    return height;
}

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

- (void)setCfy_shadowImage:(UIImage *)shadowImage {
    _cfy_shadowImage = shadowImage;
    _cfy_shadowImageView.image = self.cfy_shadowImage;
    CGFloat height = 0.5;
    if (shadowImage) {
        height = shadowImage.size.height;
    }
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

- (NSNumber *)cfy_navigationBarAlpha {
    if (nil == _cfy_navigationBarAlpha) {
        _cfy_navigationBarAlpha = @(1);
    }
    return _cfy_navigationBarAlpha;
}

- (void)setCfy_navigationBarAlpha:(NSNumber *)navigationBarAlpha {
    if (!navigationBarAlpha) {
        navigationBarAlpha = @(1);
    }
    _cfy_navigationBarAlpha = navigationBarAlpha;
    self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:self.cfy_navigationBarAlpha.floatValue];
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
    self.backgroundColor = [navigationBarBackgroundColor colorWithAlphaComponent:self.cfy_navigationBarAlpha.floatValue];
}

@end
