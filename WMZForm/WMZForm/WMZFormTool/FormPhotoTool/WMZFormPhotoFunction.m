




//
//  WMZFormPhotoFunction.m
//  WMZForm
//
//  Created by wmz on 2019/7/16.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZFormPhotoFunction.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "WMZDialog.h"
#import "FormImagePickController.h"
@interface WMZFormPhotoFunction()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic,copy)ImageBlock block;
@property (nonatomic,assign)formImageSize size;
@property (nonatomic,strong) FormPermission *permission;
@end
@implementation WMZFormPhotoFunction

//初始化
+ (instancetype)shareInstance{
    return [[self alloc]init];
}

/*
 *获取本地相册
 */
- (void)getLocationImageWithSize:(formImageSize)size WithBlock:(ImageBlock)block{
    self.size = size;
    self.block = block;
    FormWeakSelf(self)
    Dialog()
    .wTypeSet(DialogTypeSheet)
    .wTagSet(10086)
    .wShowAnimationSet(AninatonShowTop)
    .wHideAnimationSet(AninatonHideTop)
    .wAnimationDurtionSet(0.3)
    .wOKColorSet(DialogColor(0x024596))
    .wDataSet(@[@"拍照",@"我的相册"])
    .wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type) {
        FormStrongSelf(weakObject)
        if ([anyID isEqualToString:@"拍照"]) {
            [strongObject checkPermissionWithType:PermissionTypeCamera];
        }else if ([anyID isEqualToString:@"我的相册"]){
            [strongObject checkPermissionWithType:PermissionTypePhoto];
        }
    })
    .wStart();
}

- (void)checkPermissionWithType:(FormPermissionType)type{
     FormWeakSelf(self)
    self.permission = [FormPermission shareInstance];
    [self.permission permissonType:type withHandle:^(BOOL granted, id data) {
         FormStrongSelf(weakObject)
        if (granted) {
            [strongObject pushImagePickerController:type == PermissionTypePhoto? @"image": @""];
        }
    }];
}

- (void)pushImagePickerController:(NSString*)type{
    if (![type isEqualToString:@"image"]) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"摄像头不可用" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [[FormPermission getCurrentVC] presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType =[type isEqualToString:@"image"]? UIImagePickerControllerSourceTypePhotoLibrary:UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.editing = YES;
    [[FormPermission getCurrentVC] presentViewController:picker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage * image;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        UIImage *miniImage = [WMZFormPhotoFunction compressPictureWith:image withSize:self.size];
        NSData *data = UIImageJPEGRepresentation(miniImage, 0.7);
        UIImage *normalImage = [UIImage imageWithData:data];
        if (self.block) {
//            NSLog(@"%ldkb",[data length]/1000);
            NSDictionary *info = @{
                                   @"miniImage":normalImage,
                                   @"minaData":data,
                                   };
            self.block(info);
        }

    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


// 压缩图片
+ (UIImage *)compressPictureWith:(UIImage *)originnalImage withSize:(formImageSize)size{
    NSDictionary *dic = @{
                          @(miniSize):@(120.0),
                          @(smallSize):@(300.0),
                          @(normalSize):@(originnalImage.size.width)
                          };
    CGFloat ruleWidth = [dic[@(size)] floatValue];
    
    if (originnalImage.size.width < ruleWidth) {
        return originnalImage;
    }
    
    CGFloat hight = ruleWidth/originnalImage.size.width * originnalImage.size.height;
    CGRect rect = CGRectMake(0, 0, ruleWidth, hight);
    // 开启图片上下文
    UIGraphicsBeginImageContext(rect.size);
    // 将图片渲染到图片上下文
    [originnalImage drawInRect:rect];
    // 获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    return img;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
