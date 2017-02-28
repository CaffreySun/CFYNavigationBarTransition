//
//  ColorPickView.h
//  渐变色
//
//  Created by admin on 16/5/18.
//  Copyright © 2016年 Caffrey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ColorPickerView;

typedef void(^ColorPickerViewColorChangedBlock)(ColorPickerView *colorPickerView, UIColor *currentColor);

@interface ColorPickerView : UIView

@property (nonatomic, strong, readonly) UIColor *currentColor;

- (void)colorPickerDidChangedBlock:(ColorPickerViewColorChangedBlock)block;

@end
