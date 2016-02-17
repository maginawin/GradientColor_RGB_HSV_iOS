//
//  SRLampTypeControlMulticolourCell.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/16.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SRLampColor;
@class SRLampTypeControlMulticolourCell;

@protocol SRLampTypeControlMulticolourCellDelegate <NSObject>

@optional

/// Lamp color did changed.
- (void)lampTypeControlMulticolourCell:(SRLampTypeControlMulticolourCell *)cell didLampColorChanged:(SRLampColor *)lampColor;

/// Is start button's isSelected did changed
- (void)lampTypeControlMulticolourCell:(SRLampTypeControlMulticolourCell *)cell didIsStartChanged:(BOOL)isStart;

@end

@interface SRLampTypeControlMulticolourCell : UITableViewCell

/// Cell's delegate
@property (weak, nonatomic) id<SRLampTypeControlMulticolourCellDelegate> delegate;

/// Is start button is selected.
@property (nonatomic) BOOL isStart;

/// Only use Red, Green, Blue properties.
@property (strong, nonatomic) SRLampColor *lampColor;

/// @return multicolour cell instance.
+ (instancetype)lampTypeControlMulticolourCell;

@end
