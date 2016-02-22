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

@property (strong, nonatomic) SRLampColor *lampColorRGB;
@property (strong, nonatomic) SRLampColor *lampColorWC;

@property (weak, nonatomic) IBOutlet SRWarmColdSlider *warmColdSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _slider.delegate = self;
    _controlView.delegate = self;
    
    self.view.backgroundColor = _controlView.lampColor.color.color;
    
    _lampColorRGB = [[SRLampColor alloc] init];
    _lampColorWC = [[SRLampColor alloc] init];
    SRColorHSV hsv = _lampColorWC.color.HSV;
    hsv.value = 0.5;
    hsv.hue = 80;
    _lampColorWC.color.HSV = hsv;
    
    _warmColdSlider.hueNumber = @(60);
    _warmColdSlider.valueNumber = @(0.5);
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
    
    if ((tag + 1) == SRLampTypeControlViewTypeCCT) {
        _controlView.lampColor = _lampColorWC;
    } else {
        _controlView.lampColor = _lampColorRGB;
    }
    
    _controlView.controlViewType = tag + 1;
}

- (void)lampTypeControlView:(SRLampTypeControlView *)view didLampColorChanged:(SRLampColor *)lampColor {
    if (view.controlViewType == SRLampTypeControlViewTypeRGBW || view.controlViewType == SRLampTypeControlViewTypeRGB) {
        _lampColorRGB = lampColor;
    } else if (view.controlViewType == SRLampTypeControlViewTypeCCT) {
        _lampColorWC = lampColor;
    }
    
    self.view.backgroundColor = lampColor.color.color;
}

@end
