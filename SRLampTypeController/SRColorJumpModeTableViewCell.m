//
//  SRColorJumpModeTableViewCell.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/20.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRColorJumpModeTableViewCell.h"

NSString *const kColorJumpModeCellIdentifier = @"kColorJumpModeCellIdentifier";

@implementation SRColorJumpModeTableViewCell

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

+ (instancetype)colorJumpModeTableViewCell {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SRColorJumpModeTableViewCell" owner:nil options:nil];
    
    SRColorJumpModeTableViewCell *cell = views.firstObject;
    
    return cell;
}

- (void)setJumpModeType:(SRColorJumpModeType)jumpModeType {
    if (jumpModeType < 1 || jumpModeType > 4) {
        return;
    }
    
    if (_jumpModeType > 0 && _jumpModeType <= 4) {
        UIButton *selectedButton = _jumpModeButtons[_jumpModeType - 1];
        selectedButton.selected = NO;
    }
    
    _jumpModeType = jumpModeType;
    
    if (_jumpModeType > 0 && _jumpModeType <= 4) {
        UIButton *selectedButton = _jumpModeButtons[_jumpModeType - 1];
        selectedButton.selected = YES;
    }
}

- (IBAction)jumpButtonsClicked:(id)sender {
    UIButton *clickedButton = (UIButton *)sender;
    
    SRColorJumpModeType type = clickedButton.tag + 1;
    
    if (!clickedButton.isSelected) {
        [self setJumpModeType:type];
    }
    
    if ([_delegate respondsToSelector:@selector(colorJumpModeTableViewCell:didChangedType:)]) {
        [_delegate colorJumpModeTableViewCell:self didChangedType:_jumpModeType];
    }
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    // Buttons title
    int i = 0;
    for (UIButton *button in _jumpModeButtons) {
        NSString *localizedString = [NSString stringWithFormat:@"jump%d", i];
        NSString *title = NSLocalizedString(localizedString, nil);
        
        [button setTitle:title forState:UIControlStateNormal];
        
        ++i;
    }
    i = 0;
    
    // Default type is jump
    [self setJumpModeType:SRColorJumpModeTypeJump];
}

@end
