//
//  WMZFormPhotoFunction.h
//  WMZForm
//
//  Created by wmz on 2019/7/16.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormPermission.h"
/*
 * image的size
 */
typedef enum : NSUInteger{
    miniSize = 0,
    smallSize,
    normalSize
}formImageSize;

NS_ASSUME_NONNULL_BEGIN

typedef void (^ImageBlock) (NSDictionary *info);

@interface WMZFormPhotoFunction : NSObject

/*
 * 初始化
 */
+ (instancetype)shareInstance;

/*
 *获取本地相册
 */
- (void)getLocationImageWithSize:(formImageSize)size WithBlock:(ImageBlock)block;

/*
*压缩图片
*/
+ (UIImage *)compressPictureWith:(UIImage *)originnalImage withSize:(formImageSize)size;
@end

NS_ASSUME_NONNULL_END
