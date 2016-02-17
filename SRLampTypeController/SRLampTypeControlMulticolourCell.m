//
//  SRLampTypeControlMulticolourCell.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/16.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRLampTypeControlMulticolourCell.h"
#import "SRLampColor.h"

@implementation SRLampTypeControlMulticolourCell

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)lampTypeControlMulticolourCell {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SRLampTypeControlMulticolourCell" owner:nil options:nil];
    
    SRLampTypeControlMulticolourCell *cell = views.firstObject;
    
    return cell;
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    // Don't show cell's select state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

@end
