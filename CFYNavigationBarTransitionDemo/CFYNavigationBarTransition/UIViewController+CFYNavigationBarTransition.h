//
//  UIViewController+CFYNavigationBarTransition.h
//  TestCorlorNav
//
//  Created by CaffreySun on 2017/2/27.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

// UIViewController CFYNavigationBarTransition
@interface UIViewController (CFYNavigationBarTransition)
/**
 设置导航栏是否隐藏
 
 @param hidden 隐藏
 @param animated 动画
 */
- (void)cfy_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

/**
 根据上一个导航栏透明度设置当前导航栏都名都
 库内部方法，外部调用会有问题奥
 @param alpha 透明度，值为0 ~ 1.0
 */
- (void)cfy_setNavigationBarAlphaFromLastNavBar:(CGFloat)alpha;

@end
