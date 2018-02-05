//
//  SHAddCollectionCell.m
//  SHAddImageView
//
//  Created by HaoSun on 2018/2/3.
//  Copyright © 2018年 YHKIT. All rights reserved.
//

#import "SHAddCollectionCell.h"
#import "SHAddImgModel.h"
#import "SHConfigModel.h"
@interface SHAddCollectionCell()

/**
 存储图片的IMGVIEW
 */
@property (nonatomic, weak) UIImageView *imageView;

/**
 删除按钮
 */
@property (nonatomic, weak) UIButton *deleteButton;

@end

@implementation SHAddCollectionCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)]];
    _imageView = imageView;
    [self.contentView addSubview:imageView];

    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn addTarget:self action:@selector(delImage:) forControlEvents:UIControlEventTouchUpInside];
    _deleteButton = delBtn;
    [imageView addSubview:_deleteButton];

}

- (void)delImage:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(delImageView:)]) {
        [self.delegate delImageView:_imageModel];
    }
}


- (void)imageViewTap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewTap:)]) {
        [self.delegate imageViewTap:_imageModel];
    }
}

- (void)setImageModel:(SHAddImgModel *)imageModel {
    _imageModel = imageModel;
    _imageView.image = _imageModel.image;
}

- (void)setConfigModel:(SHConfigModel *)configModel {
    _configModel = configModel;
    [_deleteButton setImage:[UIImage imageNamed:_configModel.deletePlaceholdName] forState:UIControlStateNormal];
}

- (void)setImageHeight:(CGFloat)imageHeight {
    _imageHeight = imageHeight;
    CGFloat padding   = kItemPadding * 0.5;
    CGFloat delImageH = 15.f;
    _imageView.frame = CGRectMake(padding, padding, imageHeight, imageHeight);
    _deleteButton.frame = CGRectMake(imageHeight - delImageH, 0, delImageH, delImageH);
}
@end
