//
//  UINavigationController+CFYNavigationBarTransition.m
//  TestCorlorNav
//
//  Created by CaffreySun on 2017/2/27.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import "UINavigationController+CFYNavigationBarTransition.h"
#import "UINavigationController+CFYNavigationBarTransition_Public.h"
#import "UIViewController+CFYNavigationBarTransition.h"
#import "CFYSwizzle.h"
#import "UIImage+CFYNavigationBarTransition.h"

#import <objc/runtime.h>

@interface UINavigationController ()

/**
 是否关闭
 */
@property (readonly) BOOL closeCFYNavigationBar;

@end

@implementation UINavigationController (CFYNavigationBarTransition)

+ (void)load {
    CFYSwizzleMethod(self, @selector(viewDidLoad), @selector(cfy_navvc_viewDidLoad));
    CFYSwizzleMethod(self, @selector(viewWillLayoutSubviews), @selector(cfy_navvc_viewWillLayoutSubviews));
    CFYSwizzleMethod(self, @selector(setNavigationBarHidden:animated:), @selector(cfy_setNavigationBarHidden:animated:));
    CFYSwizzleMethod(self, @selector(setNavigationBarHidden:), @selector(cfy_setNavigationBarHidden:));
    CFYSwizzleMethod(self, @selector(pushViewController:animated:), @selector(cfy_pushViewController:animated:));
}

- (UIView *)getNavigationBarBackgroundView {
    static NSString *decodedString;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        decodedString = [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:@"X2JhY2tncm91bmRWaWV3" options:NSDataBase64DecodingIgnoreUnknownCharacters] encoding:NSUTF8StringEncoding];
    });
    
    return [self.navigationBar valueForKey:decodedString];
}

- (void)cfy_navvc_viewDidLoad {
    [self cfy_navvc_viewDidLoad];
    // 没关闭
    if (!self.closeCFYNavigationBar) {
        // 设置navigationBar为透明，但是如果navigationBar.translucent = NO，那么下面这句话就不起作用，navigationBar就会变成不透明的白色，所以不要设置navigationBar.translucent = NO
        [self.navigationBar setBackgroundImage:[UIImage cfy_imageWithColor:[UIColor clearColor]] forBarPosition:0 barMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage new]];
    }
}

- (void)cfy_navvc_viewWillLayoutSubviews {
    [self cfy_navvc_viewWillLayoutSubviews];
    
    // 这里为了修复一个bug，当UIViewController的edgesForExtendedLayout赋值为非UIRectEdgeTop时(UIRectEdgeAll是包括了UIRectEdgeTop)，在UIViewController的viewWillLayoutSubviews获取到的导航栏高度不正常，缺少了状态栏高度。
    // 但当代码执行到UINavigationController的viewWillLayoutSubviews时，获取到的导航栏高度为正常高度。
    // 所以这里手动调用一下UIViewController的viewWillLayoutSubviews方法，来重新获取导航栏高度。
    if (self.viewControllers.count == 1) {
        // 只需要在导航栏的第一个控制器viewWillLayoutSubviews时执行一次就行，后续push的控制器都能获取到正常高度
        if ((self.topViewController.edgesForExtendedLayout & 0x1) != UIRectEdgeTop) {
            [self.topViewController viewWillLayoutSubviews];
        }
    }
}

- (void)cfy_setNavigationBarHidden:(BOOL)hidden {
    // 没有关闭本库
    if (!self.closeCFYNavigationBar) {
        UIViewController *vc = [self.viewControllers lastObject];
        // 先隐藏/显示barBgView
        [vc cfy_setNavigationBarHidden:hidden animated:NO];
    }
    
    // 再隐藏/显示navigationBar
    [self cfy_setNavigationBarHidden:hidden];
}

- (void)cfy_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    // 没有关闭本库
    if (!self.closeCFYNavigationBar) {
        UIViewController *vc = [self.viewControllers lastObject];
        // 先隐藏/显示barBgView
        [vc cfy_setNavigationBarHidden:hidden animated:animated];
    }
    
    // 再隐藏/显示navigationBar
    [self cfy_setNavigationBarHidden:hidden animated:animated];
}

- (void)cfy_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 0) {
        [self cfy_pushViewController:viewController animated:animated];
        return;
    }
    
    // 没有关闭本库
    if (!self.closeCFYNavigationBar) {
        UIViewController *fromVC = [self.viewControllers lastObject];
        // push时如果下一个页面没有设置背景色和透明度，那么会自动沿用当前页面的颜色和透明度。
        // 保存当前页面的bar颜色
        UIColor *bgColor = fromVC.cfy_navigationBarBackgroundColor;
        [viewController cfy_setNavigationBarBackgroundColor:bgColor];
        // 保存当前页面的bar图片
        UIImage *bgImage = fromVC.cfy_navigationBarBackgroundImage;
        [viewController cfy_setNavigationBarBackgroundImage:bgImage];
        // 保存当前页面的透明度
        CGFloat alpha = fromVC.cfy_navigationBarAlpha;
        [viewController cfy_setNavigationBarAlphaFromLastNavBar:alpha];
        // 保存shadowImage
        UIImage *shadowImage = fromVC.cfy_shadowImage;
        [viewController cfy_setNavigationBarShadowImage:shadowImage];
        // 保存shadowImageColor
        UIColor *shadowImageColor = fromVC.cfy_shadowImageColor;
        [viewController cfy_setNavigationBarShadowImageBackgroundColor:shadowImageColor];
    }
    
    // 保存完成开始Push
    [self cfy_pushViewController:viewController animated:animated];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (void)closeCFYNavigationBarFunction:(BOOL)close {
    [self openCFYNavigationBarFunction:!close];
}
#pragma clang diagnostic pop


- (void)openCFYNavigationBarFunction:(BOOL)open {
    BOOL close = !open;
    self.closeCFYNavigationBar = close;
    if (close) {
        [self.navigationBar setBackgroundImage:nil forBarPosition:0 barMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:nil];
    } else {
        [self.navigationBar setBackgroundImage:[UIImage cfy_imageWithColor:[UIColor clearColor]] forBarPosition:0 barMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage new]];
    }
}


- (void)setCloseCFYNavigationBar:(BOOL)closeCFYNavigationBar {
    objc_setAssociatedObject(self, @selector(closeCFYNavigationBar), @(closeCFYNavigationBar), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)closeCFYNavigationBar {
    NSNumber *closed = objc_getAssociatedObject(self, _cmd);
    if (nil == closed) {
        return YES;
    } else {
        return [closed boolValue];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (BOOL)isCloseCFYNavigationBar {
    return ![self isOpenedCFYNavigationBar];
}
#pragma clang diagnostic pop

- (BOOL)isOpenedCFYNavigationBar {
    NSNumber *closed = objc_getAssociatedObject(self, @selector(closeCFYNavigationBar));
    if (nil == closed) {
        return NO;
    } else {
        return ![closed boolValue];
    }
}


@end
