//
//  SHAddCollectionCell.m
//  SHAddImageView
//
//  Created by HaoSun on 2018/2/3.
//  Copyright © 2018年 YHKIT. All rights reserved.
//

#import "SHAddCollectionCell.h"
#import "SHAddImgModel.h"
#import "SHAddHeader.h"
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
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setupSubViews {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor redColor];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)]];
    _imageView = imageView;
    [self.contentView addSubview:imageView];

    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [delBtn setImage:[UIImage imageNamed:@"circle_send_close2"] forState:UIControlStateNormal];
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
    _imageView.backgroundColor = [UIColor purpleColor];
    _imageView.image = _imageModel.image;
}

- (void)setConfigModel:(SHConfigModel *)configModel {
    _configModel = configModel;

    CGFloat padding = _configModel.padding * 0.5;
    CGFloat imageItemHeight = (kSHScreenWidth - _configModel.padding) / _configModel.imageColumn;
    _imageView.frame = CGRectMake(padding, padding, imageItemHeight - _configModel.padding, imageItemHeight - _configModel.padding);
    _deleteButton.frame = CGRectMake(imageItemHeight - 20.f, padding, 20.f, 20.f);
}

@end
