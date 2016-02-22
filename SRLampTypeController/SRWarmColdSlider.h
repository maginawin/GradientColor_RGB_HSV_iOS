//
//  SRWarmColdSlider.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/18.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRColorSlider.h"
#import "SRWarmColdView.h"

@class SRWarmColdSlider;

@protocol SRWarmColdSliderDelegate <NSObject>

@optional

- (void)warmColdSlider:(SRWarmColdSlider *)slider didColorChanged:(UIColor *)color hueChanged:(NSNumber *)hueNumber;

@end

@interface SRWarmColdSlider : UIView

@property (weak, nonatomic) id<SRWarmColdSliderDelegate> sliderDelegate;

@property (strong, nonatomic) SRWarmColdView *colorPicker;

/// Hue for slider location, [0, 360)
@property (strong, nonatomic) NSNumber *hueNumber;

@property (strong, nonatomic) NSNumber *valueNumber;

/// 拔动按钮
@property (strong, nonatomic) ColorPickerImageView *thumbButton;

/// 拔动按钮与左边的约束, default is 0 and Max is (self.width - SRColorSliderMargin * 2)
@property (strong, nonatomic) NSLayoutConstraint *thumbButtonLeftConstraint;

@end
