//
//  SRColorBallTableViewCell.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/19.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRColorBall.h"

extern NSString *const kColorBallTableViewCellIdentifier;

@interface SRColorBallTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@property (strong, nonatomic) IBOutletCollection(SRColorBall) NSArray *colorBalls;

@property (strong, nonatomic) NSArray<UIColor *> *colors;

+ (instancetype)colorBallTableViewCell;


@end
