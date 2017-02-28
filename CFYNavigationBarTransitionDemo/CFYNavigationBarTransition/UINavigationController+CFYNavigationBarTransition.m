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

@implementation UINavigationController (CFYNavigationBarTransition)

+ (void)load {
    CFYSwizzleMethod(self, @selector(viewDidLoad), @selector(cfy_navvc_viewDidLoad));
    CFYSwizzleMethod(self, @selector(setNavigationBarHidden:animated:), @selector(cfy_setNavigationBarHidden:animated:));
    CFYSwizzleMethod(self, @selector(setNavigationBarHidden:), @selector(cfy_setNavigationBarHidden:));
    CFYSwizzleMethod(self, @selector(pushViewController:animated:), @selector(cfy_pushViewController:animated:));
}

- (void)cfy_navvc_viewDidLoad {
    [self cfy_navvc_viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage cfy_imageWithColor:[UIColor clearColor]] forBarPosition:0 barMetrics:UIBarMetricsDefault];
}

- (void)cfy_setNavigationBarHidden:(BOOL)hidden {
    UIViewController *vc = [self.viewControllers lastObject];
    [vc cfy_setNavigationBarHidden:hidden animated:NO];
    [self cfy_setNavigationBarHidden:hidden];
}

- (void)cfy_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    UIViewController *vc = [self.viewControllers lastObject];
    [vc cfy_setNavigationBarHidden:hidden animated:animated];
    [self cfy_setNavigationBarHidden:hidden animated:animated];
}

- (void)cfy_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *fromVC = [self.viewControllers lastObject];
    [viewController cfy_setNavigationBarBackgroundColor:fromVC.cfy_navigationBarBackgroundColor];
    [self cfy_pushViewController:viewController animated:YES];
}
@end
