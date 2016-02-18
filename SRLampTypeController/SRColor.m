//
//  SRColor.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/16.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRColor.h"

@implementation SRColor

- (instancetype)init {
    self = [super init];
    if (self) {
        _HSV.hue = 0;
        _HSV.saturation = 1;
        _HSV.value = 1;
        
        [self updateRGB];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    SRColor *color = [[[self class] allocWithZone:zone] init];
    
    [color setHSV:self.HSV];
    
    return color;
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    SRColor *color = [[[self class] allocWithZone:zone] init];
    
    [color setHSV:self.HSV];
    
    return color;
}

- (void)updateHSV {
    _HSV = [self hsvFromRGB:_RGB];
    
    _color = [UIColor colorWithRed:_RGB.red / 255.f green:_RGB.green / 255.f blue:_RGB.blue / 255.f alpha:1.f];
}

- (void)updateRGB {
    _RGB = [self rgbFromHSV:_HSV];
    
    _color = [UIColor colorWithRed:_RGB.red / 255.f green:_RGB.green / 255.f blue:_RGB.blue / 255.f alpha:1.f];
}

/// 当 RGB 值变化时，自动更新 HSV
- (void)setRGB:(SRColorRGB)RGB {
    _RGB = RGB;
    
    [self updateHSV];
}

- (void)setHSV:(SRColorHSV)HSV {
    _HSV = HSV;
    
    [self updateRGB];
}

- (void)setColor:(UIColor *)color {
    if (color) {
        _color = color;
        
        // Update RGB and HSV from color
        const CGFloat *colors = CGColorGetComponents(_color.CGColor);
        
        _RGB.red = 255.f * colors[0];
        _RGB.green = 255.f * colors[1];
        _RGB.blue = 255.f * colors[2];
        
        [self updateHSV];
    }
}

#pragma mark - ------- Private -------

- (SRColorHSV)hsvFromRGB:(SRColorRGB)rgb {
    rgb.red /= 255.f;
    rgb.green /= 255.f;
    rgb.blue /= 255.f;
    
    SRColorHSV hsv;
    
    CGFloat M = MAX(MAX(rgb.red, rgb.green), rgb.blue);
    CGFloat m = MIN(MIN(rgb.red, rgb.green), rgb.blue);
    CGFloat C = M - m;
    
    // 计算 H 的 radius
    CGFloat HRadius = _HSV.hue;
//    if (C == 0) {
//        HRadius = 0; // Undefined
//    } else
    if (C != 0) {
        if (M == rgb.red) {
            HRadius = fmod(((rgb.green - rgb.blue) / C), 6);
        } else if (M == rgb.green) {
            HRadius = ((rgb.blue - rgb.red) / C) + 2;
        } else if (M == rgb.blue) {
            HRadius = ((rgb.red - rgb.green) / C) + 4;
        }
        
        // 计算 HSV.hue
        hsv.hue = HRadius * 60;
        if (hsv.hue < 0) {
            hsv.hue += 360;
        }
    }
    
    // 计算 HSV.value
    hsv.value = M;
    
    // 计算 HSV.S
    if (C == 0) {
        hsv.saturation = 0;
    } else {
        hsv.saturation = C / hsv.value;
    }
    
    return hsv;
}

- (SRColorRGB)rgbFromHSV:(SRColorHSV)hsv {
    SRColorRGB rgb;
    
//    UIColor *color = [UIColor colorWithHue:hsv.hue saturation:hsv.saturation brightness:hsv.value alpha:1.f];
//    
//    const CGFloat *colors = CGColorGetComponents(color.CGColor);
//    
//    rgb.red = colors[0] * 255.f;
//    rgb.green = colors[1] * 255.f;
//    rgb.blue = colors[2] * 255.f;
    
    // 计算 C
    CGFloat C = hsv.value * hsv.saturation;
    
    // 计算 HRadius
//    if (hsv.hue < 0) { //!< If hue is undefined
//        rgb.red = 0;
//        rgb.green = 0;
//        rgb.blue = 0;
//    } else
    CGFloat HRadius = hsv.hue / 60.f;
    NSLog(@"hue %.2f hradius %.2f", hsv.hue, HRadius);
    CGFloat X = C * (1 - fabs(fmod(HRadius, 2) - 1.f));
    
    CGFloat r1 = 0;
    CGFloat g1 = 0;
    CGFloat b1 = 0;
    
    if (HRadius >= 0 && HRadius < 1) {
        r1 = C;
        g1 = X;
    } else if (HRadius >= 1 && HRadius < 2) {
        r1 = X;
        g1 = C;
    } else if (HRadius >= 2 && HRadius < 3) {
        g1 = C;
        b1 = X;
    } else if (HRadius >= 3 && HRadius < 4) {
        g1 = X;
        b1 = C;
    } else if (HRadius >= 4 && HRadius < 5) {
        r1 = X;
        b1 = C;
    } else if (HRadius >= 5 && HRadius < 6) {
        r1 = C;
        b1 = X;
    }
    
    // 计算 RGB
    CGFloat m = hsv.value - C;
    rgb.red = r1 + m;
    rgb.green = g1 + m;
    rgb.blue = b1 + m;
    
    rgb.red *= 255.f;
    rgb.green *= 255.f;
    rgb.blue *= 255.f;
    
    NSLog(@"r %d, g %d, b %d, radius %.2f", rgb.red, rgb.green, rgb.blue, HRadius);
    
    return rgb;
}

@end
