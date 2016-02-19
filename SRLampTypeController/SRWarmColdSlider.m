//
//  SRWarmColdSlider.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/18.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRWarmColdSlider.h"

@implementation SRWarmColdSlider

- (void)setColor:(SRColor *)color {
    [super setColor:color];
    
    self.color.color = [_colorPicker colorFromHue:self.color.HSV.hue];
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
    
    [super setupDidInit];    
    
    self.colorImageView.hidden = YES;
}

- (void)handleThumbButtonGestureRecognizer:(UIGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            
            CGPoint translation = [(UIPanGestureRecognizer *)recognizer translationInView:self];
            
            CGFloat newLeft = self.thumbButtonLeftConstraint.constant + translation.x;
            CGFloat maxLeft = CGRectGetWidth(self.bounds) - 2 * SRColorSliderMargin;
            
            if (newLeft < 0) {
                newLeft = 0;
            } else if (newLeft > maxLeft) {
                newLeft = maxLeft;
            }
            
            self.thumbButtonLeftConstraint.constant = newLeft;
            
            CGFloat hue = (newLeft * 360 / maxLeft);
            if (hue < 0) {
                hue = 0;
            } else if (hue > 359.99) {
                hue = 359.99;
            }
            SRColorHSV hsv;
            hsv.hue = hue;
            hsv.saturation = self.colorImageView.saturation;
            hsv.value = self.colorImageView.value;
            
            self.color.HSV = hsv;
            
            self.color.color = [_colorPicker colorFromHue:self.color.HSV.hue];
            
            if ([_sliderDelegate respondsToSelector:@selector(warmColdSlider:didColorChanged:)]) {
                
                [_sliderDelegate warmColdSlider:self didColorChanged:self.color];
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
