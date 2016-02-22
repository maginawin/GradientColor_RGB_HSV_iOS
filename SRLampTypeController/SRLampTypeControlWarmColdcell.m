//
//  SRLampTypeControlWarmColdcell.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/18.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRLampTypeControlWarmColdcell.h"

@implementation SRLampTypeControlWarmColdcell

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)lampTypeControlWarmColdCell {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SRLampTypeControlWarmColdcell" owner:nil options:nil];
    
    SRLampTypeControlWarmColdcell *cell = views.firstObject;
    
    return cell;
}

- (void)setLampColor:(SRLampColor *)lampColor {
    if (lampColor) {
        _lampColor = lampColor;
        
        _warmColdSlider.valueNumber = @(_lampColor.color.HSV.value);
        NSLog(@"%@", _warmColdSlider.valueNumber);
        
        _lampColor.color.color = [_warmColdSlider.colorPicker colorFromHue:_lampColor.color.HSV.hue];
        
        SRColorHSV hsv = _lampColor.color.HSV;
        hsv.value = _warmColdSlider.valueNumber.floatValue;
        
        NSLog(@"%@", _warmColdSlider.valueNumber);
        
        _lampColor.color.HSV = hsv;
        
        [self setHueNumber:_lampColor.warmColdHueNumber];
    }
}

- (void)setHueNumber:(NSNumber *)hueNumber {
    if (hueNumber) {
        _hueNumber = hueNumber;
        
        _warmColdSlider.hueNumber = hueNumber;
    }
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _warmColdSlider.sliderDelegate = self;
}

#pragma mark - SRWarmColdSliderDelegate

- (void)warmColdSlider:(SRWarmColdSlider *)slider didColorChanged:(UIColor *)color hueChanged:(NSNumber *)hueNumber {
    _lampColor.color.color = color.copy;
    _lampColor.warmColdHueNumber = hueNumber;    
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlWarmColdCell:didChangedLampColor:warmColdNumber:)]) {
        [_delegate lampTypeControlWarmColdCell:self didChangedLampColor:_lampColor warmColdNumber:hueNumber];
    }
}

@end
