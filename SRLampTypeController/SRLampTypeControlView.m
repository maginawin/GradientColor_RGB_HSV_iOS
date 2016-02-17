//
//  SRLampTypeContorlView.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/1/31.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRLampTypeControlView.h"

@interface SRLampTypeControlView () <UITableViewDataSource, UITableViewDelegate, SRLampTypeControlColorCellDelegate>

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
}

- (NSUInteger)numbersOfSection {
    switch (_controlViewType) {
        case SRLampTypeControlViewTypeNONE:
            return 0;
        case SRLampTypeControlViewTypeRGBW:
        case SRLampTypeControlViewTypeRGB:
            return 2;
        case SRLampTypeControlViewTypeCCT:
        case SRLampTypeControlViewTypeDIM:
            return 1;
    }
    return 0;
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
    if (section == 0) {
        return _colorShowView;
    } else if (section == 1) {
        return _centerIntervalView;
    }
    
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 上部分控制区域
    if (indexPath.section == 0) {
        SRLampTypeControlWBCell *cell = [tableView dequeueReusableCellWithIdentifier:SRLampTypeControlWBCellIdentifer];
        if (!cell) {
            cell = [SRLampTypeControlWBCell lampTypeControlWBCell];
        }
        
        // 过滤 CCT 的 0、3 行（隐藏）
        // 防复用后 cell.hidden 为 YES，强制改为 NO
        cell.hidden = NO;
        if (_controlViewType == SRLampTypeControlViewTypeCCT) {
            if (indexPath.row == 0 || indexPath.row == 3) {
                cell.hidden = YES;
            }
        }
        
        cell.cellType = SRLampTypeControlWBCellWhite;
        int value = arc4random_uniform(101);
        cell.value = @(value);
        
        return cell;
    }
    // 下部分控制区域
    else if (indexPath.section == 1) {
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
    }
    // 防返回空值
    else {
        static NSString *placeholderID = @"placeholderID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:placeholderID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:placeholderID];
            cell.textLabel.text = @"";
            cell.backgroundColor = [UIColor colorWithRed:35/255.f green:35/255.f blue:35/255.f alpha:1.f];
        }
        return cell;
    }
    
    return  nil;
}

#pragma SRLampTypeControlColorCellDelegate

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
    
    if ([_delegate respondsToSelector:@selector(lampTypeControlView:didRGBChanged:)]) {
        [_delegate lampTypeControlView:self didRGBChanged:_lampColor];
    }
}

@end
