//
//  SRLampTypeContorlView.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/1/31.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRLampTypeControlView.h"

@interface SRLampTypeControlView () <UITableViewDataSource, UITableViewDelegate, SRLampTypeControlColorCellDelegate, SRLampTypeControlMulticolourCellDelegate, SRLampTypeControlWarmColdCellDelegate, SRLampTypeControlWBCellDelegate>

/// 展示颜色的视图
@property (strong, nonatomic) UIView *colorShowView;
/// 中间间隔视图
@property (strong, nonatomic) UIView *centerIntervalView;
/// Row 的高度，在改变 type 时更新，且最小为 44
@property (nonatomic) CGFloat rowHeight;

@end

@implementation SRLampTypeControlView

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

- (void)setLampColor:(SRLampColor *)lampColor {
    if (lampColor) {
        _lampColor = lampColor;
    }
    
    [_controlTableView reloadData];
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    self.layer.masksToBounds = NO;
    
    // Init Parameters
    _controlViewType = SRLampTypeControlViewTypeNONE;
    _lampColor = [[SRLampColor alloc] init];
    
    // colorShowView & centralIntervalView
    _colorShowView = [[UIView alloc] init];
    _colorShowView.backgroundColor = [UIColor lightGrayColor];
    _centerIntervalView = [[UIView alloc] init];
    _centerIntervalView.backgroundColor = [UIColor colorWithRed:24/255.f green:24/255.f blue:24/255.f alpha:1.f];
    
    // controlTableView
    _controlTableView = [[UITableView alloc] init];
    _controlTableView.delegate = self;
    _controlTableView.dataSource = self;
    _controlTableView.backgroundColor = [UIColor colorWithRed:35/255.f green:35/255.f blue:35/255.f alpha:1.f];
    _controlTableView.separatorColor = [UIColor clearColor];
    _controlTableView.delaysContentTouches = NO;
    
    // controlTableView constraints setting
    [self addSubview:_controlTableView];
    _controlTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_controlTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_controlTableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_controlTableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_controlTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
}

- (void)setControlViewType:(SRLampTypeControlViewType)controlViewType {
//    // 每次重置颜色
//    _lampColor = [[SRLampColor alloc] init];
    
    _controlTableView.scrollEnabled = NO;
    
    _controlViewType = controlViewType;
    
    CGFloat contentHeight = CGRectGetHeight(_controlTableView.bounds) - 10;
    
    switch (controlViewType) {
        case SRLampTypeControlViewTypeNONE: {
        _rowHeight = 0;
            
            break;
        }
        case SRLampTypeControlViewTypeRGBW: {
            _rowHeight = floor(contentHeight / 6.f);
        
            break;
        }
        case SRLampTypeControlViewTypeRGB: {
            _rowHeight = floor(contentHeight / 5.f);
        
            break;
        }
        case SRLampTypeControlViewTypeCCT: {
            _rowHeight = floor(contentHeight / 4.f);
        
            break;
        }
        case SRLampTypeControlViewTypeDIM: {
            _rowHeight = floor(contentHeight / 1.f);
        
            break;
        }
    }
    
    if (_rowHeight < 44) {
        _controlTableView.scrollEnabled = YES;
        _rowHeight = 44;
    }
    
    [_controlTableView reloadData];
//    [_controlTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlView:didLampColorChanged:)] && controlViewType != SRLampTypeControlViewTypeCCT) {
        [_delegate lampTypeControlView:self didLampColorChanged:_lampColor];
    }
}

- (NSUInteger)numbersOfSection {
    switch (_controlViewType) {
        case SRLampTypeControlViewTypeNONE:
            return 1;
        case SRLampTypeControlViewTypeRGBW:
        case SRLampTypeControlViewTypeRGB:
            return 2;
        case SRLampTypeControlViewTypeCCT:
        case SRLampTypeControlViewTypeDIM:
            return 1;
    }
    return 1;
}

