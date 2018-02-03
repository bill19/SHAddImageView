//
//  SHAddImgModel.h
//  SHAddImageView
//
//  Created by HaoSun on 2018/2/3.
//  Copyright © 2018年 YHKIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SHAddImgModel : NSObject

/**
 图片下标
 */
@property (nonatomic, assign) NSInteger item;

/**
 图片源数据
 */
@property (nonatomic, copy) UIImage *image;

/**
 图片标题
 */
@property (nonatomic, copy) NSString *title;
@end
