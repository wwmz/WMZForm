//
//  WMZFormImageCell.m
//  WMZForm
//
//  Created by wmz on 2020/5/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormImageCell.h"
#import "PhotoBrowser.h"
#import "WMZFormPhotoFunction.h"
@interface WMZFormImageCell()<PhotoBrowserDelegate>
@end
@implementation WMZFormImageCell

- (void)UI{
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];
    
    [self.imageContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:self.imageContainerView];
    [self.imageArr removeAllObjects];
    for (int i = 0; i<FormMaxCount; i++) {
        UIImageView *tempImageView = [UIImageView new];
        tempImageView.contentMode = UIViewContentModeScaleAspectFill;
        tempImageView.clipsToBounds = YES;
        tempImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheImageView:)];
        [tempImageView addGestureRecognizer:tap];
        [self.imageContainerView addSubview:tempImageView];
        
        WMZFormBtn *deleIamge = [WMZFormBtn buttonWithType:UIButtonTypeCustom];
        [deleIamge setTag:100];
        deleIamge.hidden = YES;
        [deleIamge addTarget:self action:@selector(deleteImageBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [tempImageView addSubview:deleIamge];
        [deleIamge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(tempImageView);
            make.width.height.mas_equalTo(16);
        }];
        [self.imageArr addObject:tempImageView];
    }
}

- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
    self.photoArr = [NSMutableArray arrayWithArray:model.formValue?:@[]];
    [self updateImageWithModel:model];
}
- (void)updateImageWithModel:(WMZFormRowModel *)model{
    BOOL canInsert = NO;
    BOOL canDelete = NO;
    NSInteger count = self.photoArr.count;
    CGFloat top = model.formRowData[@"top"]?[model.formRowData[@"top"] floatValue]:(FormYOffset);
    CGFloat left = model.formRowData[@"left"]?[model.formRowData[@"left"] floatValue]:(FormXOffset);
    CGFloat width = model.formRowData[@"width"]?[model.formRowData[@"width"] floatValue]:(model.formWidth - FormXOffset - left);
    CGFloat imageWidth = model.formRowData[@"imageWidth"]?[model.formRowData[@"imageWidth"] floatValue]:((width- 2*FormImageOffset)/3);
    self.nameLa.frame = CGRectMake(left,model.formName&&model.formName.length?top:0, model.formRowData[@"textAlign"]?80:width, model.formName&&model.formName.length?30:0);
    
//    self.imageContainerView.frame = CGRectMake(left, CGRectGetMaxY(self.nameLa.frame)+FormYOffset, width, 0);
    NSInteger max = model.formRowData[@"maxCount"]?[model.formRowData[@"maxCount"] intValue]:FormMaxCount;
    if (count>max) {
        count = max;
    }
    if (model.formRowData[@"insert"]&&self.photoArr.count<max) {
        count += 1;
        canInsert = YES;
    }
    if (model.formRowData[@"delete"]) {
        canDelete = YES;
    }
    for (long i =  count; i <self.imageArr.count; i++) {
        UIImageView *imageView = [self.imageArr objectAtIndex:i];
        imageView.hidden = YES;
    }
    CGFloat itemW = [self itemWidthForPicPathArray: count normalWidth:imageWidth];
    CGFloat itemH = itemW;
    NSInteger perRowItemCount = [self perRowItemCountForPicPathArray: count];
    UIImageView *lastImageView = nil;
    for (int i = 0; i<count; i++) {
        UIImageView *imageView = self.imageArr[i];
        imageView.hidden = NO;
        [imageView setTag:10000+i];
        WMZFormBtn *deleIamge = [imageView viewWithTag: 100];
        deleIamge.hidden = !canDelete;
        [deleIamge setImage:[UIImage formBundleImage:model.formRowData[@"deleteIcon"]?:@"delPic"] forState:UIControlStateNormal];
        id obj = nil;
        if (canInsert) {
            if (i == 0) {
                deleIamge.hidden = YES;
                obj =  model.formRowData[@"insertIcon"]?:@"addPic";
                imageView.tag = 11111;
            }else{
                obj = self.photoArr[i-1];
                [imageView setTag:9999+i];
            }
        }else{
            obj = self.photoArr[i];
            [imageView setTag:10000+i];
        }
        [self setShowImage:imageView withData:obj key:@"image"];
        NSInteger section = (i+1)%perRowItemCount;
        CGRect rect = CGRectZero;
        if (!lastImageView) {
            rect = CGRectMake(0, 0, itemW, itemH);
        }else{
            if (section == 1) {
                rect = CGRectMake(0, CGRectGetMaxY(lastImageView.frame)+FormImageOffset, itemW, itemH);
            }else{
                rect = CGRectMake(CGRectGetMaxX(lastImageView.frame)+FormImageOffset, CGRectGetMinY(lastImageView.frame), itemW, itemH);
            }
        }
        imageView.frame = rect;
        lastImageView = imageView;
    }
    if (model.formRowData[@"textAlign"]) {
        self.imageContainerView.frame = CGRectMake(CGRectGetMaxX(self.nameLa.frame)+ FormXOffset,model.formName&&model.formName.length? (CGRectGetMinY(self.nameLa.frame)):top, width, CGRectGetMaxY(lastImageView.frame)+FormYOffset);
        
    }else{
        self.imageContainerView.frame = CGRectMake(left,model.formName&&model.formName.length? (CGRectGetMaxY(self.nameLa.frame)+FormYOffset):top, width, CGRectGetMaxY(lastImageView.frame)+FormYOffset);
        
    }

    model.formCellHeight = CGRectGetMaxY(self.imageContainerView.frame);
}
//图片点击
- (void)tapTheImageView:(UITapGestureRecognizer*)ta{
    UIView *tagView = [ta view];
    if (tagView.tag==11111) {
        UITableView *tableView = [self getMytableView];
        [tableView endEditing:YES];
        FormWeakSelf(self)
        [self.tool getLocationImageWithSize:smallSize WithBlock:^(NSDictionary * _Nonnull info) {
            FormStrongSelf(weakObject)
            if (info[@"miniImage"]) {
                UIImage *image = info[@"miniImage"];
                if ([strongObject.photoArr indexOfObject:image]==NSNotFound) {
                    [strongObject.photoArr addObject:image];
                    strongObject.model.deleteImage = nil;
                    strongObject.model.addImage = image;
                    strongObject.model.addIndex = strongObject.photoArr.count-1;
                    strongObject.model.formValue = [NSArray arrayWithArray:strongObject.photoArr];
                    [strongObject updateImageWithModel:strongObject.model];
                    [strongObject tableViewUpdate];
                    if (strongObject.formDelagate&&[strongObject.formDelagate respondsToSelector:@selector(didSelectCell:target:action:)]) {
                        [strongObject.formDelagate didSelectCell:self target:ta.view action:@"editImageAction"];
                    }
                    
                }
            }
        }];
    }else{
        [self layoutIfNeeded];
        PhotoBrowser *photoBrowser = [PhotoBrowser new];
        photoBrowser.delegate = self;
        photoBrowser.insert = self.model.formRowData[@"insert"]?YES:NO;
        photoBrowser.currentImageIndex = tagView.tag-10000;
        photoBrowser.imageCount =  self.photoArr.count;
        photoBrowser.sourceImagesContainerView = self.imageContainerView;
        [photoBrowser show];
    }
}
//图片删除
- (void)deleteImageBtnPressed:(UIButton*)sender{
    NSInteger tag = sender.superview.tag-10000;
    self.model.deleteImage = self.photoArr[tag];
    self.model.deleteIndex = tag;
    self.model.addImage = nil;
    [self.photoArr removeObjectAtIndex:tag];
    self.model.formValue = [NSArray arrayWithArray:self.photoArr];
    [self updateImageWithModel:self.model];
    [self tableViewUpdate];
    
    if (self.formDelagate&&[self.formDelagate respondsToSelector:@selector(didSelectCell:target:action:)]) {
        [self.formDelagate didSelectCell:self target:sender action:@"editImageAction"];
    }
}
- (UIImage *)photoBrowser:(PhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *image = [self.imageContainerView viewWithTag:10000+index];
    return image.image;
    
}
- (CGFloat)itemWidthForPicPathArray:(NSInteger )count normalWidth:(CGFloat)width
{
    if (count == 1) {
        return width;
    } else {
        return width;
    }
}
- (NSInteger)perRowItemCountForPicPathArray:(NSInteger )count
{
    if (count == 4 ) {
        return 2;
    } else if(count==1){
        return 1;
    }else {
        return 3;
    }
}
- (UIView *)imageContainerView{
    if (!_imageContainerView) {
        _imageContainerView = [UIView new];
    }
    return _imageContainerView;
}
- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray new];
    }
    return _imageArr;
}
- (NSMutableArray *)photoArr{
    if (!_photoArr) {
        _photoArr = [NSMutableArray new];
    }
    return _photoArr;
}
@end
