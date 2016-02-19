//
//  SRLampTypeContorlView.h
//  SRLampTypeController
//
//  Created by wangwendong on 16/1/31.
//  Copyright © 2016年 sunricher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRLampTypeControlColorCell.h"
#import "SRLampTypeControlWBCell.h"
#import "SRLampTypeControlWarmColdcell.h"
#import "SRLampTypeControlMulticolourCell.h"
#import "SRLampColor.h"

@class SRLampTypeControlView;

/**
 * @brief 灯控制的类型
 * @param SRLampTypeControlViewTypeNONE 0
 * @param SRLampTypeControlViewTypeRGBW 1
 * @param SRLampTypeControlViewTypeRGB 2
 * @param SRLampTypeControlViewTypeCCT 3
 * @param SRLampTypeControlViewTypeDIM 4
 */
typedef NS_ENUM(NSInteger, SRLampTypeControlViewType) {
    SRLampTypeControlViewTypeNONE = 0, //!< No type selected
    SRLampTypeControlViewTypeRGBW = 1, //!< RGB and White、Brightness
    SRLampTypeControlViewTypeRGB = 2, //!< RGB and Brightness
    SRLampTypeControlViewTypeCCT = 3, //!< Warm and Cold、Brightness
    SRLampTypeControlViewTypeDIM = 4 //!< Brightness
};

@protocol SRLampTypeControlViewDelegate <NSObject>

@optional

- (void)lampTypeControlView:(SRLampTypeControlView *)view didLampColorChanged:(SRLampColor *)lampColor;

///// Section0 区域改变 lampColor
//- (void)lampTypeControlView:(SRLampTypeControlView *)view didSliderChanged:(SRLampColor *)lampColor;
//
///// Section1(RGB) 区域改变 lampColor
//- (void)lampTypeControlView:(SRLampTypeControlView *)view didRGBChanged:(SRLampColor *)lampColor;

@end

@interface SRLampTypeControlView : UIView

@property (weak, nonatomic) id<SRLampTypeControlViewDelegate> delegate;

/**
 * @brief 控制视图的类型（NONE, RGBW, RGB, CCT, DIM）
 */
@property (nonatomic) SRLampTypeControlViewType controlViewType;

/**
 * @param color(SRColor) HSV and RGB
 * @param white(NSNumber->CGFloat) [0, 100] 单独用来控制白灯
 * @param jumpState(NSNumber->BOOL) [NO, YES] 跳动模式开关
 */
@property (strong, nonatomic) SRLampColor *lampColor;

/// 主滚动视图
@property (strong, nonatomic) UITableView *controlTableView;

@end
