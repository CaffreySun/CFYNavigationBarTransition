//
//  UIImage+CFYNavigationBarTransition.m
//  TestCorlorNav
//
//  Created by CaffreySun on 2017/2/27.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import "UIImage+CFYNavigationBarTransition.h"

@implementation UIImage (CFYNavigationBarTransition)
+ (UIImage *)cfy_imageWithColor:(UIColor *)color withFrame:(CGRect)frame {
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+ (UIImage *)cfy_imageWithColor:(UIColor *)color {
    return [UIImage cfy_imageWithColor:color withFrame:CGRectMake(0, 0, 1, 1)];
}
@end
