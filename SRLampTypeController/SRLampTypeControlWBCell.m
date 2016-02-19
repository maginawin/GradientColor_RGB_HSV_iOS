//
//  SRLampTypeControlWBCell.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/1/31.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRLampTypeControlWBCell.h"

@interface SRLampTypeControlWBCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UISlider *valueSlider;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@property (nonatomic) NSUInteger maxValue;

@end

@implementation SRLampTypeControlWBCell

- (void)awakeFromNib {
    [self setupDidInit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)lampTypeControlWBCell {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SRLampTypeControlWBCell" owner:nil options:nil];
    
    SRLampTypeControlWBCell *cell = views.firstObject;
    
    return cell;
}

- (void)setCellType:(SRLampTypeControlWBCellType)cellType {
    _cellType = cellType;
    
    switch (cellType) {
        case SRLampTypeControlWBCellWhite: {
            // White's image setting
            _cellImageView.image = [UIImage imageNamed:@""];
        
            break;
        }
        case SRLampTypeControlWBCellBrightness: {
            // Brightness's image setting
            _cellImageView.image = [UIImage imageNamed:@""];
        
            break;
        }
    }
}

- (void)setValue:(NSNumber *)value {
    if (value && value.integerValue <= _maxValue && value.integerValue >= 0) {
        _value = @(value.integerValue);
        
        _valueLabel.text = _value.stringValue;
        [_valueSlider setValue:_value.integerValue animated:YES];
    }
}

#pragma mark - ------- Private -------

- (void)setupDidInit {

    // valueSlider setting
    [_valueSlider setMinimumTrackImage:[UIImage imageNamed:@"color_white"] forState:UIControlStateNormal];
    [_valueSlider setMaximumTrackImage:[UIImage imageNamed:@"color_white"] forState:UIControlStateNormal];
    [_valueSlider setThumbImage:[UIImage imageNamed:@"thumb_white"] forState:UIControlStateNormal];
    _valueSlider.minimumValue = 0;
    _maxValue = 100;
    _valueSlider.maximumValue = _maxValue;
    [_valueSlider addTarget:self action:@selector(valueSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)valueSliderValueChanged:(UISlider *)slider {
    NSUInteger value = slider.value;
    
    _value = @(value);
    _valueLabel.text = _value.stringValue;
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlWBCell:didValueChanged:)]) {
        [_delegate lampTypeControlWBCell:self didValueChanged:_value];
    }
}

@end
