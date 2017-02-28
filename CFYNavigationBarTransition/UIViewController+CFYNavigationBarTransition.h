//
//  UIViewController+CFYNavigationBarTransition.h
//  TestCorlorNav
//
//  Created by 孙洪伟 on 2017/2/27.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CFYNavigationBarTransition)
/**
 设置导航栏是否隐藏
 
 @param hidden 隐藏
 @param animated 动画
 */
- (void)cfy_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
