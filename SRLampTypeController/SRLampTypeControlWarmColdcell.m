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
        
        _warmColdSlider.color = _lampColor.color;
    }
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _warmColdSlider.sliderDelegate = self;
}

#pragma mark - SRWarmColdSliderDelegate

- (void)warmColdSlider:(SRColorSlider *)slider didColorChanged:(SRColor *)srColor {
    _lampColor.color = srColor;
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlWarmColdCell:didChangedLampColor:)]) {
        [_delegate lampTypeControlWarmColdCell:self didChangedLampColor:_lampColor];
    }
}

@end
