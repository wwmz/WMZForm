//
//  WMZForm.h
//  WMZForm
//
//  Created by wmz on 2020/2/20.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormBase.h"
NS_ASSUME_NONNULL_BEGIN
@interface WMZForm : WMZFormBase
//initWithFrame
WMZForm * Form(CGRect rect);
//addSection 初始化调用
@property(nonatomic,copy,readonly) WMZForm *(^wAddFormSection)(FormSectionBlock addFormSection);
//addRow 初始化调用
@property(nonatomic,copy,readonly) WMZForm *(^wAddFormRow)(FormRowBlock addFormRow);
//addDelegate
@property(nonatomic,weak,readonly) WMZForm *(^wAddFormDelegate)(id <WMZFormDelegate> addFormDelegate);
//emptyView
@property(nonatomic,copy,readonly) WMZForm *(^wAddFormEmptyInfo)(NSDictionary* formEmptyInfo);
//addRow 非初始化增加row调用 默认插入最后
- (BOOL)wAddFormRow:(WMZFormRowModel*)rowModel;
//addRow 非初始化增加row调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormRow:(WMZFormRowModel*)rowModel atIndex:(NSInteger)index;
//addRow 非初始化增加row调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormRowBlock:(FormRowBlock)addFormRow atIndex:(NSInteger)index;
//addSection 非初始化增加section调用 默认插入最后
- (BOOL)wAddFormSection:(WMZFormSectionModel*)sectionModel;
//addSection 非初始化增加section调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormSection:(WMZFormSectionModel*)sectionModel atIndex:(NSInteger)index;
//addSection 非初始化增加section调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormSectionBlock:(FormSectionBlock)addFormSection atIndex:(NSInteger)index;
//deleleSectionWithKey
- (BOOL)wDeleteFormSectionWithKey:(NSString*)key;
//deleleSectionWithKey
- (BOOL)wDeleteFormSectionWithIndex:(NSInteger)index;
//deleleRowWithKey
- (BOOL)wDeleteFormRowWithKey:(NSString*)key;
//deleleRowWithIndexPath
- (BOOL)wDeleteFormRowWithIndexPath:(NSIndexPath*)indexPath;
//reloadRow With key
- (BOOL)wReloadRowWithKey:(NSString*)key;
//reloadRow With indexPath
- (BOOL)wReloadRowWithIndexPath:(NSIndexPath*)indexPath;
//reloadSection With key
- (BOOL)wReloadSectionWithKey:(NSString*)key;
//reloadSection With index
- (BOOL)wReloadSectionWithIndex:(NSInteger)index;
//getRow With key
- (WMZFormRowModel*)wFindRowModelWithKey:(NSString*)key;
//getRow With indexPath
- (WMZFormRowModel*)wFindRowModelWithIndexPath:(NSIndexPath*)indexPath;
//getSection With key
- (WMZFormSectionModel*)wFindSectionModelWithKey:(NSString*)key;
//getSection With index
- (WMZFormSectionModel*)wFindSectionModelWithIndex:(NSInteger)index;
//reloadData
- (void)wReloadData;
//自定义刷新
- (void)wReloadData:(FormCustomReload)block;
@end

NS_ASSUME_NONNULL_END
