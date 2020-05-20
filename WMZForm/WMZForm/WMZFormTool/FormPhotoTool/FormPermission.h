//
//  FormPermission.h
//  WMZForm
//
//  Created by wmz on 2019/7/16.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
#define FormWeakSelf(obj) __weak typeof(obj) weakObject = obj;
#define FormStrongSelf(obj) __strong typeof(obj) strongObject = weakObject;

//权限类型
typedef enum : NSUInteger{
    PermissionTypeCamera,           //相机权限
    PermissionTypePhoto,            //相册权限
}FormPermissionType;

typedef void (^FormPermissionCallBack) (BOOL granted, id  data);


@interface FormPermission : NSObject

/*
 * 提示
 */
@property(nonatomic,strong)NSString *tip;

/*
 * 初始化
 */
+ (instancetype)shareInstance;

/*
 * 获取权限
 * @param  type       类型
 * @param  block      回调
 */
- (void)permissonType:(FormPermissionType)type withHandle:(FormPermissionCallBack)block;

//获取当前VC
+(UIViewController *)getCurrentVC;
@end
NS_ASSUME_NONNULL_END
