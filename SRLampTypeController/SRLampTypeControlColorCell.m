//
//  SRLampTypeControlTableViewCell.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/1/31.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRLampTypeControlColorCell.h"

@interface SRLampTypeControlColorCell ()

@property (strong, nonatomic) UILabel *valueLabel;
@property (strong, nonatomic) UISlider *valueSlider;

@property (nonatomic) NSUInteger maxValue;


@end

@implementation SRLampTypeControlColorCell

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

+ (instancetype)lampTypeControlColorCell {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SRLampTypeControlColorCell" owner:nil options:nil];
    
    SRLampTypeControlColorCell *cell = views.firstObject;
    
    return cell;
}

- (void)setCellType:(SRLampTypeControlColorCellType)cellType {
    _cellType = cellType;
    
    switch (cellType) {
        case SRLampTypeControlColorCellTypeRed: {
            [_valueSlider setMinimumTrackImage:[UIImage imageNamed:@"color_red"] forState:UIControlStateNormal];
            [_valueSlider setMaximumTrackImage:[UIImage imageNamed:@"color_red"] forState:UIControlStateNormal];
            [_valueSlider setThumbImage:[UIImage imageNamed:@"thumb_red"] forState:UIControlStateNormal];
            
        
            break;
        }
        case SRLampTypeControlColorCellTypeGreen: {
            [_valueSlider setMinimumTrackImage:[UIImage imageNamed:@"color_green"] forState:UIControlStateNormal];
            [_valueSlider setMaximumTrackImage:[UIImage imageNamed:@"color_green"] forState:UIControlStateNormal];
            [_valueSlider setThumbImage:[UIImage imageNamed:@"thumb_green"] forState:UIControlStateNormal];
            
            break;
        }
        case SRLampTypeControlColorCellTypeBlue: {
            [_valueSlider setMinimumTrackImage:[UIImage imageNamed:@"color_blue"] forState:UIControlStateNormal];
            [_valueSlider setMaximumTrackImage:[UIImage imageNamed:@"color_blue"] forState:UIControlStateNormal];
            [_valueSlider setThumbImage:[UIImage imageNamed:@"thumb_blue"] forState:UIControlStateNormal];
        
            break;
        }
    }
}

- (void)setValue:(NSNumber *)value {
    if (value && value.integerValue <= _maxValue && value.integerValue >= 0) {
        _value = @(value.integerValue);
        
        _valueLabel.text = _value.stringValue;
        [_valueSlider setValue:_value.floatValue animated:YES];
    }
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    // valueSlieder Init
    // Because of IBOutlet bug in set maximumTrackTintColor
    _valueSlider = [[UISlider alloc] init];
    [self addSubview:_valueSlider];
    _valueSlider.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_valueSlider attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:24]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_valueSlider attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-44]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_valueSlider attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    // valueLabel Init
    _valueLabel = [[UILabel alloc] init];
    _valueLabel.textAlignment = NSTextAlignmentLeft;
    _valueLabel.font = [UIFont systemFontOfSize:11.f];
    _valueLabel.textColor = [UIColor whiteColor];
    [self addSubview:_valueLabel];
    _valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_valueLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_valueSlider attribute:NSLayoutAttributeTrailing multiplier:1 constant:8]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_valueLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_valueSlider attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    // Param
    _maxValue = 255;
    _valueSlider.minimumValue = 0;
    _valueSlider.maximumValue = _maxValue;
    [self setValue:@(0)];
    
    [_valueSlider addTarget:self action:@selector(valueSliederValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self setValue:@(0)];
}

- (void)valueSliederValueChanged:(UISlider *)valueSlider {
    NSUInteger changedValue = valueSlider.value;
    
    _value = @(changedValue);
    _valueLabel.text = _value.stringValue;
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlColorCell:didValueChanged:)]) {
        [_delegate lampTypeControlColorCell:self didValueChanged:_value];
    }
}

@end
