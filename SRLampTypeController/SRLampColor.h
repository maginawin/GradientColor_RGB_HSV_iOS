//
//  SRLampColor.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/1/31.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <Foundation/Foundation.h>
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

@end
