//
//  ViewController.m
//  SRLampTypeController
//
//  Created by wangwendong on 16/1/31.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import "ViewController.h"
#import "SRLampTypeControlView.h"
#import "SRColorSlider.h"

@interface ViewController () <SRColorSliderDelegate, SRLampTypeControlViewDelegate>
@property (weak, nonatomic) IBOutlet SRLampTypeControlView *controlView;
@property (weak, nonatomic) IBOutlet SRColorSlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _slider.delegate = self;
    _controlView.delegate = self;
    
    self.view.backgroundColor = _controlView.lampColor.color.color;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 切换前随机变个色儿
    SRLampColor *lampColor = [[SRLampColor alloc] init];
    CGFloat hue = arc4random_uniform(360);
    SRColorHSV hsv = lampColor.color.HSV;
    hsv.hue = hue;
    lampColor.color.HSV = hsv;
    
    _controlView.lampColor = lampColor;
    
    _controlView.controlViewType = SRLampTypeControlViewTypeRGBW;
}

- (IBAction)typeChangedClicked:(id)sender {
    int tag = (int)[sender tag];
    
    // 切换前随机变个色儿
    SRLampColor *lampColor = [[SRLampColor alloc] init];
    CGFloat hue = arc4random_uniform(360);
    SRColorHSV hsv = lampColor.color.HSV;
    hsv.hue = hue;
    lampColor.color.HSV = hsv;
    
    _controlView.lampColor = lampColor;
    
    _controlView.controlViewType = tag + 1;
}

- (void)lampTypeControlView:(SRLampTypeControlView *)view didLampColorChanged:(SRLampColor *)lampColor {
    self.view.backgroundColor = lampColor.color.color;
}

@end
