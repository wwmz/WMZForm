//
//  ViewController.m
//  WMZForm
//
//  Created by wmz on 2020/2/20.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "ViewController.h"
#import "WMZForm.h"
@interface ViewController ()<WMZFormDelegate>
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    WMZForm *form =
    Form(CGRectMake(0, NavigationBar_Form_Height, self.view.bounds.size.width , self.view.bounds.size.height - NavigationBar_Form_Height))
    .wAddFormDelegate(self)
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormValue(@"AllPropertiesVC")
        .wFormName(@"全部属性demo")
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormShowLine(YES);
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormValue(@"SelectVC")
        .wFormName(@"表单demo")
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormShowLine(YES);
    })
   .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormValue(@"TouTiaoTabbar")
        .wFormName(@"头条demo")
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormShowLine(YES);
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormValue(@"TencenTabbar")
        .wFormName(@"腾讯demo")
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormShowLine(YES);
    });
    [self.view addSubview:form];
}

- (void)form:(WMZForm *)form didSelectRowAtCell:(WMZFormBaseCell *)cell{
    Class VC = NSClassFromString(cell.model.formValue);
    if (VC) {
        [self.navigationController pushViewController:[VC new] animated:YES];
    }
}
@end
