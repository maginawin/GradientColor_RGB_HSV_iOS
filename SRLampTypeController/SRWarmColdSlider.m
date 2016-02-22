//
//  SRWarmColdSlider.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/18.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRWarmColdSlider.h"

@implementation SRWarmColdSlider

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

- (void)setHueNumber:(NSNumber *)hueNumber {
    if (!hueNumber) {
        return;
    }
    
    _hueNumber = hueNumber;
    
    CGFloat newLeft = (_hueNumber.floatValue * CGRectGetWidth(self.bounds) / 360.f);
    CGFloat maxLeft = CGRectGetWidth(self.bounds) - 2 * SRColorSliderMargin;
    
    if (newLeft < 0) {
        newLeft = 0;
    } else if (newLeft > maxLeft) {
        newLeft = maxLeft;
    }
    
    self.thumbButtonLeftConstraint.constant = newLeft;
}

- (void)setValueNumber:(NSNumber *)valueNumber {
    if (valueNumber) {
        _valueNumber = valueNumber;
        
        [_colorPicker setValue:valueNumber];
    }
}

- (void)setupDidInit {
    _colorPicker = [[SRWarmColdView alloc] init];
    _colorPicker.translatesAutoresizingMaskIntoConstraints = NO;
    _colorPicker.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_colorPicker];
    
    // Constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_colorPicker attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:SRColorSliderMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_colorPicker attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-SRColorSliderMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_colorPicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_colorPicker attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    [self setupDidInit1];
}

- (void)layoutSubviews {
    [self setHueNumber:_hueNumber];
    [self setValueNumber:_valueNumber];
}

- (void)setupDidInit1 {
    self.backgroundColor = [UIColor clearColor];
    
    // Thumb Button
    _thumbButton = [[ColorPickerImageView alloc] init];
    _thumbButton.translatesAutoresizingMaskIntoConstraints = NO;
    _thumbButton.userInteractionEnabled = YES;
    [self addSubview:_thumbButton];
    [_thumbButton setImage:[UIImage imageNamed:@"color_bar_control"]];
    
    // Constraints
    _thumbButtonLeftConstraint = [NSLayoutConstraint constraintWithItem:_thumbButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1. constant:0];
    [self addConstraint:_thumbButtonLeftConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_thumbButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1. constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_thumbButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1. constant:44]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_thumbButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1. constant:44]];
    // Gesture
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleThumbButtonGestureRecognizer:)];
    //    [_thumbButton addGestureRecognizer:tap];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleThumbButtonGestureRecognizer:)];
    [_thumbButton addGestureRecognizer:pan];
}


- (void)handleThumbButtonGestureRecognizer:(UIGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [(UIPanGestureRecognizer *)recognizer translationInView:self];
            
            CGFloat maxLeft = CGRectGetWidth(self.bounds) - 2 * SRColorSliderMargin;
            
            CGFloat hue = _hueNumber.floatValue + translation.x * 360.f / maxLeft;
            if (hue < 0) {
                hue = 0;
            } else if (hue > 359.99) {
                hue = 359.99;
            }
            
            [self setHueNumber:@(hue)];
            
            if ([_sliderDelegate respondsToSelector:@selector(warmColdSlider:didColorChanged:hueChanged:)]) {
                
                UIColor *color = [_colorPicker colorFromHue:_hueNumber.floatValue];
                [_sliderDelegate warmColdSlider:self didColorChanged:color hueChanged:@(hue)];
            }
            
            [(UIPanGestureRecognizer *)recognizer setTranslation:CGPointZero inView:self];
            
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            
            break;
        }
        default:
            break;
    }
}

@end
