//
//  SHConfigModel.m
//  SHAddImageView
//
//  Created by HaoSun on 2018/2/3.
//  Copyright © 2018年 YHKIT. All rights reserved.
//

#import "SHConfigModel.h"

@implementation SHConfigModel


/**
 创建一个默认的样式

 @return 返回一个默认的样式
 */
+ (SHConfigModel *)creatNormalConfig  {
    SHConfigModel *config = [[SHConfigModel alloc] init];
    config.maxPhoto = 9;
    config.addBtnHidden = NO;
    config.placeholderName = @"circle_send_addImage";
    config.imageColumn = 4;
    config.padding = 10.0f;
    return config;
}

@end
