//
//  UIImage+CFYNavigationBarTransition.h
//  TestCorlorNav
//
//  Created by CaffreySun on 2017/2/27.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CFYNavigationBarTransition)
+ (UIImage *)cfy_imageWithColor:(UIColor *)color withFrame:(CGRect)frame;
+ (UIImage *)cfy_imageWithColor:(UIColor *)color;
@end
