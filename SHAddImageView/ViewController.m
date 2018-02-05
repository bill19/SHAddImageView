//
//  ViewController.m
//  SHAddImageView
//
//  Created by HaoSun on 2018/2/3.
//  Copyright © 2018年 YHKIT. All rights reserved.
//

#import "ViewController.h"
#import "SHAddHeader.h"
#define kSHScreenWidth [UIScreen mainScreen].bounds.size.width
@interface ViewController () <SHAddImgViewDelegate>
@property (nonatomic, strong) SHAddImgView *addImgView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SHAddImgView *addImgView = [[SHAddImgView alloc] initWithMaxColumn:4];
    addImgView.frame = CGRectMake(0, 100, kSHScreenWidth, 200);
    addImgView.configModel = [SHConfigModel creatNormalConfig];
    addImgView.backgroundColor = [UIColor grayColor];
    addImgView.delegate = self;
    _addImgView = addImgView;
    [self.view addSubview:_addImgView];
}


/**
 更新高度

 @param updateHeight 更新的高度数值
 */
- (void)addimageViewUpdateHeight:(CGFloat)updateHeight  {
    _addImgView.frame = CGRectMake(0, 100, kSHScreenWidth, updateHeight);
}

/**
 在外部点击某个图片进入浏览模式

 @param itemSource  图片数组
 @param index 点击图片的下标
 */
- (void)didSelectItemSource:(NSArray <UIImage *>*)itemSource index:(NSInteger)index  {
    NSLog(@"---点击了某个item 第%ld个item  图片数组 - %@ - 进入图片浏览模式自己去实现就好了",index,itemSource);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
