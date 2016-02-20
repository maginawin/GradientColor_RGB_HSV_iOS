//
//  SRColorSpeedTableViewCell.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/20.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SRColorSpeedTableViewCell;

extern NSString *const kColorSpeedTableViewCellIdentifier;

@protocol SRColorSpeedTableViewCellDelegate <NSObject>

@optional

- (void)colorSpeedTableViewCell:(SRColorSpeedTableViewCell *)cell didSpeedValueChanged:(CGFloat)value;

@end

@interface SRColorSpeedTableViewCell : UITableViewCell
/// Value extent [0, 100]
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@property (weak, nonatomic) id<SRColorSpeedTableViewCellDelegate> delegate;

+ (instancetype)colorSpeedTableViewCell;

@end
