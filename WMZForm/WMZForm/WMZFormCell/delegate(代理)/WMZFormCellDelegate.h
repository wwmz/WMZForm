



//
//  WMZFormCellDelegate.h
//  WMZForm
//
//  Created by wmz on 2020/5/11.
//  Copyright © 2020 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMZFormBaseCell;
NS_ASSUME_NONNULL_BEGIN
@protocol WMZFormCellDelegate <NSObject>
@optional
//点击cell上的控件触发操作
- (void)didSelectCell:(WMZFormBaseCell*)cell target:(id)view action:(id)action;
@end

NS_ASSUME_NONNULL_END
