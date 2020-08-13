//
//  WMZFormBase.m
//  WMZForm
//
//  Created by wmz on 2020/2/20.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormBase.h"
#import "FormPushListVC.h"
#import "FormPermission.h"
@implementation WMZFormBase
//autoClickAction
- (void)clickWithType:(FormCellClickType)type model:(WMZFormRowModel*)model block:(FormSelectInfoBlock)block{
    if (type == FormCellTypeSelect) {
        Dialog().wTypeSet(DialogTypeSheet)
        .wMultipleSelectionSet(model.formSelectInfo[@"multipleSelection"]?YES:NO)
        .wCellHeightSet(FormConfirmHeight)
        .wDataSet([self returnArr:model.formSelectInfo[@"data"]])
        .wTitleSet(model.formSelectInfo[@"title"]?:@"")
        .wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type) {
            if (block) {
                block(anyID);
            }
        })
        .wStart();
    }else if(type == FormCellTypeDate){
        Dialog()
        .wEventOKFinishSet(^(id anyID, id otherData) {
            if (block) {
                block(otherData);
            }
        })
        .wTitleSet(model.formSelectInfo[@"title"]?:@"")
        .wDateTimeTypeSet(model.formSelectInfo[@"timeType"]?:@"yyyy-MM-dd HH:mm:ss")
        .wPickRepeatSet(NO)
        .wTypeSet(DialogTypeDatePicker)
        .wStart();
    }else if(type == FormCellTypeLocation){
           Dialog()
           .wEventOKFinishSet(^(id anyID, id otherData) {
               if (block) {
                   block(otherData);
               }
           })
           .wTitleSet(model.formSelectInfo[@"title"]?:@"")
           //分隔符
           .wSeparatorSet(@",")
           .wChainTypeSet(ChainPickView)
           .wLocationTypeSet(model.formSelectInfo[@"locationType"]?
                             [model.formSelectInfo[@"locationType"] intValue]:3)
           .wTypeSet(DialogTypeLocation)
           .wStart();
    }else if(type == FormCellTypeCalander){
            Dialog()
           .wTypeSet(DialogTypeCalander)
           .wMainToBottomSet(YES)
           .wMultipleSelectionSet(YES)
           .wTitleSet(model.formSelectInfo[@"title"]?:@"")
           .wEventOKFinishSet(^(id anyID, id otherData) {
               NSMutableString *string = [NSMutableString new];
               if ([anyID isKindOfClass:[NSArray class]]) {
                   NSArray *marr = (NSArray*)anyID;
                   if (marr.count>0) {
                       if (marr.count == 1) {
                           [string appendString:marr.firstObject];
                       }else{
                           [string appendString:marr.firstObject];
                           [string appendFormat:@" ~ %@",marr.lastObject];
                       }
                       if (block) {
                           block(string);
                       }
                   }
               }
           })
           .wStart();
    }else if (type == FormCellTypeSelectPush){
        FormPushListVC *VC = [FormPushListVC new];
        VC.info = model.formSelectInfo;
        VC.selectModel = model.selectModel;
        VC.block = ^(NSString * _Nonnull value, id  _Nonnull data) {
            model.selectModel = data;
            if (block) {
                block(value);
            }
        };
        [[FormPermission getCurrentVC].navigationController pushViewController:VC animated:YES];
    }
}
- (WMZFormTableView *)tableView{
    if (!_tableView) {
        _tableView = [[WMZFormTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.rowHeight = 44;
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedSectionFooterHeight = 0.01;
            _tableView.estimatedSectionHeaderHeight = 0.01;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _tableView.backgroundColor = FormBgColor;
        [_tableView registerClass:[WMZFormHeadView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([WMZFormHeadView class])];
        [_tableView registerClass:[WMZFormFootView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([WMZFormFootView class])];
    }
    return _tableView;
}
- (WMZFormArrayModel *)arrayModel
{
    if (!_arrayModel) {
        _arrayModel = [WMZFormArrayModel new];
    }
    return _arrayModel;
}

- (NSDictionary *)cellTypeDic{
    if (!_cellTypeDic) {
        _cellTypeDic = @{
            @(-1):@"WMZFormDefaultCell",
            @(FormCellNormal):@"WMZFormNormalCell",
            @(FormCellDefault):@"WMZFormDefaultCell",
            @(FormCellIcon):@"WMZFormIconCell",
            @(FormCellInput):@"WMZFormInputCell",
            @(FormCellText):@"WMZFormTextCell",
            @(FormCellTextView):@"WMZFormTextViewCell",
            @(FormCellVerification):@"WMZFormVerificationCell",
            @(FormCellImage):@"WMZFormImageCell",
            @(FormCellSwitch):@"WMZFormSwitchCell",
            @(FormCellCheck):@"WMZFormCheckCell",
            @(FormCellTag):@"WMZFormTagCell",
            @(FormCellCommit):@"WMZFormCommitCell",
            @(FormCellEdit):@"WMZFormEditCell",
            @(FormCellTakePicture):@"WMZFormTakePictureCell"
        };
    }
    return _cellTypeDic;
}
- (NSArray*)returnArr:(id)arr{
    NSArray* selectData = arr?:@[];
    if (![arr isKindOfClass:[NSArray class]]&&![arr isKindOfClass:[NSMutableArray class]]) {
        selectData = @[];
    }
    return selectData;
}
-(void)dealloc{
    [self.arrayModel removeObserver:self forKeyPath:@"dataArray"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

@implementation WMZFormHeadView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.textLa];
        [self.contentView addSubview:self.detailLa];
        [self.contentView addSubview:self.accessBtn];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnWidth = self.frame.size.height>20?20:0;
    CGFloat width = (self.frame.size.width-FormXOffset*3-btnWidth)/2;
    self.textLa.frame = CGRectMake(FormXOffset, 0, width, self.frame.size.height);
    self.detailLa.frame = CGRectMake(width, 0, width, self.frame.size.height);
    self.accessBtn.frame = CGRectMake(self.frame.size.width-FormXOffset-btnWidth, (self.frame.size.height-btnWidth)/2, btnWidth, btnWidth);
}
- (UILabel *)textLa{
    if (!_textLa) {
        _textLa = [UILabel new];
        _textLa.font = [UIFont systemFontOfSize:15.0f];
        _textLa.numberOfLines = 0;
        _textLa.textColor = FormColor(0x333333);
    }
    return _textLa;
}
- (UILabel *)detailLa{
    if (!_detailLa) {
        _detailLa = [UILabel new];
        _detailLa.font = [UIFont systemFontOfSize:15.0f];
        _detailLa.numberOfLines = 0;
        _detailLa.textAlignment = NSTextAlignmentRight;
        _detailLa.textColor = FormColor(0x333333);
    }
    return _detailLa;
}

- (UIButton *)accessBtn{
    if (!_accessBtn) {
        _accessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _accessBtn;
}
@end

@implementation WMZFormFootView
@end

@implementation WMZFormTableView
@end

@implementation WMZFormArrayModel
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
@end

