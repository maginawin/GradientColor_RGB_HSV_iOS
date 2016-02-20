//
//  SRColorSpeedTableViewCell.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/20.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRColorSpeedTableViewCell.h"

NSString *const kColorSpeedTableViewCellIdentifier = @"kColorSpeedTableViewCellIdentifier";

@implementation SRColorSpeedTableViewCell

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

+ (instancetype)colorSpeedTableViewCell {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SRColorSpeedTableViewCell" owner:nil options:nil];
    
    SRColorSpeedTableViewCell *cell = views.firstObject;
    
    return cell;
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cellLabel.text = NSLocalizedString(@"speed", nil);
    
    // Speed slider setting
    _speedSlider.minimumValue = 0;
    _speedSlider.maximumValue = 100;
    
    [_speedSlider setMinimumTrackImage:[UIImage imageNamed:@"color_white"] forState:UIControlStateNormal];
    [_speedSlider setMaximumTrackImage:[UIImage imageNamed:@"color_white"] forState:UIControlStateNormal];
    [_speedSlider setThumbImage:[UIImage imageNamed:@"thumb_white"] forState:UIControlStateNormal];
    
    _speedSlider.value = 100;
    
    [_speedSlider addTarget:self action:@selector(handleSpeedSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)handleSpeedSliderValueChanged:(UISlider *)slider {
    if ([_delegate respondsToSelector:@selector(colorSpeedTableViewCell:didSpeedValueChanged:)]) {
        [_delegate colorSpeedTableViewCell:self didSpeedValueChanged:slider.value];
    }
}

@end
