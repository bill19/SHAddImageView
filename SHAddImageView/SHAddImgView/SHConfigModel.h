//
//  SHConfigModel.h
//  SHAddImageView
//
//  Created by HaoSun on 2018/2/3.
//  Copyright © 2018年 YHKIT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@interface SHConfigModel : NSObject

/**
 默认图片名称
 */
@property (nonatomic, copy) NSString *placeholderName;

/**
 最大图片数目
 */
@property (nonatomic, assign) NSInteger maxPhoto;

/**
 新增图片按钮是否显示
 */
@property (nonatomic, assign) BOOL addBtnHidden;

/**
 一行展示数量
 */
@property (nonatomic, assign) NSInteger imageColumn;

/**
 每个item间距
 */
@property (nonatomic, assign) CGFloat padding;

/**
 创建一个默认的样式

 @return 返回一个默认的样式
 */
+ (SHConfigModel *)creatNormalConfig ;

@end
