//
//  CFYSwizzle.h
//  TestCorlorNav
//
//  Created by CaffreySun on 2017/2/27.
//  Copyright © 2017年 appTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void CFYSwizzleMethod(Class cls, SEL originalSelector, SEL swizzledSelector);