- (NSUInteger)numbersOfRowAtSection:(NSInteger)section {
    if (section == 0) {
        switch (_controlViewType) {
            case SRLampTypeControlViewTypeNONE:
                return 0;
            case SRLampTypeControlViewTypeRGBW:
                return 3;
            case SRLampTypeControlViewTypeRGB:
                return 2;
            case SRLampTypeControlViewTypeCCT:
                // 仅是为了布局好看，在 return UITableViewCell 中过滤 0、3 行
                return 4;
            case SRLampTypeControlViewTypeDIM:
                return 1;
        }
    } else if (section == 1) {
        return 3;
    }
    
    return 0;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self numbersOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numbersOfRowAtSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    } else if (section == 1) {
        return 2;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    
    if (section == 0) {
        view.backgroundColor = _lampColor.color.color;
        _colorShowView = view;
    } else if (section == 1) {
        view.backgroundColor = [UIColor colorWithRed:24/255.f green:24/255.f blue:24/255.f alpha:1.f];
        _centerIntervalView = view;
    }
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 上部分控制区域
    if (indexPath.section == 0) {
        switch (_controlViewType) {
            case SRLampTypeControlViewTypeRGBW: {
                if (indexPath.row == 0) {
//                    SRLampTypeControlMulticolourCell *cell = [tableView dequeueReusableCellWithIdentifier:SRLampTypeControlMulticolourCellIdentifier];
                    SRLampTypeControlMulticolourCell *cell = nil;
                    
                    if (!cell) {
                        cell = [SRLampTypeControlMulticolourCell lampTypeControlMulticolourCell];
                    }
                    
                    cell.lampColor = _lampColor;                    
                    cell.delegate = self;
                    
                    return cell;
                } else if (indexPath.row == 1) { // White
                    SRLampTypeControlWBCell *cell = [SRLampTypeControlWBCell lampTypeControlWBCell];
                    
                    cell.delegate = self;
                    cell.cellType = SRLampTypeControlWBCellWhite;
                    cell.value = _lampColor.white;
                    
                    return cell;
                } else if (indexPath.row == 2) { // Brightness
                    SRLampTypeControlWBCell *cell = [SRLampTypeControlWBCell lampTypeControlWBCell];
                    
                    cell.delegate = self;
                    cell.cellType = SRLampTypeControlWBCellBrightness;
                    cell.value = @(_lampColor.color.HSV.value * 100);
                    
                    return cell;
                }
                
                break;
            }
                
            case SRLampTypeControlViewTypeRGB: {
                if (indexPath.row == 0) {
//                    SRLampTypeControlMulticolourCell *cell = [tableView dequeueReusableCellWithIdentifier:SRLampTypeControlMulticolourCellIdentifier];
                    
                    SRLampTypeControlMulticolourCell *cell = nil;
                    
                    if (!cell) {
                        cell = [SRLampTypeControlMulticolourCell lampTypeControlMulticolourCell];
                    }
                    
                    cell.lampColor = _lampColor;
                    cell.delegate = self;
                    
                    return cell;
                }
            
                break;
            }
                
            case SRLampTypeControlViewTypeCCT: {
                if (indexPath.row == 1) {
                    SRLampTypeControlWarmColdcell *cell = nil;
                    
                    if (!cell) {
                        cell = [SRLampTypeControlWarmColdcell lampTypeControlWarmColdCell];
                    }
                    cell.lampColor = _lampColor;
                    
                    cell.delegate = self;
                    
                    _colorShowView.backgroundColor = _lampColor.color.color;
                    
                    if ([_delegate respondsToSelector:@selector(lampTypeControlView:didLampColorChanged:)]) {
                        [_delegate lampTypeControlView:self didLampColorChanged:_lampColor];
                    }
                    
                    return cell;
                }
            
                break;
            }
            case SRLampTypeControlViewTypeDIM: {
            
                break;
            }
                
            case SRLampTypeControlViewTypeNONE: {
                break;
            }
        }
        
        // 补全其他
        static NSString *placeholderID1 = @"placeholderID1";
        UITableViewCell *cell = nil;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:placeholderID1];
            cell.textLabel.text = @"";
            cell.backgroundColor = [UIColor clearColor];
            cell.hidden = YES;
        }
        
        return cell;
    }
    // 下部分控制区域
    else if (indexPath.section == 1) {
        if (!_lampColor.isStart.boolValue) {
            SRLampTypeControlColorCell *cell = [tableView dequeueReusableCellWithIdentifier:SRLampTypeControlColorCellIdentifier];
            if (!cell) {
                cell = [SRLampTypeControlColorCell lampTypeControlColorCell];
            }
            
            // 给红绿黄赋值
            SRLampTypeControlColorCellType type = indexPath.row % 3;
            cell.cellType = type;
            
            SRColor *tempColor = _lampColor.color;
            SRColorRGB tempRGB = tempColor.RGB;
            // 改颜色
            switch (type) {
                case SRLampTypeControlColorCellTypeRed: {
                    cell.value = @(tempRGB.red);
                    
                    break;
                }
                case SRLampTypeControlColorCellTypeGreen: {
                    cell.value = @(tempRGB.green);
                    
                    break;
                }
                case SRLampTypeControlColorCellTypeBlue: {
                    cell.value = @(tempRGB.blue);
                    
                    break;
                }
            }
            
            cell.delegate = self;
            
            return cell;
        } else {
            SRColorBallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kColorBallTableViewCellIdentifier];
            
            if (!cell) {
                cell = [SRColorBallTableViewCell colorBallTableViewCell];
            }
            
            cell.colors = @[[UIColor redColor], [UIColor blueColor], [UIColor greenColor], [UIColor clearColor]];
            
            return cell;
        }
    }
    // 防返回空值
    else {
        static NSString *placeholderID = @"placeholderID";
        UITableViewCell *cell = nil;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:placeholderID];
            cell.textLabel.text = @"";
            cell.backgroundColor = [UIColor colorWithRed:35/255.f green:35/255.f blue:35/255.f alpha:1.f];
            cell.hidden = YES;
        }
        return cell;
    }
    
    return  nil;
}

