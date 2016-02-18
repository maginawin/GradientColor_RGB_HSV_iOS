//
//  SRColorGradient.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/17.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SRColor;

/**
 * @prarm Multicolour 彩色
 * @prarm WarmCold 冷暖色
 */
typedef NS_ENUM(NSInteger, SRColorGradientType) {
    SRColorGradientTypeMulticolour = 0,
    SRColorGradientTypeWarmCold
};

@interface SRColorGradient : UIView

/// Gradient type， default is SRColorGradientTypeMulticolour
@property (nonatomic) SRColorGradientType type;

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

/**
 * @brief 当 type 为 WarmCold 时，需要传入 hue 来取得 UIColor
 * @param hue[0, 360) 在 HSV 中的 hue，也作为 SRColorSlider 的 currentValue
 * @return 当前 currentValue 的颜色（UIColor）
 */
- (UIColor *)colorFromHueValue:(CGFloat)hue;

@end
