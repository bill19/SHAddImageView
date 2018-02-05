//
//  SHAddImgView.h
//  SHAddImageView
//
//  Created by HaoSun on 2018/2/3.
//  Copyright © 2018年 YHKIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHConfigModel.h"
#import "SHAddImgModel.h"

@protocol SHAddImgViewDelegate <NSObject>
@optional

/**
 更新高度

 @param updateHeight 更新的高度数值
 */
- (void)addimageViewUpdateHeight:(CGFloat)updateHeight ;

/**
  在外部点击某个图片进入浏览模式

 @param itemSource  图片数组
 @param index 点击图片的下标
 */
- (void)didSelectItemSource:(NSArray <UIImage *>*)itemSource index:(NSInteger)index ;


@end

@interface SHAddImgView : UIView

- (instancetype)initWithMaxColumn:(NSInteger)maxColumn;

@property (nonatomic, strong) SHConfigModel *configModel;

@property (nonatomic, weak) id <SHAddImgViewDelegate> delegate;

/**
 当iSDefualti为YES的时候，给予草稿的图片数组
 */
@property (nonatomic, strong) NSArray <UIImage *> *defualtImages;

@end