#pragma mark - SRLampTypeControlMulticolourCellDelegate

- (void)lampTypeControlMulticolourCell:(SRLampTypeControlMulticolourCell *)cell didIsStartChanged:(BOOL)isStart {
    NSNumber *isStartNumber = @(isStart);
    
    _lampColor.isStart = isStartNumber;
    
    // 更新 Section1 的布局
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    [_controlTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationLeft];
    
    // 告之外界，StartButton.isSelected has changed.
    if ([_delegate respondsToSelector:@selector(lampTypeControlView:didLampColorChanged:)]) {
        [_delegate lampTypeControlView:self didLampColorChanged:_lampColor];
    }
}

- (void)lampTypeControlMulticolourCell:(SRLampTypeControlMulticolourCell *)cell didLampColorChanged:(SRLampColor *)lampColor {
    if (lampColor && (_controlViewType == SRLampTypeControlViewTypeRGBW || _controlViewType == SRLampTypeControlViewTypeRGB)) {
        _lampColor.color = lampColor.color.copy;
        
        if (!_lampColor.isStart.boolValue) {
            // Reload RGB Cells
            NSIndexPath *indexPath10 = [NSIndexPath indexPathForRow:0 inSection:1];
            NSIndexPath *indexPath11 = [NSIndexPath indexPathForRow:1 inSection:1];
            NSIndexPath *indexPath12 = [NSIndexPath indexPathForRow:2 inSection:1];
            
            SRLampTypeControlColorCell *cell10 = [_controlTableView cellForRowAtIndexPath:indexPath10];
            SRLampTypeControlColorCell *cell11 = [_controlTableView cellForRowAtIndexPath:indexPath11];
            SRLampTypeControlColorCell *cell12 = [_controlTableView cellForRowAtIndexPath:indexPath12];
            
            if (cell10) {
                cell10.value = @(_lampColor.color.RGB.red);
            }
            
            if (cell11) {
                cell11.value = @(_lampColor.color.RGB.green);
            }
            
            if (cell12) {
                cell12.value = @(_lampColor.color.RGB.blue);
            }

        }
        
        }
    
    _colorShowView.backgroundColor = _lampColor.color.color;
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlView:didLampColorChanged:)]) {
        [_delegate lampTypeControlView:self didLampColorChanged:_lampColor];
    }
}

#pragma mark - SRLampTypeControlColorCellDelegate

