//
//  SRLampTypeControlWarmColdcell.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/18.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRWarmColdSlider.h"
#import "SRLampColor.h"
@class SRLampTypeControlWarmColdcell;

#define SRLampTypeControlWarmColdCellIdentifier @"WarmColdCellIdentifier"

@protocol SRLampTypeControlWarmColdCellDelegate <NSObject>

@optional

- (void)lampTypeControlWarmColdCell:(SRLampTypeControlWarmColdcell *)cell didChangedLampColor:(SRLampColor *)lampColor;

@end

@interface SRLampTypeControlWarmColdcell : UITableViewCell <SRWarmColdSliderDelegate>

@property (weak, nonatomic) IBOutlet SRWarmColdSlider *warmColdSlider;

/// Only use Red, Green, Blue properties.
@property (strong, nonatomic) SRLampColor *lampColor;

@property (weak, nonatomic) id<SRLampTypeControlWarmColdCellDelegate> delegate;

+ (instancetype)lampTypeControlWarmColdCell;

@end
