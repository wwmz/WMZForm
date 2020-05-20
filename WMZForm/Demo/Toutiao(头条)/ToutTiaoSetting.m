
//
//  ToutTiaoSetting.m
//  WMZForm
//
//  Created by wmz on 2020/5/16.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "ToutTiaoSetting.h"

@implementation ToutTiaoSetting
- (void)viewDidLoad{
    [super viewDidLoad];
    FormWeakSelf(self)
    WMZForm *form =
    Form(CGRectMake(0, NavigationBar_Form_Height, self.view.bounds.size.width , self.view.bounds.size.height - NavigationBar_Form_Height- FormTabBarHeight))
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        NSArray *arr = @[
         FormRowModel().wFormName(@"编辑子类"),
         FormRowModel().wFormName(@"账号和隐私设置"),
         FormRowModel().wFormName(@"黑名单")
        ];
        sectionModel
        .wFormHeadHeight(10)
        .wFormShowLine(YES)
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormSectionData(arr);
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        FormStrongSelf(weakObject)
        sectionModel
        .wFormHeadHeight(10)
        .wFormCustomDetailLabel(^(UILabel * _Nullable label) {
            label.textColor = FormColor(0x999999);
            label.font = [UIFont systemFontOfSize:14.0f];
        })
        .wFormSectionData([strongObject getArr]);
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        WMZFormRowModel *model = FormRowModel().wFormName(@"广告设置");
        sectionModel
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormHeadHeight(10)
        .wFormSectionData(@[model]);
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        NSArray *arr = @[
         FormRowModel().wFormName(@"头条封面"),
         FormRowModel().wFormName(@"检查版本"),
         FormRowModel().wFormName(@"关于头条")
        ];
        sectionModel
        .wFormHeadHeight(10)
        .wFormShowLine(YES)
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormSectionData(arr);
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        WMZFormRowModel *rowModel =
        FormRowModel()
        .wFormCellName(@(FormCellCommit))
        .wFormRowData(@{@"fill":@(YES),@"type":@"logout",@"top":@(40)})
        .wFormCustomButton(^(UIButton * _Nullable button) {
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        })
        .wFormCellBackGround(FormColor(0xeeeeee))
        .wFormBtn(@"退出登录");
        
        sectionModel
        .wFormHeadHeight(10)
        .wFormSectionData(@[rowModel]);
    });
    form.tableView.backgroundColor = FormColor(0xeeeeee);
    [self.view addSubview:form];
}

- (NSArray*)getArr{
    return @[
      FormRowModel()
      .wFormCellName(@(FormCellSwitch))
      .wFormName(@"夜间模式"),
      
      FormRowModel()
      .wFormName(@"清除缓存")
      .wFormDetail(@"200MB"),
      
      FormRowModel()
      .wFormName(@"字体大小")
      .wFormDetail(@"中"),
      
      FormRowModel()
      .wFormName(@"非WIFI网络流量")
      .wFormDetail(@"最佳效果"),
      
      FormRowModel()
      .wFormName(@"非WIFI网络播放提醒")
      .wFormDetail(@"提醒一次"),
      
      FormRowModel()
      .wFormCellName(@(FormCellSwitch))
      .wFormName(@"推送通知")
      .wFormDetail(@"你可能错过重要的咨询通知")
      .wFormCustomDetailLabel(^(UILabel * _Nullable label) {
          label.textColor = [UIColor redColor];
          label.font = [UIFont systemFontOfSize:12.0f];
      }),
      
      FormRowModel()
      .wFormCellName(@(FormCellSwitch))
      .wFormName(@"夜间模式")
      .wFormValue(@(YES)),
      
      FormRowModel()
      .wFormCellName(@(FormCellSwitch))
      .wFormName(@"小说畅读模式")
      .wFormDetail(@"开启后,阅读网页小说自动进入畅读模式")
      .wFormValue(@(YES)),
    ];
}
@end
