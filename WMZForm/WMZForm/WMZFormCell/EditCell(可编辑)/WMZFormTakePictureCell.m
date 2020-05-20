//
//  WMZFormTakePictureCell.m
//  WMZForm
//
//  Created by wmz on 2020/5/13.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormTakePictureCell.h"
#import "PhotoBrowser.h"
#import "WMZFormPhotoFunction.h"
@interface WMZFormTakePictureCell()<PhotoBrowserDelegate>
@end
@implementation WMZFormTakePictureCell
- (void)UI{
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    [self.nameLa mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(FormXOffset);
          make.right.mas_equalTo(-FormXOffset);
          make.top.mas_equalTo(FormYOffset);
    }];
    
    [self.imageContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:self.imageContainerView];
    [self.imageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FormXOffset*2);
        make.right.mas_equalTo(-FormXOffset*2);
        make.top.equalTo(self.nameLa.mas_bottom).offset(5);
        make.height.mas_equalTo(FormDefaulICCardHeight).priorityHigh();
        make.bottom.mas_equalTo(-FormYOffset);
    }];
    
    
    [self.imageContainerView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheImageView)];
    [self.iconImageView addGestureRecognizer:tap];
    
    WMZFormBtn *deleIamge = [WMZFormBtn buttonWithType:UIButtonTypeCustom];
    deleIamge.hidden = YES;
    [deleIamge setImage:[UIImage formBundleImage:@"delPic"] forState:UIControlStateNormal];
    [deleIamge addTarget:self action:@selector(deleteImageBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.iconImageView addSubview:deleIamge];
    deleIamge.tag = 100;
    [deleIamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.iconImageView);
        make.width.height.mas_equalTo(16);
    }];
}

- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
    if (model.formCustomImageView) {
        model.formCustomImageView(self.iconImageView);
    }else{
        self.iconImageView.contentMode = UIViewContentModeScaleToFill;
        self.iconImageView.layer.masksToBounds = NO;
        self.iconImageView.layer.cornerRadius = 0;
    }
    WMZFormBtn *deleIamge = [self.iconImageView viewWithTag: 100];
     deleIamge.hidden = NO;
    self.detailLa.textAlignment = NSTextAlignmentCenter;
    if (model.isSelected||(model.formValue&&
        [model.formValue isKindOfClass:[UIImage class]])||
        (model.formValue&&
        [model.formValue isKindOfClass:[NSDictionary class]])||(model.formValue&&
        [model.formValue isKindOfClass:[NSString class]]&&[model.formValue length])) {
        deleIamge.hidden = NO;
        if ([model.formValue isKindOfClass:[UIImage class]]) {
            self.iconImageView.image = model.formValue;
        }else if ([model.formValue isKindOfClass:[NSDictionary class]]) {
            self.iconImageView.image = [UIImage imageWithData:model.formValue[@"minaData"]];
        }else if ([model.formValue isKindOfClass:[NSString class]]) {
            self.iconImageView.image = [UIImage formBundleImage:model.formValue];
        }
    }else{
        deleIamge.hidden = YES;
        self.iconImageView.image = [UIImage formBundleImage:model.formIcon?:@" "];
    }
}

//图片点击
- (void)tapTheImageView{
    if (!self.model.isSelected) {
        FormWeakSelf(self)
        [self.tool getLocationImageWithSize:smallSize WithBlock:^(NSDictionary * _Nonnull info) {
            FormStrongSelf(weakObject)
            if (info[@"miniImage"]) {
                WMZFormBtn *deleIamge = [self.iconImageView viewWithTag: 100];
                deleIamge.hidden = NO;
                strongObject.iconImageView.image = info[@"miniImage"];
                strongObject.model.formValue = info[@"minaData"];
                strongObject.model.isSelected = YES;
            }
        }];
    }else{
        PhotoBrowser *photoBrowser = [PhotoBrowser new];
        photoBrowser.delegate = self;
        photoBrowser.currentImageIndex = 0;
        photoBrowser.imageCount =  1;
        photoBrowser.sourceImagesContainerView = self.imageContainerView;
        [photoBrowser show];
    }
}
- (UIImage *)photoBrowser:(PhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return self.iconImageView.image;
}
//图片删除
- (void)deleteImageBtnPressed{
    WMZFormBtn *deleIamge = [self.iconImageView viewWithTag: 100];
    deleIamge.hidden = YES;
    self.model.isSelected = NO;
    self.model.formValue = @"";
    self.iconImageView.image = [UIImage formBundleImage:self.model.formIcon?:@" "];
}
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}
- (UIView *)imageContainerView{
    if (!_imageContainerView) {
        _imageContainerView = [UIView new];
    }
    return _imageContainerView;
}
@end
