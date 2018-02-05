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
  删除按钮默认图片 
 */
@property (nonatomic, copy) NSString *deletePlaceholdName;
/**
 最大图片数目
 */
@property (nonatomic, assign) NSInteger maxPhoto;

/**
 新增图片按钮是否显示
 */
@property (nonatomic, assign) BOOL addBtnHidden;

/**
 外部 是否可以进入图片浏览模式
 */
@property (nonatomic, assign) BOOL shouldPhotoBrowser;

/**
 是否存在默认图片 - 可以理解为保存草稿
 */
@property (nonatomic, assign) BOOL isDefualt;
/**
 创建一个默认的样式

 @return 返回一个默认的样式
 */
+ (SHConfigModel *)creatNormalConfig ;

@end
