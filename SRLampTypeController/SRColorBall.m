//
//  SRColorBall.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/19.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRColorBall.h"

@implementation SRColorBall

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

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (_ballColor) {
        CGContextSetFillColorWithColor(ctx, _ballColor.CGColor);
    }
    
    CGContextAddEllipseInRect(ctx, self.bounds);
    CGContextFillPath(ctx);
}

- (void)setBallColor:(UIColor *)ballColor {
    if (ballColor) {
        _ballColor = ballColor;
        
        [self setNeedsDisplay];
    }
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    self.backgroundColor = [UIColor clearColor];
    
    _ballColor = [UIColor redColor];
}

@end
