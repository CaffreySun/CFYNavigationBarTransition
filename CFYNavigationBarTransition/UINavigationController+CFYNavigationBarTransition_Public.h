//
//  UINavigationController+CFYNavigationBarTransition_Public.h
//  TestCorlorNav
//
//  Created by CaffreySun on 2017/2/28.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CFYNavigationBarTransition_Public)

/**
 设置导航栏背景色
 
 @param color 背景色
 */
- (void)cfy_setNavigationBarBackgroundColor:(UIColor *)color;

/**
 设置背景图片

 @param image 背景图
 */
- (void)cfy_setNavigationBarBackgroundImage:(UIImage * _Nullable )image;

/**
 设置导航栏透明度
 
 @param alpha 透明度，值为0 ~ 1.0
 */
- (void)cfy_setNavigationBarAlpha:(CGFloat)alpha;

/**
 设置导航栏底部线条颜色

 @param color 线条颜色,color为nil时，使用默认颜色RGBA(0, 0, 0, 0.3)
 */
- (void)cfy_setNavigationBarShadowImageBackgroundColor:(UIColor * _Nullable )color;


/**
 设置导航栏底部线条图片

 @param image 图片为nil时线条使用纯色
 */
- (void)cfy_setNavigationBarShadowImage:(UIImage * _Nullable )image;

/**
 bar背景色
 */
@property (readonly) UIColor *cfy_navigationBarBackgroundColor;

/**
 保存navigationBar背景图片
 */
@property (readonly) UIImage *cfy_navigationBarBackgroundImage;

/**
 bar透明度
 */
@property (readonly) CGFloat cfy_navigationBarAlpha;

/**
 shadowImage
 */
@property (readonly) UIImage *cfy_shadowImage;

/**
 shadowImageColor
 */
@property (readonly) UIColor *cfy_shadowImageColor;

@end

@interface UINavigationController (CFYNavigationBarTransition_Public)

/**
 关闭库的功能
 
 @param close 是否关闭
 */
- (void)closeCFYNavigationBarFunction:(BOOL)close DEPRECATED_MSG_ATTRIBUTE("use openCFYNavigationBarFunction: instead");
    
/**
 是否关闭
 */
@property (readonly) BOOL isCloseCFYNavigationBar DEPRECATED_MSG_ATTRIBUTE("use isOpenedCFYNavigationBar instead");;
    
/**
 打开库的功能
 
 @param open 是否打开
 */
- (void)openCFYNavigationBarFunction:(BOOL)open;
    
/**
 是否打开
 */
@property (readonly) BOOL isOpenedCFYNavigationBar;

@end

NS_ASSUME_NONNULL_END
