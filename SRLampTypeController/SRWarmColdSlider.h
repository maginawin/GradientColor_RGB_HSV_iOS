//
//  SRWarmColdSlider.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/18.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRColorSlider.h"
#import "SRWarmColdView.h"

@class SRColorSlider;

@protocol SRWarmColdSliderDelegate <NSObject>

@optional

- (void)warmColdSlider:(SRColorSlider *)slider didColorChanged:(SRColor *)srColor hueChanged:(NSNumber *)hueNumber;

@end

@interface SRWarmColdSlider : SRColorSlider

@property (weak, nonatomic) id<SRWarmColdSliderDelegate> sliderDelegate;

@property (strong, nonatomic) SRWarmColdView *colorPicker;

/// Hue for slider location, [0, 360)
@property (strong, nonatomic) NSNumber *hueNumber;

@end
