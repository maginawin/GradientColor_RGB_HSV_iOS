//
//  SRWarmColdView.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/19.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 用于冷暖色的背景
@interface SRWarmColdView : UIView

/// [0, 1] 明度
@property (strong, nonatomic) NSNumber *value;

- (UIColor *)colorFromHue:(CGFloat)hue;

///**
// * @param hue : 色相
// * @param value : 明度
// * @return UIColor at hue and value, the saturation is default
// */
//- (UIColor *)colorFromHue:(CGFloat)hue value:(CGFloat)value;

@end
