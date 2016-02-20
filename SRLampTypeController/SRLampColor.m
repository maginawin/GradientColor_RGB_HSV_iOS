//
//  SRLampColor.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/1/31.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRLampColor.h"

@implementation SRLampColor

- (instancetype)init {
    self = [super init];
    if (self) {
        self.color = [[SRColor alloc] init];
        self.white = @(100);
        self.jumpState = @(NO);
        self.isStart = @(NO);
        
        self.speed = @(100);
        self.jumpModeType = SRColorJumpModeTypeFade;
        self.jumpColors = @[];
        self.warmColdHueNumber = @(0);
    }
    return self;
}

@end
