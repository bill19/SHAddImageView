//
//  SHAddCollectionCell.h
//  SHAddImageView
//
//  Created by HaoSun on 2018/2/3.
//  Copyright © 2018年 YHKIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHConfigModel.h"
@class SHAddImgModel;

@protocol SHAddCollectionCellDelegate <NSObject>
/**
 删除存在的图片

 @param model 删除某个图片的模型
 */
- (void)delImageView:(SHAddImgModel *)model;

/**
 图片点击进入浏览器

 @param imageModel 点击的某个图片的模型
 */
- (void)imageViewTap:(SHAddImgModel *)imageModel;

@end

@interface SHAddCollectionCell : UICollectionViewCell

/**
 图片数据信息
 */
@property (nonatomic, strong) SHAddImgModel *imageModel;

@property (nonatomic, weak) id <SHAddCollectionCellDelegate> delegate;

@property (nonatomic, strong) SHConfigModel *configModel;
@end
