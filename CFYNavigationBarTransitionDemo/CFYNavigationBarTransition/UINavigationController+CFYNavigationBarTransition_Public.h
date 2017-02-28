//
//  UINavigationController+CFYNavigationBarTransition_Public.h
//  TestCorlorNav
//
//  Created by 孙洪伟 on 2017/2/28.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CFYNavigationBarTransition_Public)

/**
 设置导航栏背景色
 
 @param color 背景色
 */
- (void)cfy_setNavigationBarBackgroundColor:(UIColor *)color;

/**
 设置导航栏透明度
 
 @param alpha 透明度
 */
- (void)cfy_setNavigationBarAlpha:(CGFloat)alpha;

/**
 bar背景色
 */
@property (readonly) UIColor *cfy_navigationBarBackgroundColor;


/**
 bar透明度
 */
@property (readonly) CGFloat cfy_navigationBarAlpha;

@end
