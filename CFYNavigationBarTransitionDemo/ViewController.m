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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ColorPickerView *colorPickerView;
@property (weak, nonatomic) IBOutlet UISlider *alphaSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger red = arc4random()%255;
    NSInteger green = arc4random()%255;
    NSInteger blue = arc4random()%255;
    // 随机颜色
    [self cfy_setNavigationBarBackgroundColor:[UIColor colorWithRed:red/255. green:green/255. blue:blue/255. alpha:1]];
    
    [self.colorPickerView colorPickerDidChangedBlock:^(ColorPickerView *colorPickerView, UIColor *currentColor) {
        [self cfy_setNavigationBarBackgroundColor:currentColor];
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.hideBar animated:YES];
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

- (void)setHideBar:(BOOL)hideBar {
    _hideBar = hideBar;
    if (hideBar) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id <UIGestureRecognizerDelegate>)self.navigationController;
    }
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
        //        [super prepareForSegue:segue sender:sender];
    }
    
}



@end
