//
//  SRColorSlider.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/16.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRColorGradient.h"
#import "ColorPickerImageView.h"

@class SRColorSlider;

#define SRColorSliderMargin (20.f)

NS_ASSUME_NONNULL_BEGIN

@protocol SRColorSliderDelegate <NSObject>

@optional

- (void)colorSlider:(nonnull SRColorSlider *)slider didColorChanged:(nonnull SRColor *)color;

@end

@interface SRColorSlider : UIView

@property (weak, nonatomic) id<SRColorSliderDelegate> delegate;

///  进度条的值，以 Color 对象来保存
@property (strong, nonatomic) SRColor *color;

/// 渐变背景视图
@property (strong, nonatomic) SRColorGradient *colorImageView;

/// 拔动按钮
@property (strong, nonatomic) ColorPickerImageView *thumbButton;

/// 拔动按钮与左边的约束, default is 0 and Max is (self.width - SRColorSliderMargin * 2)
@property (strong, nonatomic) NSLayoutConstraint *thumbButtonLeftConstraint;

- (void)handleThumbButtonGestureRecognizer:(UIGestureRecognizer *)recognizer;

- (void)setupDidInit;

@end

NS_ASSUME_NONNULL_END