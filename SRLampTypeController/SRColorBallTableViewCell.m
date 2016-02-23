//
//  SRColorBallTableViewCell.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/2/19.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "SRColorBallTableViewCell.h"

NSString *const kColorBallTableViewCellIdentifier = @"kColorBallTableViewCellIdentifier";

@interface SRColorBallTableViewCell ()

@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) NSInteger multiply;

@end

@implementation SRColorBallTableViewCell

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

+ (instancetype)colorBallTableViewCell {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"SRColorBallTableViewCell" owner:nil options:nil];
    
    SRColorBallTableViewCell *cell = views.firstObject;
    
    return cell;
}

- (void)setColors:(NSArray<UIColor *> *)colors {
    
    _colors = [NSArray arrayWithArray:colors];
    
    if (!colors || colors.count == 0) {
//        [self showMessageLabel:NO];
//        [self showMessageLabel:YES];
        
        _messageLabel.hidden = NO;
    } else {
//        [self showMessageLabel:NO];
        
        _messageLabel.hidden = YES;
    }
    
    if (!colors) {
        for (SRColorBall *ball in _colorBalls) {
            if (ball) {
                ball.ballColor = [UIColor clearColor];
            }
        }
    } else {
        int max = (int)_colors.count;
        if (max > 5) {
            max = 5;
        }
        
        for (int i = 0; i < max; i++) {
            SRColorBall *ball = _colorBalls[i];
            
            if (ball) {
                ball.ballColor = _colors[i];
            }
        }
        
        int diff = 5 - max;
        
        if (diff > 0) {
            for (int j = 0; j < diff; j++) {
                int k = j + (int)_colors.count;
                
                SRColorBall *ball = _colorBalls[k];
                
                if (ball) {
                    ball.ballColor = [UIColor clearColor];
                }
            }
        }
    }
}

- (IBAction)customButtonClicked:(id)sender {
    if ([_delegate respondsToSelector:@selector(colorBallTableViewCellDidClicked:)]) {
        [_delegate colorBallTableViewCellDidClicked:self];
    }
}

- (void)showMessageLabel:(BOOL)isShow {
    if (isShow) {
        _messageLabel.hidden = NO;
        [self handleMessageLabelShow];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(handleMessageLabelShow) userInfo:nil repeats:YES];
    } else {
        _messageLabel.hidden = YES;
        if (_timer) {
            [_timer invalidate];
        }
        _timer = nil;
        _multiply = 1;
        _messageLabel.alpha = 0;
    }
}
                  
- (void)handleMessageLabelShow {
    CGFloat alpha = ((int)(round(_messageLabel.alpha * 100) + _multiply) % 100) / 100.f;
//    NSLog(@"alpha %.2f, %d", alpha, _multiply);
    
    if (alpha >= 0.89f ) {
        _multiply = -1;
    } else if (alpha <= 0.2) {
        _multiply = 1;
    }
    
    
//    [UIView animateWithDuration:0.1f animations:^ {
        _messageLabel.alpha = alpha;
//    }];
}

#pragma mark - ------- Private -------

- (void)setupDidInit {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cellLabel.text = NSLocalizedString(@"color", nil);
    self.messageLabel.text = NSLocalizedString(@"selectColor", nil);
    self.messageLabel.alpha = 1;
    self.messageLabel.hidden = YES;
    _multiply = 1;
    
    _colors = [NSArray array];
}

@end
