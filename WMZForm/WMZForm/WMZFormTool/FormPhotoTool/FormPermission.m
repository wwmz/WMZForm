





//
//  FormPermission.m
//  WMZForm
//
//  Created by wmz on 2019/7/16.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "FormPermission.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
@interface FormPermission()

@property(nonatomic,copy)FormPermissionCallBack block;

@end
@implementation FormPermission
static FormPermission *_instance;

/*
 * 初始化
 */
+(instancetype)shareInstance{
    return [[self alloc]init];
}



/*
 * 获取权限
 * @param  type       类型
 * @param  block      回调
 */
- (void)permissonType:(FormPermissionType)type withHandle:(FormPermissionCallBack)block{
    self.block = block;
    
    switch (type) {
        case PermissionTypePhoto:
        {
            [self permissionTypePhotoAction];
        }
            break;
        case PermissionTypeCamera:
        {
            [self permissionTypeCameraAction];
        }
            break;
        default:
            break;
    }
}

/*
 *相册权限
 */
- (void)permissionTypePhotoAction{
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    FormWeakSelf(self)
    if (photoStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            FormStrongSelf(self)
            if (status == PHAuthorizationStatusAuthorized) {
                if (strongObject.block) {
                    strongObject.block(YES, @(photoStatus));
                }
            } else {
                if (strongObject.block) {
                    strongObject.block(NO, @(photoStatus));
                }
            }
        }];
    } else if (photoStatus == PHAuthorizationStatusAuthorized) {
        if ( self.block) {
            self.block(YES, @(photoStatus));
        }
    } else if(photoStatus == PHAuthorizationStatusRestricted||photoStatus == PHAuthorizationStatusDenied){
        [self pushSetting:@"相册权限"];
        
    }else{
        if ( self.block) {
            self.block(NO, @(photoStatus));
        }
    }
}

/*
 *相机权限
 */
- (void)permissionTypeCameraAction{
    FormWeakSelf(self)
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            FormStrongSelf(self)
            if (strongObject.block) {
                strongObject.block(granted, @(authStatus));
            }
        }];
    }  else if (authStatus == AVAuthorizationStatusAuthorized) {
        if (self.block) {
            self.block(YES, @(authStatus));
        }
    } else if(authStatus == AVAuthorizationStatusRestricted||authStatus == AVAuthorizationStatusDenied){
        [self pushSetting:@"相机权限"];
        
    }else{
        if ( self.block) {
            self.block(NO, @(authStatus));
        }
    }
}


/*
 *跳转设置
 */
- (void)pushSetting:(NSString*)urlStr{
    FormWeakSelf(self)
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@%@",urlStr,self.tip] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        FormStrongSelf(self)
        if (strongObject.block) {
            strongObject.block(NO, @"");
        }
    }];
    [alert addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FormStrongSelf(self)
        if (strongObject.block) {
            strongObject.block(NO, @"");
        }
        NSURL *url= [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                        
                }];
            } else {
                [[UIApplication sharedApplication]openURL:url];
            }
        }
    }];
    [alert addAction:okAction];
    [[FormPermission getCurrentVC] presentViewController:alert animated:YES completion:nil];
}

//获取当前VC
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}

- (NSString *)tip{
    if (!_tip) {
        _tip = @"尚未开启,请在系统设置中开启服务";
    }
    return _tip;
}
@end
