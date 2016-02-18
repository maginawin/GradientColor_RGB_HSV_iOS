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
    
    _controlView.controlViewType = SRLampTypeControlViewTypeRGBW;
}

- (IBAction)typeChangedClicked:(id)sender {
    int tag = (int)[sender tag];
    
    _controlView.controlViewType = tag + 1;
}

- (void)colorSlider:(SRColorSlider *)slider didColorChanged:(SRColor *)color {
    
    dispatch_async(dispatch_get_main_queue(), ^ {
        self.view.backgroundColor = color.color;
        
        _controlView.lampColor.color = color.copy;
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
        [_controlView.controlTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    });
}

- (void)lampTypeControlView:(SRLampTypeControlView *)view didRGBChanged:(SRLampColor *)lampColor {
    
    [_slider setColor:lampColor.color];
    self.view.backgroundColor = lampColor.color.color;
}

@end
