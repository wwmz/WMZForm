//
//  WMZFormBase.h
//  WMZForm
//
//  Created by wmz on 2020/2/20.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormBaseCell.h"
#import "WMZFormEmptyView.h"
#import "WMZFormDelegate.h"
NS_ASSUME_NONNULL_BEGIN
@interface WMZFormArrayModel : NSObject
@property (strong,nonatomic)NSMutableArray *dataArray;
@end

@interface WMZFormTableView : UITableView
@end

@interface WMZFormHeadView : UITableViewHeaderFooterView
@property(nonatomic,strong)UILabel *textLa;
@property(nonatomic,strong)UIButton *accessBtn;
@end
@interface WMZFormFootView : WMZFormHeadView
@end

@interface WMZFormBase : UIView
//tableView
@property(nonatomic,strong)WMZFormTableView *tableView;
//cellType 字典
@property(nonatomic,strong)NSDictionary *cellTypeDic;
//info 字典
@property(nonatomic,strong)NSMutableDictionary *info;
//emptyView
@property(nonatomic,strong)WMZFormEmptyView *emptyView;
//数据
@property(nonatomic,strong)WMZFormArrayModel *arrayModel;
//autoClickAction
- (void)clickWithType:(FormCellClickType)type model:(WMZFormRowModel*)model block:(FormSelectInfoBlock)block;
@end
NS_ASSUME_NONNULL_END
