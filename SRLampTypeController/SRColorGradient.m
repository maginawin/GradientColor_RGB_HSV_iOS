//
//  SRColorGradient.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/17.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRColorGradient.h"
#import "ColorPickerImageView.h"

@interface SRColorGradient ()

/// 7 个颜色，红、黄、绿、青、蓝、品红、红，只是他们的 saturation 与 value 相同且与正常的颜色不同
@property (strong, nonatomic) NSMutableArray<SRColor *> *colors;

/// Multicolour 的渐变条
@property (strong, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation SRColorGradient

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupDidInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDidInit];
    }
    return self;
}

- (void)awakeFromNib {
    [self setupDidInit];
}

// 更改饱和度与明度
- (void)updateSaturation:(CGFloat)saturation value:(CGFloat)value {    
    _saturation = saturation;
    _value = value;
    
    for (SRColor *srColor in _colors) {
        SRColorHSV hsv;
        hsv.hue = srColor.HSV.hue;
        hsv.saturation = _saturation;
        hsv.value = _value;
        
        srColor.HSV = hsv;
    }
    
    // 需要重绘
    [self setupGradientLayer];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [self setupGradientLayer];
}

#pragma mark - ------- Private ------- 

- (void)setupDidInit {
    // Setup Multicolour Bar's colors
    if (!_colors) {
        _colors = [NSMutableArray array];
    }
    
    [_colors removeAllObjects];
    
    for (int i = 0; i < 7; i++) {
        SRColor *color = [[SRColor alloc] init];
        
        SRColorHSV hsv;
        hsv.hue = 60 * i % 360;
        hsv.saturation = 1;
        hsv.value = 1;
        
        color.HSV = hsv;
        
        [_colors addObject:color];
    }
    
    _saturation = 1;
    _value = 1;
    
    // Multicolour Bar Init
    if (!_gradientLayer) {
        CAGradientLayer *layer = [CAGradientLayer layer];
        
        CGPoint start = CGPointMake(0, 0.5);
        CGPoint end = CGPointMake(1, 0.5);
        NSArray *locations = @[@0, @(1/6.f), @(1/3.f), @(1/2.f), @(2/3.f), @(5/6.f), @1];
        
        layer.startPoint = start;
        layer.endPoint = end;
        layer.locations = locations;
        
        _gradientLayer = layer;
        
        [self.layer addSublayer:_gradientLayer];
    }
}

- (void)setupGradientLayer {
    if (!_gradientLayer) {
        CAGradientLayer *layer = [CAGradientLayer layer];
        
        CGPoint start = CGPointMake(0, 0.5);
        CGPoint end = CGPointMake(1, 0.5);
        NSArray *locations = @[@0, @(1/6.f), @(1/3.f), @(1/2.f), @(2/3.f), @(5/6.f), @1];
        
        layer.startPoint = start;
        layer.endPoint = end;
        layer.locations = locations;
        
        _gradientLayer = layer;
        
        [self.layer addSublayer:_gradientLayer];
    }
    
    _gradientLayer.frame = self.bounds;
    
    if (_colors.count == 7) {
        NSMutableArray *colorsMutable = [NSMutableArray array];
        
        for (SRColor *srColor in _colors) {
            UIColor *color = srColor.color;
            
            [colorsMutable addObject:(id)(color.CGColor)];
        }
        
        _gradientLayer.colors = colorsMutable;
    }
}

@end
