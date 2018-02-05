//
//  SHAddImgView.m
//  SHAddImageView
//
//  Created by HaoSun on 2018/2/3.
//  Copyright © 2018年 YHKIT. All rights reserved.
//

#import "SHAddImgView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "TZImagePickerController.h"
#import "SHAddCollectionCell.h"

@interface SHAddImgView()<UICollectionViewDelegate,UICollectionViewDataSource,SHAddCollectionCellDelegate,UIImagePickerControllerDelegate>
/**
 承载图片的CollectionView
 */
@property (nonatomic, strong) UICollectionView *collectionView;
/**
 增加图片的按钮
 */
@property (nonatomic, weak)  UIImageView *addImgView;//加号图片
/**
 图片数据源
 */
@property (nonatomic, strong) NSMutableArray <SHAddImgModel *>*imageModels;

/**
 通过configmodel 获取 每个ITEM的高度 （高度 = 宽度）
 */
@property (nonatomic, assign ,readonly) CGFloat itemHeight;

/**
 通过itemHeight 获取 每个ImageView的高度 （高度 = itemHeight - padding ）
 */
@property (nonatomic, assign ,readonly) CGFloat imageHeight;

/**
 一行展示数量
 */
@property (nonatomic, assign) NSInteger maximageColumn;
@end

@implementation SHAddImgView

- (instancetype)initWithMaxColumn:(NSInteger)maxColumn {
    self = [super init];
    if (self) {
        _maximageColumn = maxColumn;
        [self setupPhotoView];
    }
    return self;
}


#pragma mark - 图片的view
- (void)setupPhotoView {
    [self addSubview:self.collectionView];
    UIImageView *addImgView = [[UIImageView alloc] init];
    addImgView.userInteractionEnabled = YES;
    [addImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImgIBAction)]];
    _addImgView = addImgView;
    [self addSubview:_addImgView];
}

- (void)addImgIBAction{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    __weak typeof(self) weakSelf = self;
    if (self.imageModels.count >= _configModel.maxPhoto) {
        NSLog(@"=已经达到最大值==");
        return ;
    }
    UIAlertController *alertConVc = [UIAlertController alertControllerWithTitle:@"请选择获取图片的方式" message:@"选择方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *fromcPhotograph = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //拍照按钮
#if !TARGET_IPHONE_SIMULATOR
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.view.backgroundColor = [UIColor whiteColor];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        [[self viewController] presentViewController:ipc animated:YES completion:nil];
#endif
    }];
    UIAlertAction *fromcAlbum = [UIAlertAction actionWithTitle:@"从手机相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined) {
            ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                if (stop) {
                    [weakSelf setupTZImageVCNumber:_configModel.maxPhoto - self.imageModels.count];
                }
                *stop = TRUE;
            } failureBlock:^(NSError *error) {
                [weakSelf setupTZImageVCNumber:_configModel.maxPhoto - self.imageModels.count];

            }];
        }else{
            [weakSelf setupTZImageVCNumber:_configModel.maxPhoto - self.imageModels.count];
        }
    }];

    [alertConVc addAction:fromcPhotograph];
    [alertConVc addAction:fromcAlbum];
    [[self viewController] presentViewController:alertConVc animated:YES completion:nil];
}

- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SHAddCollectionCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"SHAddCollectionCell" forIndexPath:indexPath];
    SHAddImgModel *model = self.imageModels[indexPath.item];
    cell.delegate = self;
    cell.imageModel = model;
    cell.imageHeight = _imageHeight;
    cell.configModel = _configModel;
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    //返回YES允许其item移动
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //取出源item数据
    id objc = [self.imageModels objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [self.imageModels removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [self.imageModels insertObject:objc atIndex:destinationIndexPath.item];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0.0;
        layout.minimumLineSpacing = 0.0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[SHAddCollectionCell class] forCellWithReuseIdentifier:@"SHAddCollectionCell"];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        //此处给其增加长按手势，用此手势触发cell移动效果
        [_collectionView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)]];
    }
    return _collectionView;
}

#pragma mark - 删除内容
- (void)delImageView:(SHAddImgModel *)model {
    [self.imageModels removeObject:model];
    [self.collectionView reloadData];
    [self resetAddImgFrame];
}

