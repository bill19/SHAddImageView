//
//  ViewController.m
//  SHAddImageView
//
//  Created by HaoSun on 2018/2/3.
//  Copyright © 2018年 YHKIT. All rights reserved.
//

#import "ViewController.h"
#import "SHAddHeader.h"

@interface ViewController ()
@property (nonatomic, strong) SHAddImgView *picview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SHAddImgView *picview = [[SHAddImgView alloc] initWithFrame:CGRectMake(0, 100, kSHScreenWidth, 500)];
    picview.configModel = [SHConfigModel creatNormalConfig];
    picview.backgroundColor = [UIColor greenColor];
    _picview = picview;
    [self.view addSubview:_picview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
