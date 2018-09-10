//
//  NavigationController.m
//  CFYNavigationBarTransitionDemo
//
//  Created by sunhw on 2018/9/10.
//  Copyright © 2018年 appTeam. All rights reserved.
//

#import "NavigationController.h"
#import "CFYNavigationBarTransition.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self closeCFYNavigationBarFunction:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