- (void)lampTypeControlColorCell:(SRLampTypeControlColorCell *)cell didValueChanged:(NSNumber *)value {
    NSUInteger valueInteger = value.integerValue;
    
    SRColorRGB tempRGB = _lampColor.color.RGB;
    
    switch (cell.cellType) {
        case SRLampTypeControlColorCellTypeRed: {
            tempRGB.red = valueInteger;
            
            break;
        }
        case SRLampTypeControlColorCellTypeGreen: {
            tempRGB.green = valueInteger;
        
            break;
        }
        case SRLampTypeControlColorCellTypeBlue: {
            tempRGB.blue = valueInteger;
        
            break;
        }
    }
    
    _lampColor.color.RGB = tempRGB;
    
    _colorShowView.backgroundColor = _lampColor.color.color;
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlView:didLampColorChanged:)]) {
        [_delegate lampTypeControlView:self didLampColorChanged:_lampColor];
    }
    
    switch (_controlViewType) {
        case SRLampTypeControlViewTypeRGBW: {
            NSIndexPath *indexPath00 = [NSIndexPath indexPathForRow:0 inSection:0];
            NSIndexPath *indexPath02 = [NSIndexPath indexPathForRow:2 inSection:0];
            
            SRLampTypeControlMulticolourCell *cell00 = [_controlTableView cellForRowAtIndexPath:indexPath00];
            
            if (cell00) {
                cell00.lampColor = _lampColor;
            }
            
            SRLampTypeControlWBCell *cell02 = [_controlTableView cellForRowAtIndexPath:indexPath02];
            
            if (cell02) {
                cell02.value = @(_lampColor.color.HSV.value * 100);
            }
            
            break;
        }
            
        case SRLampTypeControlViewTypeRGB: {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            
            SRLampTypeControlMulticolourCell *cell = [_controlTableView cellForRowAtIndexPath:indexPath];
            
            if (cell) {
                cell.lampColor = _lampColor;
            }
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - SRLampTypeControlWarmColdCellDelegate

- (void)lampTypeControlWarmColdCell:(SRLampTypeControlWarmColdcell *)cell didChangedLampColor:(SRLampColor *)lampColor {
    self.colorShowView.backgroundColor = lampColor.color.color;
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlView:didLampColorChanged:)]) {
        [_delegate lampTypeControlView:self didLampColorChanged:_lampColor];
    }
}

#pragma mark - SRLampTypeControlWBCellDelegate

- (void)lampTypeControlWBCell:(SRLampTypeControlWBCell *)cell didValueChanged:(NSNumber *)value {
    
    switch (cell.cellType) {
        case SRLampTypeControlWBCellWhite: {
            _lampColor.white = value;
        
            break;
        }
            
        case SRLampTypeControlWBCellBrightness: {
            SRColorHSV hsv = _lampColor.color.HSV;
            hsv.value = value.integerValue / 100.f;
            
            _lampColor.color.HSV = hsv;
            
            // Reload ColorShow
            _colorShowView.backgroundColor = _lampColor.color.color;
            
            if (_controlViewType == SRLampTypeControlViewTypeRGBW) {
                // Reload RGB Cells
                NSIndexPath *indexPath00 = [NSIndexPath indexPathForRow:0 inSection:0];
                NSIndexPath *indexPath10 = [NSIndexPath indexPathForRow:0 inSection:1];
                NSIndexPath *indexPath11 = [NSIndexPath indexPathForRow:1 inSection:1];
                NSIndexPath *indexPath12 = [NSIndexPath indexPathForRow:2 inSection:1];
                
                SRLampTypeControlMulticolourCell *cell00 = [_controlTableView cellForRowAtIndexPath:indexPath00];
                if (cell00) {
                    cell00.lampColor = _lampColor;
                }
                
                SRLampTypeControlColorCell *cell10 = [_controlTableView cellForRowAtIndexPath:indexPath10];
                SRLampTypeControlColorCell *cell11 = [_controlTableView cellForRowAtIndexPath:indexPath11];
                SRLampTypeControlColorCell *cell12 = [_controlTableView cellForRowAtIndexPath:indexPath12];
                
                if (cell10) {
                    cell10.value = @(_lampColor.color.RGB.red);
                }
                
                if (cell11) {
                    cell11.value = @(_lampColor.color.RGB.green);
                }
                
                if (cell12) {
                    cell12.value = @(_lampColor.color.RGB.blue);
                }
            }
            
            break;
        }
    }    
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlView:didLampColorChanged:)]) {
        [_delegate lampTypeControlView:self didLampColorChanged:_lampColor];
    }
}

@end
