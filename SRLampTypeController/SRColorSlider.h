//
//  SRColorSlider.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/16.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SRColor;
@class SRColorSlider;

#define SRColorSliderMargin (11.f)

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SRColorType) {
    SRColorTypeNone = 0, //!< 未初始化，无背景图，无颜色值返回
    SRColorTypeMulticolour = 1, //!< 彩色类型
    SRColorTypeWarmCold = 2 //!< 冷暖色类型
};

@protocol SRColorSliderDelegate <NSObject>

@optional

- (void)colorSlider:(nonnull SRColorSlider *)slider didColorChanged:(nonnull SRColor *)color;

@end

@interface SRColorSlider : UIView

@property (weak, nonatomic) id<SRColorSliderDelegate> delegate;

///  进度条的值，以 Color 对象来保存
@property (strong, nonatomic) SRColor *color;

/// 颜色类型，有彩色与冷暖色两种
@property (nonatomic) SRColorType colorType;

@end

NS_ASSUME_NONNULL_END