//
//  SRColorSlider.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/16.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRColorSlider.h"
#import "SRColor.h"

@implementation SRColorSlider

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

- (void)setColor:(SRColor *)color {
    if (color) {
        _color = color;
    }
    
    [_colorImageView updateSaturation:_color.HSV.saturation value:_color.HSV.value];
    
    CGFloat hue = color.HSV.hue;
    CGFloat newLeft = hue * (CGRectGetWidth(self.bounds) - 2 * SRColorSliderMargin) / 360.f;
    
    NSLog(@"hue %.2f, newleft %.2f", hue, newLeft);
    
    [UIView animateWithDuration:.25f animations:^ {
        _thumbButtonLeftConstraint.constant = newLeft;
    }];
}

- (void)layoutSubviews {
//    [self setColor:_color];
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    self.backgroundColor = [UIColor clearColor];
    _color = [[SRColor alloc] init];
    
    // Color ImageView
    _colorImageView = [[SRColorGradient alloc] init];
    _colorImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_colorImageView];
    // Constraints
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_colorImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1. constant:SRColorSliderMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_colorImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1. constant:-SRColorSliderMargin]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_colorImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1. constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_colorImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1. constant:13]];
    
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
            
            CGFloat newLeft = _thumbButtonLeftConstraint.constant + translation.x;
            CGFloat maxLeft = CGRectGetWidth(self.bounds) - 2 * SRColorSliderMargin;
            
            if (newLeft < 0) {
                newLeft = 0;
            } else if (newLeft > maxLeft) {
                newLeft = maxLeft;
            }
            
            _thumbButtonLeftConstraint.constant = newLeft;
            
            CGFloat hue = (newLeft * 360 / maxLeft);
            if (hue < 0) {
                hue = 0;
            } else if (hue > 359.99) {
                hue = 359.99;
            }
            SRColorHSV hsv;
            hsv.hue = hue;
            hsv.saturation = _colorImageView.saturation;
            hsv.value = _colorImageView.value;
            
            _color.HSV = hsv;
            
            if ([_delegate respondsToSelector:@selector(colorSlider:didColorChanged:)]) {
                
                [_delegate colorSlider:self didColorChanged:_color];
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
