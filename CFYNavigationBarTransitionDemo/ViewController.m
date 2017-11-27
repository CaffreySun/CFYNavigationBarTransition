//
//  ViewController.m
//  CFYNavigationBarTransitionDemo
//
//  Created by 孙洪伟 on 2017/2/28.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import "ViewController.h"
#import "CFYNavigationBarTransition.h"
#import "ColorPickerView.h"

#define TitleStr @"我是一只小小小小鸟想要飞却飞不高"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ColorPickerView *colorPickerView;
@property (weak, nonatomic) IBOutlet UISlider *alphaSlider;
@property (weak, nonatomic) IBOutlet ColorPickerView *shadowColorPickerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 随机标题
    NSMutableString *titleStr = [NSMutableString string];
    for (int i = 0; i < 3; i++) {
        [titleStr appendString:[TitleStr substringWithRange:NSMakeRange(arc4random()%TitleStr.length, 1)]];
    }
    self.title = titleStr;
    
    // 打开下面注释，则对于self.navigationController来说，本库提供的功能则不起作用
    //[self.navigationController closeCFYNavigationBarFunction:YES];
    
    // 随机颜色
    NSInteger red = arc4random()%255;
    NSInteger green = arc4random()%255;
    NSInteger blue = arc4random()%255;
    self.bgImageView.userInteractionEnabled = NO;
    [self cfy_setNavigationBarBackgroundColor:[UIColor colorWithRed:red/255. green:green/255. blue:blue/255. alpha:1]];
    
    
    __weak typeof(self) weakSelf = self;
    [self.colorPickerView colorPickerDidChangedBlock:^(ColorPickerView *colorPickerView, UIColor *currentColor) {
        [weakSelf cfy_setNavigationBarBackgroundColor:currentColor];
    }];
    [self.shadowColorPickerView colorPickerDidChangedBlock:^(ColorPickerView *colorPickerView, UIColor *currentColor) {
        [weakSelf cfy_setNavigationBarShadowImageBackgroundColor:currentColor];
    }];
    
    // 随机透明度
    CGFloat alpha = (arc4random()%100)/100.;
    [self cfy_setNavigationBarAlpha:alpha];
    self.alphaSlider.value = alpha;
}

- (void)dealloc {
    NSLog(@"dealloc");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.hideBar animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id <UIGestureRecognizerDelegate>)self.navigationController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushVCAction:(id)sender {
    [self performSegueWithIdentifier:@"ShowViewControllerId" sender:nil];
}
- (IBAction)popVCAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)popRootAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)showBarAction:(id)sender {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.hideBar = NO;
}
- (IBAction)hideBarAction:(id)sender {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.hideBar = YES;
}
- (IBAction)showBarAnimationAction:(id)sender {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.hideBar = NO;
}
- (IBAction)hideBarAnimationAction:(id)sender {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.hideBar = YES;
}
- (IBAction)alphaSliderValueChanged:(UISlider *)sender {
    [self cfy_setNavigationBarAlpha:sender.value];
}
- (IBAction)barImgAction:(id)sender {
    [self cfy_setNavigationBarBackgroundImage:[UIImage imageNamed:@"bgicon"]];
}
- (IBAction)barColorAction:(id)sender {
    [self cfy_setNavigationBarBackgroundImage:nil];
}
- (IBAction)shadowImageAction:(id)sender {
    [self cfy_setNavigationBarShadowImage:[UIImage imageNamed:@"shadowImage.png"]];
}
- (IBAction)shadowColorAction:(id)sender {
    [self cfy_setNavigationBarShadowImage:nil];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowViewControllerId"]) {
        ViewController *vc = (ViewController *)[segue destinationViewController];
        // 随机隐藏/显示
        vc.hideBar = arc4random()%2;
//        [vc.view layoutSubviews];
        //        [super prepareForSegue:segue sender:sender];
    }
    
}



@end
