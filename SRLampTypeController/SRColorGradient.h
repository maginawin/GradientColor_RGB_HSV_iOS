//
//  SRColorGradient.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/17.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRColor.h"

@interface SRColorGradient : UIView

/// [0, 1] 饱和度，当 RGB 改变时需要更改 saturation, default is 1
@property (nonatomic, readonly) CGFloat saturation;

/// [0, 1] 明度，当 RGB 改变时需要更改 value, default is 1
@property (nonatomic, readonly) CGFloat value;

/**
 * @brief 更改 saturation 与 value，仅当 type == SRColorGradientTypeWarmCold 时有效
 * @param saturation [0, 1] 饱和度
 * @param value [0, 1] 明度
 */
- (void)updateSaturation:(CGFloat)saturation value:(CGFloat)value;

@end
