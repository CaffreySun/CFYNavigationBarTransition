//
//  CFYNavigationBar.h
//  CFYNavigationBarTransitionDemo
//
//  Created by Caffrey on 2017/3/7.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFYNavigationBar : UIView

/**
 shadowImage图片
 可以为null,为null时使用背景色
 */
@property (nonatomic, strong) UIImage *cfy_shadowImage;

/**
 shadowImage的颜色
 cfy_shadowImage为null时才显示颜色
 */
@property (nonatomic, strong) UIColor *cfy_shadowImageColor;

/**
 保存navigationBar颜色
 */
@property (nonatomic, strong) UIColor *cfy_navigationBarBackgroundColor;


/**
 保存navigationBar图片
 */
@property (nonatomic, strong) UIImage *cfy_navigationBarBackgroundImage;

@end
