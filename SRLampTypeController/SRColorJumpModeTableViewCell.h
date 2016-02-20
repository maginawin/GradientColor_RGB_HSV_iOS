//
//  SRColorJumpModeTableViewCell.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/20.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SRColorJumpModeTableViewCell;

extern NSString *const kColorJumpModeCellIdentifier;

typedef NS_ENUM(NSInteger, SRColorJumpModeType) {
    SRColorJumpModeTypeJump = 1,
    SRColorJumpModeTypeFlash = 2,
    SRColorJumpModeTypeFade = 3,
    SRColorJumpModeTypeStrobe = 4
};

@protocol SRColorJumpModeTableViewCellDelegate <NSObject>

@optional

- (void)colorJumpModeTableViewCell:(SRColorJumpModeTableViewCell *)cell didChangedType:(SRColorJumpModeType)type;

@end

@interface SRColorJumpModeTableViewCell : UITableViewCell

@property (nonatomic) SRColorJumpModeType jumpModeType;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *jumpModeButtons;

@property (weak, nonatomic) id<SRColorJumpModeTableViewCellDelegate> delegate;

+ (instancetype)colorJumpModeTableViewCell;

@end
