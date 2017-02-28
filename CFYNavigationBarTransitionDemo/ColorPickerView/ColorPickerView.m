//
//  ColorPickView.m
//  渐变色
//
//  Created by admin on 16/5/18.
//  Copyright © 2016年 Caffrey. All rights reserved.
//

#import "ColorPickerView.h"

@interface ColorPickerView ()<UIGestureRecognizerDelegate>
@property (nonatomic, copy) ColorPickerViewColorChangedBlock changedBlock;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) CAGradientLayer *gradientColorLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation ColorPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //        [self initializeView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //        [self initializeView];
    }
    return self;
}

- (void)layoutSubviews {
    self.gradientColorLayer.frame = self.bounds;
    /**< 设置颜色组 */
    self.gradientColorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                                  (__bridge id)[UIColor purpleColor].CGColor,
                                  (__bridge id)[UIColor blueColor].CGColor,
                                  (__bridge id)[UIColor cyanColor].CGColor,
                                  (__bridge id)[UIColor greenColor].CGColor,
                                  (__bridge id)[UIColor yellowColor].CGColor,
                                  (__bridge id)[UIColor redColor].CGColor
                                  ];
    /**< 设置渐变颜色方向 */
    // 1、起始位置
    self.gradientColorLayer.startPoint = CGPointMake(0, 0);
    // 2、结束位置
    self.gradientColorLayer.endPoint   = CGPointMake(1, 0);
    
    
    self.gradientLayer.frame = self.bounds;
    // 设置颜色渐变方向
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint   = CGPointMake(0, 1);
    
    // 设定颜色组
    self.gradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor,
                             (__bridge id)[UIColor clearColor].CGColor,
                             (__bridge id)[UIColor blackColor].CGColor];
}

- (void)didMoveToSuperview {
    [self initializeView];
}

- (void)initializeView {
    /**< 初始化渐变层 */
    CAGradientLayer *gradientColorLayer = [CAGradientLayer layer];
    [self.layer addSublayer:gradientColorLayer];
    self.gradientColorLayer = gradientColorLayer;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    [self.layer addSublayer:gradientLayer];
    self.gradientLayer = gradientLayer;
    
    // 设定颜色分割点
    //gradientLayer.locations = @[@(0.1f),@(0.5f), @(0.9f)];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePanGestures:)];
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 1;
    
    [self addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tapGesture];
    
    panGesture.delegate = self;
    tapGesture.delegate = self;
}

- (void)handlePanGestures:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state != UIGestureRecognizerStateBegan && panGesture.state != UIGestureRecognizerStateEnded) {
        CGPoint point = [panGesture locationInView:panGesture.view];
        if (point.x > panGesture.view.bounds.size.width) {
            point.x = panGesture.view.bounds.size.width - 1;
        }
        if (point.y > panGesture.view.bounds.size.height) {
            point.y = panGesture.view.bounds.size.height - 1;
        }
        
        point.x = point.x < 1 ? 1 : point.x;
        point.y = point.y < 1 ? 1 : point.y;
        
        self.currentColor = [self colorOfUIView:self Point:point];
    }
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    CGPoint point = [tapGesture locationInView:tapGesture.view];
    self.currentColor = [self colorOfUIView:self Point:point];
}

#pragma mark - UIGestureRecognizerDelegate -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (UIColor *)colorOfUIView:(UIView *)view Point:(CGPoint)point  {
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [view.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

- (void)colorPickerDidChangedBlock:(ColorPickerViewColorChangedBlock)block {
    self.changedBlock = block;
}

- (void)setCurrentColor:(UIColor *)currentColor {
    _currentColor = currentColor;
    if (self.changedBlock) {
        self.changedBlock(self,_currentColor);
    }
}

@end
