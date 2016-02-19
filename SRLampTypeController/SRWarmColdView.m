//
//  SRWarmColdView.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/19.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRWarmColdView.h"

const CGFloat R_DIFF_LEFT = 0.10555556;
const CGFloat G_DIFF_LEFT = 0.83888889;
const CGFloat B_DIFF_LEFT = 1.41666667;
const CGFloat R_DIFF_RIGHT = 0.7777778;
const CGFloat G_DIFF_RIGHT = 0.3166667;
const CGFloat B_DIFF_RIGHT = 0.3111111;

@interface SRWarmColdView ()

@property (strong, nonatomic) UIColor *warmColor;
@property (strong, nonatomic) UIColor *coldColor;
@property (strong, nonatomic) UIColor *whiteColor;

@property (strong, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation SRWarmColdView

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

- (UIColor *)colorFromHue:(CGFloat)hue {
    if (hue < 0) {
        hue += 360;
    } else if (hue >= 360) {
        hue = 359.99;
    }
    
    UIColor *color;
    
    // 计算颜色
    if (hue == 0) {
        color = _warmColor.copy;
    } else if (hue >= 359.99) {
        color = _coldColor.copy;
    } else if (hue == 180) {
        color = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    } else if (hue > 180){ // Right
        hue -= 180;
        CGFloat r = (255 - hue * R_DIFF_RIGHT) / 255.f;
        CGFloat g = (255 - hue * G_DIFF_RIGHT) / 255.f;
        CGFloat b = (255 - hue * B_DIFF_RIGHT) / 255.f;
        
        color = [UIColor colorWithRed:r green:g blue:b alpha:1.f];
    } else { // Left
        CGFloat r = (hue * R_DIFF_LEFT + 236) / 255.f;
        CGFloat g = (hue * G_DIFF_LEFT + 104) / 255.f;
        CGFloat b = hue * B_DIFF_LEFT / 255.f;
        
        color = [UIColor colorWithRed:r green:g blue:b alpha:1.f];
    }
    
    return color;
}

- (void)drawRect:(CGRect)rect {
    _gradientLayer.frame = self.bounds;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    _gradientLayer.frame = self.bounds;
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    _warmColor = [UIColor colorWithRed:236/255.f green:104/255.f blue:0 alpha:1.f];
    _whiteColor = [UIColor whiteColor];
    _coldColor = [UIColor colorWithRed:115/255.f green:198/255.f blue:199/255.f alpha:1];
    
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        [self.layer addSublayer:_gradientLayer];
        
        _gradientLayer.colors = @[(id)_warmColor.CGColor, (id)_whiteColor.CGColor, (id)_coldColor.CGColor];
        _gradientLayer.locations = @[@0, @0.5, @1];
        _gradientLayer.startPoint = CGPointMake(0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1, 0.5);
    }
}

- (CGFloat *)compsFromColor:(UIColor *)color {
    CGFloat *comps;
    
    if (color) {
        const CGFloat *temp = CGColorGetComponents(color.CGColor);
        comps[0] = 255 * temp[0];
        comps[1] = 255 * temp[1];
        comps[2] = 255 * temp[2];
    } else {
        comps[0] = 255;
        comps[1] = 255;
        comps[2] = 255;
    }
    
    return comps;
}

@end
