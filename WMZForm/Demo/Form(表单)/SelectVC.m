//
//  SelectVC.m
//  WMZForm
//
//  Created by wmz on 2020/5/12.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "SelectVC.h"

@interface SelectVC ()
@property(nonatomic,strong)WMZForm *form;
@end

@implementation SelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"全部属性";
    
    /*
     *wFormSelectInfo参数说明
     @param title 标题
     @param data 数据
     @param multipleSelection 多选
     @param type FormCellClickType枚举 默认FormCellTypeSelect
     @param timeType 时间选择器type 默认@"yyyy-MM-dd HH:mm:ss"
     @param locationType 地区选择器type 默认3 3位省市区 2为省市 3为省
     @param check 不调用框架弹窗
     */
    
    
    WMZFormRowModel *addModel = FormRowModel()
    .wFormCellName(@(FormCellTakePicture))
    .wFormShowLine(YES)
    .wFormKey(@"idCard")
    .wFormName(@"身份证正面")
    .wFormIcon(@"addPic");
    
    
    
    WMZFormRowModel *sonModel = FormRowModel()
    .wFormName(@"选择图片")
    .wFormKey(@"upload")
    .wFormRowData(@{@"insert":@(YES),@"delete":@(YES)})
    .wFormValue(@[
        @"formIcon",
        @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
        @"formIcon",
        @"http://b-ssl.duitang.com/uploads/item/201509/25/20150925081558_N3ZhH.jpeg",
    ]);
    WMZFormSectionModel *sectionModel = FormSectionModel()
    .wFormCellName(@(FormCellImage))
    .wFormSectionData(@[sonModel]);
    FormWeakSelf(self)
    self.form =
    Form(CGRectMake(0, NavigationBar_Form_Height, self.view.bounds.size.width , self.view.bounds.size.height - NavigationBar_Form_Height))
    .wAddFormDelegate(self)
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormKey(@"hobby")
        .wFormRequired(YES)
        .wFormCellName(@(FormCellEdit))
        .wFormName(@"爱好")
        .wFormSelectInfo(@{@"title":@"请选择",
                           @"data":@[@"篮球",@"游泳",@"编程"]})
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormShowLine(YES);
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormKey(@"beganTime")
        .wFormRequired(YES)
        .wFormCellName(@(FormCellEdit))
        .wFormName(@"开始时间")
        .wFormSelectInfo(@{@"timeType":@"yyyy-MM-dd",
                           @"type":@(FormCellTypeDate),
                           @"title":@"请选择开始时间"})
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormShowLine(YES);
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormCellName(@(FormCellEdit))
        .wFormName(@"结束时间")
        .wFormRequired(YES)
        .wFormKey(@"endTime")
        .wFormSelectInfo(@{@"type":@(FormCellTypeDate),
                           @"title":@"请选择结束时间"})
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormShowLine(YES);
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormKey(@"address")
        .wFormRequired(YES)
        .wFormCellName(@(FormCellEdit))
        .wFormName(@"地址")
        .wFormSelectInfo(@{@"type":@(FormCellTypeLocation),
//                            @"locationType":@(2),  //2表示只有省市 1为省
                            @"title":@"请选择地址"})
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormShowLine(YES);
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormKey(@"durtion")
        .wFormRequired(YES)
        .wFormCellName(@(FormCellEdit))
        .wFormName(@"选择时间段")
        .wFormSelectInfo(@{@"type":@(FormCellTypeCalander),
                           @"title":@"请选择时间段"})
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormShowLine(YES);
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormKey(@"cardType")
        .wFormRequired(YES)
        .wFormCellName(@(FormCellEdit))
        .wFormName(@"身份证")
        .wFormSelectInfo(@{@"type":@(FormCellTypeSelectPush),
                           @"data":@[@"身份证",@"护照",@"军人证",@"其他"],
//                           @"multipleSelection":@(YES), //  多选
                           @"title":@"证件类型"})
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormShowLine(YES);
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormKey(@"sex")
        .wFormRequired(YES)
        .wFormCellName(@(FormCellTag))
        .wFormName(@"选择性别")
        .wFormValue(@[
            @{@"image":@"form_nan",@"name":@"男"},
            @{@"image":@"form_nv",@"name":@"女"},
        ])
        .wFormShowLine(YES);
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormKey(@"code")
        .wFormName(@"验证码")
        .wFormBtn(@"获取验证码")
        .wFormTime(30)
        .wFormRequired(YES)
        .wFormOpenRule(YES)
        .wFormCellName(@(FormCellVerification))
        .wFormRowData(@{@"regular":@"\\d{6}$",@"ruleTip":@"请输入六位数字的验证码"})
        .wFormShowLine(YES);
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormKey(@"money")
        .wFormRequired(YES)
        .wFormCellName(@(FormCellInput))
        .wFormName(@"年薪")
        .wFormDetail(@"万元")
        .wFormShowLine(YES)
        .wFormCustomInput(^(UITextField * _Nullable textField) {
            textField.placeholder = @"请输入";
            textField.keyboardType = UIKeyboardTypeDecimalPad;
            textField.textAlignment = NSTextAlignmentRight;
            textField.font =  [UIFont systemFontOfSize:FormDefaultDetailFont];
        });
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormKey(@"content")
        .wFormRequired(YES)
        .wFormCellName(@(FormCellTextView))
        .wFormShowLine(YES)
        .wFormRowData(@{@"maxNum":@(200),@"placeholder":@"请输入明细"})
        .wFormName(@"明细");
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormKey(@"open")
        .wFormCellName(@(FormCellSwitch))
        .wFormShowLine(YES)
        .wFormName(@"开启图片上传")
        .wFormValueChangeBlock(^(WMZFormRowModel * _Nullable model) {
            if (model.formValue) {
                if ([model.formValue floatValue]) {
                    //增加示例
                    [weakObject.form wAddFormRow:addModel atIndex:weakObject.form.arrayModel.dataArray.count-1];
                    [weakObject.form wAddFormSection:sectionModel atIndex:weakObject.form.arrayModel.dataArray.count-1];
                }else{
                    [weakObject.form wDeleteFormRowWithIndexPath:addModel.indexPath];
                    [weakObject.form wDeleteFormSectionWithKey:@"upload"];
                }
            }
        });
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormCellName(@(FormCellCommit))
        .wFormCustomButton(^(UIButton * _Nullable button) {
            button.backgroundColor = [UIColor orangeColor];
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 10;
        })
        .wFormBtn(@"提交");
    });
    self.form.tableView.backgroundColor = FormColor(0xeeeeee);
    [self.view addSubview:self.form];
}

//提交表单
- (void)form:(WMZForm *)form info:(NSDictionary *)commitInfo canCommit:(BOOL)success{
    NSLog(@"提交表单 %@ %d",commitInfo,success);
    if (success) {
        Alert(@"提交成功");
    }
}
@end

