//
//  FormPushListVC.h
//  WMZForm
//
//  Created by wmz on 2020/5/13.
//  Copyright © 2020 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZForm.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^FormPushBlock) (NSString *value,id data);
@interface FormPushListVC : UIViewController
@property(nonatomic,strong)NSDictionary *info;
@property(nonatomic,strong)id selectModel;
@property(nonatomic,copy) FormPushBlock block;
@end

NS_ASSUME_NONNULL_END
