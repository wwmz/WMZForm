




//
//  TencenSetingVC.m
//  WMZForm
//
//  Created by wmz on 2020/5/11.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "TencenSetingVC.h"

@interface TencenSetingVC ()

@end

@implementation TencenSetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WMZForm *form =
    Form(CGRectMake(0, NavigationBar_Form_Height, self.view.bounds.size.width , self.view.bounds.size.height - NavigationBar_Form_Height- FormTabBarHeight))
    .wAddFormDelegate(self)
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        WMZFormRowModel *model = FormRowModel().wFormName(@"账号与安全");
        sectionModel
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormSectionData(@[model]);
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        NSArray *arr = @[
         FormRowModel().wFormName(@"新消息通知").wFormShowLine(YES),
         FormRowModel().wFormName(@"隐私").wFormShowLine(YES),
         FormRowModel().wFormName(@"通用")
        ];
        sectionModel
        .wFormHeadHeight(10)
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormSectionData(arr);
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        NSArray *arr = @[
         FormRowModel().wFormName(@"帮助与反馈").wFormDetail(@"版本1.1.1").wFormShowLine(YES),
         FormRowModel().wFormName(@"关于微信"),
        ];
        sectionModel
        .wFormHeadHeight(10)
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormSectionData(arr);
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        WMZFormRowModel *model = FormRowModel().wFormName(@"插件");
        sectionModel
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormHeadHeight(10)
        .wFormSectionData(@[model]);
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        WMZFormRowModel *rowModel =
        FormRowModel()
        .wFormCellName(@(FormCellCommit))
        .wFormRowData(@{@"fill":@(YES),@"type":@"changeAccount"})
        .wFormCustomButton(^(UIButton * _Nullable button) {
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        })
        .wFormBtn(@"切换账号");
        
        sectionModel
        .wFormHeadHeight(10)
        .wFormSectionData(@[rowModel]);
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        WMZFormRowModel *rowModel =
        FormRowModel()
        .wFormCellName(@(FormCellCommit))
        .wFormRowData(@{@"fill":@(YES),@"type":@"logout"})
        .wFormCustomButton(^(UIButton * _Nullable button) {
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        })
        .wFormBtn(@"退出");
        
        sectionModel
        .wFormHeadHeight(10)
        .wFormSectionData(@[rowModel]);
    });
    form.tableView.backgroundColor = FormColor(0xeeeeee);
    [self.view addSubview:form];
}

- (void)form:(WMZForm *)form didSelectRowAtCell:(WMZFormBaseCell *)cell{
    NSLog(@"点击");
}

@end
