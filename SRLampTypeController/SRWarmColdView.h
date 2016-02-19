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

- (UIColor *)colorFromHue:(CGFloat)hue;

@end
