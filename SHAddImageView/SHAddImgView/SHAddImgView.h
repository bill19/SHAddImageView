//
//  SHAddImgView.h
//  SHAddImageView
//
//  Created by HaoSun on 2018/2/3.
//  Copyright © 2018年 YHKIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHAddHeader.h"
@class SHAddImgModel;
@class SHConfigModel;
@interface SHAddImgView : UIView

@property (nonatomic, strong) SHConfigModel *configModel;

/**
 当有存草稿的情况时， 展示的图片
 */
- (void)showNumPics:(NSArray *)images;
@end
