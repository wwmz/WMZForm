


//
//  WMZFormDelegate.h
//  WMZForm
//
//  Created by wmz on 2020/5/11.
//  Copyright © 2020 wmz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WMZForm,WMZFormRowModel,WMZFormBaseCell;
NS_ASSUME_NONNULL_BEGIN

@protocol WMZFormDelegate <NSObject>
@optional
/*
 *formCell点击
 @param cell  所在的cell (cell.model为model cell.indexPath 为其所在的indexPath)
 */
- (void)form:(WMZForm*)form didSelectRowAtCell:(WMZFormBaseCell*)cell;

/*
 *formCell点击
 @param cell  所在的cell (cell.model为model cell.indexPath 为其所在的indexPath)
 @param didDeselect 取消点击
 */
- (void)form:(WMZForm*)form didSelectRowAtCell:(WMZFormBaseCell*)cell didDeselect:(BOOL)didDeselect;

/*
 *form提交
 @param commitInfo  提交的信息 为一个带value和key的字典
 @param success  是否通过检验规则可以提交
 */
- (void)form:(WMZForm*)form info:(NSDictionary*)commitInfo canCommit:(BOOL)success;

/*
 *formCell上的view点击 用于cell上的控件的交互事件
 @param clickView  点击的view
 @param cell  所在的cell
 @param action  根据action判断交互的事件
 */
- (void)form:(WMZForm*)form
        subViewDidSelectRowAtCell:(WMZFormBaseCell*)cell
        view:(id)clickView
        type:(id)action;

@end

NS_ASSUME_NONNULL_END