#pragma mark - 进入图片浏览器
- (void)imageViewTap:(SHAddImgModel *)imageModel {
    if (!_configModel.shouldPhotoBrowser) {
        return;
    }
    NSInteger itemIndex = 0;
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger index = 0; index < self.imageModels.count; index++) {
        SHAddImgModel *model = self.imageModels[index];
        if ([imageModel isEqual:model]) {
            itemIndex = index;
        }
        [images addObject:model.image];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemSource:index:)]) {
        [self.delegate didSelectItemSource:images index:itemIndex];
    }
}

//相册选择器
- (void)setupTZImageVCNumber:(NSInteger)photoNum{

    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:photoNum columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
    // 显不显示视频
    imagePickerVc.allowPickingVideo = NO;
    __weak typeof(self) weakSelf = self;
    // 图片选择完的回调
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        for (UIImage *image in photos) {
            SHAddImgModel *model = [[SHAddImgModel alloc] init];
            model.image = image;
            [weakSelf.imageModels addObject:model];
        }
        [self.collectionView reloadData];
        [self resetAddImgFrame];
    }];
    // 视频选择完的回调
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage,id asset) {

    }];
    [[self viewController] presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)resetAddImgFrame{
    NSInteger imgRow  = _imageModels.count % _maximageColumn;
    NSInteger imgLine = _imageModels.count / _maximageColumn;
    CGFloat starIndexX = (_itemHeight + kItemPadding) * imgRow  + kItemPadding * 0.5;
    CGFloat starIndexY = (_itemHeight + kItemPadding) * imgLine + kItemPadding * 0.5;
    if(_imageModels.count < _configModel.maxPhoto && _configModel.addBtnHidden == NO){
        _addImgView.frame = CGRectMake(starIndexX, starIndexY, _imageHeight, _imageHeight);
        _addImgView.hidden = NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(addimageViewUpdateHeight:)]) {
            [self.delegate addimageViewUpdateHeight:((imgLine + 1) * (_itemHeight + kItemPadding))];
        }
    }else{
        _addImgView.hidden = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(addimageViewUpdateHeight:)]) {
            [self.delegate addimageViewUpdateHeight:((imgLine + 1) * (_itemHeight + kItemPadding))];
        }
    }
}

/**
 *  返回当前视图的控制器
 */
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/**
 存草稿进入展示图片

 @param defualtImages images
 */
- (void)setDefualtImages:(NSArray<UIImage *> *)defualtImages {
    if (_configModel.isDefualt) {
        _defualtImages = defualtImages;
        for (UIImage *image in defualtImages) {
            SHAddImgModel *model = [[SHAddImgModel alloc] init];
            model.image = image;
            [self.imageModels addObject:model];
        }
        [self resetAddImgFrame];
        [self.collectionView reloadData];
    }
}

- (NSMutableArray <SHAddImgModel *>*)imageModels {
    if (!_imageModels) {
        _imageModels = [NSMutableArray array];
    }
    return _imageModels;
}

- (void)setConfigModel:(SHConfigModel *)configModel {
    _configModel = configModel;
    _addImgView.hidden = _configModel.addBtnHidden;
    _addImgView.image = [UIImage imageNamed:_configModel.placeholderName];
    _itemHeight = self.bounds.size.width / _maximageColumn - kItemPadding;
    _imageHeight = _itemHeight - kItemPadding;
    _addImgView.frame = CGRectMake(kItemPadding * .5, kItemPadding * .5, _imageHeight, _imageHeight);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(_itemHeight,_itemHeight);
    _collectionView.collectionViewLayout = layout;
    _collectionView.frame = self.bounds;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    __weak typeof(self) weakSelf = self;
    NSString *mediaType = info[UIImagePickerControllerMediaType];

    if([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *resultImage = nil;
        if(picker.allowsEditing){
            resultImage = info[UIImagePickerControllerEditedImage];
        } else {
            resultImage = info[UIImagePickerControllerOriginalImage];
        }
        SHAddImgModel *model = [[SHAddImgModel alloc] init];
        model.image = resultImage;
        [weakSelf.imageModels addObject:model];
        [self.collectionView reloadData];
        [self resetAddImgFrame];

    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -   拍照回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end

