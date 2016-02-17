//
//  SRColor.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/16.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>

struct SRColorHSV {
    CGFloat hue; //!< 0 ~ 359，色相（色调）
    CGFloat saturation; //!< 0 ~ 1， 饱和度（值越大颜色越饱和）
    CGFloat value; //!< 0 ~ 1，明度（0黑1白）
};
/**
 * @param hue(CGFloat) [0, 359] 色相
 * @param saturation(CGFloat) [0, 1] 饱和度（值越大颜色越鲜艳）
 * @param value(CGFlaot) [0, 1] 明度（0黑，1白）
 */
typedef struct SRColorHSV SRColorHSV;

struct SRColorRGB {
    CGFloat red; //!< 0 ~ 255
    CGFloat green; //!< 0 ~ 255
    CGFloat blue; //!< 0 ~ 255
};
/// params:red, blue, green. CGFloat [0, 255]
typedef struct SRColorRGB SRColorRGB;

@interface SRColor : NSObject <NSCopying, NSMutableCopying>

@property (nonatomic) SRColorHSV HSV;

@property (nonatomic) SRColorRGB RGB;

@property (strong, nonatomic) UIColor *color;

/// 根据 _RGB 来重新计算 HSV，如果是只改变 _RGB 中某一个值的话，必须调用此方法更新 _HSV
//- (void)updateHSV; // 不需要，struct 不能单个赋值

/// 根据 _HSV 来重新计算 RGB，如果只改变 _HSV 中某一个值的话，必须调用此方法更新 _RGB
//- (void)updateRGB; // 不需要，struct 不能单个赋值

@end
