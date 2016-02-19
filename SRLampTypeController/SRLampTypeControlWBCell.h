//
//  SRLampTypeControlWBCell.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/1/31.
//  Copyright © 2016年 sunricher. All rights reserved.
//

// SRLampTypeControlView's controlTableView Cell
// Use for the top control view's white and brightness control
// Had two types: White control and brightness control
// The max value is 100
// Cell identifier is: SRLampTypeControlWBCellIdentifer

#import <UIKit/UIKit.h>
@class SRLampTypeControlWBCell;

#define SRLampTypeControlWBCellIdentifer @"SRLampTypeControlWBCellIdentifer"

@protocol SRLampTypeControlWBCellDelegate <NSObject>

@optional

- (void)lampTypeControlWBCell:(SRLampTypeControlWBCell *)cell didValueChanged:(NSNumber *)value;

@end

typedef NS_ENUM(NSInteger, SRLampTypeControlWBCellType) {
    SRLampTypeControlWBCellWhite = 0,
    SRLampTypeControlWBCellBrightness = 1
};

@interface SRLampTypeControlWBCell : UITableViewCell

@property (weak, nonatomic) id<SRLampTypeControlWBCellDelegate> delegate;

@property (nonatomic) SRLampTypeControlWBCellType cellType;

// Value is a NSNumber type with NSUInteger in 0 ~ 100
@property (strong, nonatomic) NSNumber *value;

+ (instancetype)lampTypeControlWBCell;

@end
