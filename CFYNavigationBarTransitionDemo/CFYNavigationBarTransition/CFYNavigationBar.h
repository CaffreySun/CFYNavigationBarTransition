//
//  CFYNavigationBar.h
//  CFYNavigationBarTransitionDemo
//
//  Created by Caffrey on 2017/3/7.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFYNavigationBar : UIView

@property (nonatomic, strong) UIImage *cfy_shadowImage;
@property (nonatomic, strong) UIColor *cfy_shadowImageColor;
/**
 保存navigationBar颜色
 */
@property (nonatomic, strong) UIColor *cfy_navigationBarBackgroundColor;

/**
 保存navigationBar颜色透明度
 */
@property (nonatomic, strong) NSNumber *cfy_navigationBarAlpha;

@end
