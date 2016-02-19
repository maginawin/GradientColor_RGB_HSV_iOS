//
//  SRLampTypeControlMulticolourCell.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/16.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRLampTypeControlMulticolourCell.h"
#import "SRLampColor.h"

const CGFloat MulticolourCellTrailingMarginDefault = 62.f;
const CGFloat MulticolourCellTrailingMarginWarmCold = 24.f;

@interface SRLampTypeControlMulticolourCell () <SRColorSliderDelegate>

/// 进度条与右边对齐的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorSliderTrailingMargin;

@end

@implementation SRLampTypeControlMulticolourCell

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

+ (instancetype)lampTypeControlMulticolourCell {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SRLampTypeControlMulticolourCell" owner:nil options:nil];
    
    SRLampTypeControlMulticolourCell *cell = views.firstObject;
    
    return cell;
}

- (void)setLampColor:(SRLampColor *)lampColor {
    if (lampColor) {
        _lampColor = lampColor;
        
        _colorSlider.color = _lampColor.color;
        _startButton.selected = _lampColor.isStart.boolValue;
    }
}

- (IBAction)startButtonClicked:(id)sender {
    BOOL isSelected = [sender isSelected];
    
    [sender setSelected:!isSelected];
    
    _lampColor.isStart = @(!isSelected);
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlMulticolourCell:didIsStartChanged:)]) {
        [_delegate lampTypeControlMulticolourCell:self didIsStartChanged:_lampColor.isStart.boolValue];
    }
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    // Don't show cell's select state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor clearColor]; 
    _startButton.selected = NO;
    
    // Parameters
    _lampColor = [[SRLampColor alloc] init];
    
    _colorSlider.delegate = self;
}

#pragma mark - SRColorSliderDelegate

- (void)colorSlider:(SRColorSlider *)slider didColorChanged:(SRColor *)color {
    _lampColor.color = color.copy;
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlMulticolourCell:didLampColorChanged:)]) {
        
        [_delegate lampTypeControlMulticolourCell:self didLampColorChanged:_lampColor];
    }
}

@end
