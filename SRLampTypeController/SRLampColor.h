//
//  SRLampColor.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/1/31.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRColorJumpModeTableViewCell.h"
#import "SRColor.h"

/// 灯的颜色类
@interface SRLampColor : NSObject

/**
 * @param HSV(struct)
 * @param RGB(struct)
 * @param color(UIColor)
 */
@property (strong, nonatomic) SRColor *color;

/// 0 ~ 100 白灯, default is @(100)
@property (strong, nonatomic) NSNumber *white;

/// bool, is jump switch, default is @(NO)
@property (strong, nonatomic) NSNumber *jumpState;

/// bool, is start
@property (strong, nonatomic) NSNumber *isStart;

/// speed [0, 100], only effective when isStart is @(ON)
@property (strong, nonatomic) NSNumber *speed;

/// jumpColors, only effective when isStart is @(ON)
@property (strong, nonatomic) NSArray<UIColor *> *jumpColors;

/// jumpModeType, only effective when isStart is @(ON)
@property (nonatomic) SRColorJumpModeType jumpModeType;

/// warm cold hue number [0, 360)
@property (strong, nonatomic) NSNumber *warmColdHueNumber;

@end
