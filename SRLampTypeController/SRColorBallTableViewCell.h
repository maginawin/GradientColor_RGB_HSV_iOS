//
//  SRColorBallTableViewCell.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/19.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRColorBall.h"
@class SRColorBallTableViewCell;

extern NSString *const kColorBallTableViewCellIdentifier;

@protocol SRColorBallTableViewCellDelegate <NSObject>

@optional

- (void)colorBallTableViewCellDidClicked:(SRColorBallTableViewCell *)cell;

@end

@interface SRColorBallTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@property (strong, nonatomic) IBOutletCollection(SRColorBall) NSArray *colorBalls;

@property (strong, nonatomic) NSArray<UIColor *> *colors;

@property (weak, nonatomic) id<SRColorBallTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

+ (instancetype)colorBallTableViewCell;

@end
