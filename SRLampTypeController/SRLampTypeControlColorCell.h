//
//  SRLampTypeControlTableViewCell.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/1/31.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SRLampTypeControlColorCell;

@protocol SRLampTypeControlColorCellDelegate <NSObject>

@optional

- (void)lampTypeControlColorCell:(SRLampTypeControlColorCell *)cell didValueChanged:(NSNumber *)value;

@end

#define SRLampTypeControlColorCellIdentifier @"SRLampTypeControlColorCellIdentifier"

typedef NS_ENUM(NSInteger, SRLampTypeControlColorCellType) {
    SRLampTypeControlColorCellTypeRed = 0,
    SRLampTypeControlColorCellTypeGreen = 1,
    SRLampTypeControlColorCellTypeBlue = 2
};

@interface SRLampTypeControlColorCell : UITableViewCell

@property (weak, nonatomic) id<SRLampTypeControlColorCellDelegate> delegate;

@property (nonatomic) SRLampTypeControlColorCellType cellType;

/// Value is a NSNumber type with NSUInteger in 0 ~ 255
@property (strong, nonatomic) NSNumber *value;

+ (instancetype)lampTypeControlColorCell;

@end
