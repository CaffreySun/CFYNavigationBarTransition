//
//  UIViewController+CFYNavigationBarTransition.m
//  TestCorlorNav
//
//  Created by CaffreySun on 2017/2/27.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import "UIViewController+CFYNavigationBarTransition.h"
#import "CFYNavigationBarTransitionConfig.h"
#import "UIImage+CFYNavigationBarTransition.h"
#import "CFYSwizzle.h"
#import <objc/runtime.h>

@interface UIViewController ()

/**
 cfy_navBarBgView,这个view就是核心，改变navigationBar颜色其实是改变cfy_navBarBgView的背景色
 */
@property (nonatomic, strong) UIView *cfy_navBarBgView;

/**
 用来判断view是否加载
 */
@property (nonatomic, assign) BOOL cfy_viewAppeared;

/**
 保存navigationBar颜色
 */
@property (nonatomic, strong) UIColor *cfy_navigationBarBackgroundColor;

/**
 保存navigationBar颜色透明度
 */
@property (nonatomic, assign) CGFloat cfy_navigationBarAlpha;

@end


@implementation UIViewController (CFYNavigationBarTransition)
/**
 在load中，swizzle四个方法viewDidLoad、viewWillLayoutSubviews、viewDidAppear:、viewDidDisappear:。
 */
+(void)load {
    CFYSwizzleMethod(self, @selector(viewDidLoad), @selector(cfy_viewDidLoad));
    CFYSwizzleMethod(self, @selector(viewWillLayoutSubviews), @selector(cfy_viewWillLayoutSubviews));
    CFYSwizzleMethod(self, @selector(viewDidAppear:), @selector(cfy_viewDidAppear:));
    CFYSwizzleMethod(self, @selector(viewDidDisappear:), @selector(cfy_viewDidDisappear:));
}

/**
 在viewDidLoad中添加cfy_navBarBgView
 */
- (void)cfy_viewDidLoad {
    [self cfy_viewDidLoad];
    // 如果存在navigationController则添加cfy_navBarBgView
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


/**
 在viewWillLayoutSubviews中对cfy_navBarBgView进行处理，使cfy_navBarBgView能在不同环境正确显示
 */
- (void)cfy_viewWillLayoutSubviews {
    [self cfy_viewWillLayoutSubviews];
    // 当前viewController没navigationController，直接退出
    if (!self.navigationController) {
        return;
    }
    /**
     self.navigationController.navigationBar隐藏了，做一些处理。
     如果在navigationBar隐藏时，旋转屏幕，这时如果不处理后并return，而是走下面的代码，那么并不能正确的获取到cfy_navBarBgView的frame。
     所以在这里直接将cfy_navBarBgView的宽度设置成屏幕看度，其他不变保持cfy_navBarBgView在隐藏前的状态，这样在从竖屏切换到横屏显示时不会出现一些视觉上的bug
     
     */
    if (self.navigationController.navigationBar.hidden) {
        CGRect rect = self.cfy_navBarBgView.frame;
        self.cfy_navBarBgView.frame = CGRectMake(0, rect.origin.y, CFYScreenWidth, rect.size.height);
        return;
    }
    
    // 获取navigationBar的backgroundView
    UIView *backgroundView = [self.navigationController.navigationBar valueForKey:@"_backgroundView"];
    // 如果没有则return
    if (!backgroundView) {
        return;
    }
    
    // 获取navigationBar的backgroundView在self.view中的位置，这个位置也就是cfy_navBarBgView所在的位置。
    CGRect rect = [backgroundView.superview convertRect:backgroundView.frame toView:self.view];
    
    // 出现rect.origin.x < 0,情况只有在页面刚push出来并且navigationBar隐藏的时候。
    // 这个时候讲rect.origin.y上移rect.size.height，使cfy_navBarBgView也隐藏
    // 目的是防止在navigationBar.hidden=NO时出现动画显示错误
    if (rect.origin.x < 0) {
        rect.origin.y = 0 - rect.size.height;
    }
    
    // cfy_navBarBgView的x固定0
    self.cfy_navBarBgView.frame = CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height);
    
    // 设置当前view的clipsToBounds = NO，原因是，self.view.top可能是从navigationBar.bottom开始，如果clipsToBounds = YES，则cfy_navBarBgView无法显示
    self.view.clipsToBounds = NO;
    // 将cfy_navBarBgView移到self.view最顶端，防止被其他view遮盖
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
 设置背景图片
 
 @param image 背景图
 */
- (void)cfy_setNavigationBarBackgroundImage:(UIImage *)image {
    // 后续版本加入
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
        // 这里只在cfy_navBarBgView隐藏时使用了动画，原因是cfy_navBarBgView显示时系统自动给加上了动画（这很神奇）
        if (hidden && self.cfy_viewAppeared && animated && !self.navigationController.navigationBar.hidden) {
            // 在cfy_navBarBgView隐藏，并且view已经Appeared，并且有动画，并且navigationBar不是已经隐藏了时就进行动画
            CGRect rect = self.cfy_navBarBgView.frame;
            [UIView animateWithDuration:0.2 animations:^{
                // 动画时向上运动
                self.cfy_navBarBgView.frame = CGRectMake(0, rect.origin.y - rect.size.height, rect.size.width, rect.size.height);
            } completion:^(BOOL finished) {
                // 动画完成后cfy_navBarBgView隐藏
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
    
    // 获取NavigationBar的BackgroundView在当前view中的位置
    CGRect rect = [self cfy_getNavigationBarBackgroundViewRect];
    
    // 初始化
    UIView *navBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height)];
    [self.view addSubview:navBarBgView];
    
    // 判断有没有设置颜色
    if (self.cfy_navigationBarBackgroundColor) {
        navBarBgView.backgroundColor = self.cfy_navigationBarBackgroundColor;
    } else {
        // 默认是白色
        navBarBgView.backgroundColor = [UIColor whiteColor];
        self.cfy_navigationBarBackgroundColor = [UIColor whiteColor];
    }
    // 设置透明度，默认为1
    navBarBgView.alpha = self.cfy_navigationBarAlpha;
    // 是否隐藏
    navBarBgView.hidden = self.navigationController.navigationBar.isHidden;
    // 保存
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
    objc_setAssociatedObject(self, @selector(cfy_navigationBarAlpha), @(navigationBarAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
