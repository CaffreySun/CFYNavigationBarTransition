//
//  UIViewController+CFYNavigationBarTransition.m
//  TestCorlorNav
//
//  Created by 孙洪伟 on 2017/2/27.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import "UIViewController+CFYNavigationBarTransition.h"
#import "CFYNavigationBarTransitionConfig.h"
#import "UIImage+CFYNavigationBarTransition.h"
#import "CFYSwizzle.h"
#import <objc/runtime.h>

@interface UIViewController ()
@property (nonatomic, strong) UIView *cfy_navBarBgView;
@property (nonatomic, assign) BOOL cfy_viewAppeared;
@property (nonatomic, strong) UIColor *cfy_navigationBarBackgroundColor;
@property (nonatomic, assign) CGFloat cfy_navigationBarAlpha;
@end

@implementation UIViewController (CFYNavigationBarTransition)

+(void)load {
    CFYSwizzleMethod(self, @selector(viewDidLoad), @selector(cfy_viewDidLoad));
    CFYSwizzleMethod(self, @selector(viewWillLayoutSubviews), @selector(cfy_viewWillLayoutSubviews));
    CFYSwizzleMethod(self, @selector(viewDidAppear:), @selector(cfy_viewDidAppear:));
    CFYSwizzleMethod(self, @selector(viewDidDisappear:), @selector(cfy_viewDidDisappear:));
}

- (void)cfy_viewDidLoad {
    [self cfy_viewDidLoad];
    if (self.navigationController) {
        [self cfy_addNavBarBgView];
    }
}

- (void)cfy_viewDidAppear:(BOOL)animated {
    [self cfy_viewDidAppear:animated];
    self.cfy_viewAppeared = YES;
}

- (void)cfy_viewDidDisappear:(BOOL)animated {
    [self cfy_viewDidDisappear:YES];
    self.cfy_viewAppeared = NO;
}


- (void)cfy_viewWillLayoutSubviews {
    [self cfy_viewWillLayoutSubviews];
    if (!self.navigationController) {
        return;
    }
    if (self.navigationController.navigationBar.hidden) {
        CGRect rect = self.cfy_navBarBgView.frame;
        self.cfy_navBarBgView.frame = CGRectMake(0, rect.origin.y, CFYScreenWidth, rect.size.height);
        return;
    }
    
    UIView *backgroundView = [self.navigationController.navigationBar valueForKey:@"_backgroundView"];
    if (!backgroundView) {
        return;
    }
    self.view.clipsToBounds = NO;
    CGRect rect = [backgroundView.superview convertRect:backgroundView.frame toView:self.view];
    if (rect.origin.x < 0) {
        rect.origin.y = 0 - rect.size.height;
    }
    self.cfy_navBarBgView.frame = CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height);
    [self.view bringSubviewToFront:self.cfy_navBarBgView];
}

#pragma mark - 公开方法 -
/**
 设置导航栏背景色
 
 @param color 背景色
 */
- (void)cfy_setNavigationBarBackgroundColor:(UIColor *)color {
    self.cfy_navigationBarBackgroundColor = color;
    if (self.navigationController) {
        self.cfy_navBarBgView.backgroundColor = color;
    }
}

/**
 设置导航栏透明度
 
 @param alpha 透明度
 */
- (void)cfy_setNavigationBarAlpha:(CGFloat)alpha {
    self.cfy_navigationBarAlpha = alpha;
    if (self.navigationController) {
        self.cfy_navBarBgView.alpha = alpha;
    }
}

#pragma mark - 私有方法 -
/**
 设置导航栏是否隐藏
 
 @param hidden 隐藏
 @param animated 动画
 */
- (void)cfy_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    if (self.navigationController) {
        
        if (hidden && self.cfy_viewAppeared && animated && !self.navigationController.navigationBar.hidden) {
            CGRect rect = self.cfy_navBarBgView.frame;
            [UIView animateWithDuration:0.2 animations:^{
                self.cfy_navBarBgView.frame = CGRectMake(0, rect.origin.y - rect.size.height, rect.size.width, rect.size.height);
            } completion:^(BOOL finished) {
                self.cfy_navBarBgView.hidden = hidden;
            }];
        } else {
            self.cfy_navBarBgView.hidden = hidden;
        }
    }
}



/**
 添加navigationBar背景view
 */
- (void)cfy_addNavBarBgView {
    if (!self.isViewLoaded) {
        return;
    }
    if (!self.navigationController) {
        return;
    }
    if (!self.navigationController.navigationBar) {
        return;
    }
    CGRect rect = [self cfy_getNavigationBarBackgroundViewRect];
    
    UIView *navBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height)];
    [self.view addSubview:navBarBgView];
    if (self.cfy_navigationBarBackgroundColor) {
        navBarBgView.backgroundColor = self.cfy_navigationBarBackgroundColor;
    } else {
        navBarBgView.backgroundColor = [UIColor whiteColor];
        self.cfy_navigationBarBackgroundColor = [UIColor whiteColor];
    }
    
    navBarBgView.alpha = self.cfy_navigationBarAlpha;
    
    navBarBgView.hidden = self.navigationController.navigationBar.isHidden;
    [self setCfy_navBarBgView:navBarBgView];
}


/**
 获取navigationBar._backgroundView在self.view中的frame

 @return _backgroundView的frame
 */
- (CGRect)cfy_getNavigationBarBackgroundViewRect {
    UIView *backgroundView = [self.navigationController.navigationBar valueForKey:@"_backgroundView"];
    if (!backgroundView) {
        return CGRectZero;
    }
    CGRect rect = [backgroundView.superview convertRect:backgroundView.frame toView:self.view];
    return rect;
}

#pragma mark - getter/setter -
-(UIView *)cfy_navBarBgView {
    UIView *navBarBgView = objc_getAssociatedObject(self, _cmd);
    
    if (nil == navBarBgView) {
        [self cfy_addNavBarBgView];
    }
    
    return navBarBgView;
}

- (void)setCfy_navBarBgView:(UIView *)navBarBgView {
    objc_setAssociatedObject(self, @selector(cfy_navBarBgView), navBarBgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)cfy_viewAppeared {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCfy_viewAppeared:(BOOL)viewAppeared {
    objc_setAssociatedObject(self, @selector(cfy_viewAppeared), @(viewAppeared), OBJC_ASSOCIATION_ASSIGN);
}

- (UIColor *)cfy_navigationBarBackgroundColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCfy_navigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor {
    objc_setAssociatedObject(self, @selector(cfy_navigationBarBackgroundColor), navigationBarBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)cfy_navigationBarAlpha {
    NSNumber *alpha = objc_getAssociatedObject(self, _cmd);
    if (!alpha) {
        [self setCfy_navigationBarAlpha:1.];
        return 1.;
    }
    
    return [alpha floatValue];
}

- (void)setCfy_navigationBarAlpha:(CGFloat)navigationBarAlpha {
    objc_setAssociatedObject(self, @selector(cfy_navigationBarAlpha), @(navigationBarAlpha), OBJC_ASSOCIATION_ASSIGN);
}
@end
