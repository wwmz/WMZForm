//
//  AllPropertiesVC.m
//  WMZForm
//
//  Created by wmz on 2020/5/11.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "AllPropertiesVC.h"
@interface AllPropertiesVC ()

@end

@implementation AllPropertiesVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"全部属性";
    
    FormWeakSelf(self)
    WMZForm *form =
    Form(CGRectMake(0, NavigationBar_Form_Height, self.view.bounds.size.width , self.view.bounds.size.height - NavigationBar_Form_Height))
    .wAddFormDelegate(self)
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormCellName(@(FormCellText))
        .wFormShowLine(YES)
        .wFormName(@"短文本");
    })
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormCellName(@(FormCellText))
        .wFormRowData(@{@"showAllText":@(YES)})
    .wFormName(@"忙的时候，想要休息\n度假的时候，想到未来。\n穷的时候，渴望富有；\n生活安逸了，怕幸福不能长久。\n该决定的时候，担心结果不如预期；\n看明白了，后悔当初没有下定决心。\n不属于自己的，常常心存欲望；\n握在手里了，又怀念未拥有前的轻松。\n生命若不是现在，那是何时");
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
       sectionModel
       .wFormSectionInfo(@{@"fold":@(YES)})  //可折叠
       .wFormHeadTitle(@"DefaultCellHeadView")
       .wFormSectionData([weakObject getFormBaseArr])
       .wFormShowLine(YES)
       .wFormCellName(@(FormCellDefault));
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        sectionModel
        .wFormHeadTitle(@"NormalCellHeadView")
        .wFormSectionData([weakObject getFormNormalArr])
        .wFormShowLine(YES)
        .wFormCellName(@(FormCellNormal));
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
        sectionModel
        .wFormHeadTitle(@"IconCellHeadView")
        .wFormSectionData([weakObject getFormIconArr])
        .wFormShowLine(YES)
        .wFormCellName(@(FormCellIcon));
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
          sectionModel
          .wFormHeadTitle(@"InputCellHeadView")
          .wFormSectionData([weakObject getFormInputArr])
          .wFormShowLine(YES)
          .wFormCellName(@(FormCellInput));
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
          sectionModel
          .wFormHeadTitle(@"TextViewCellHeadView")
          .wFormSectionData([weakObject getTextViewArr])
          .wFormShowLine(YES)
          .wFormCellName(@(FormCellTextView));
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
          sectionModel
          .wFormHeadTitle(@"VerificationCellHeadView")
          .wFormSectionData([weakObject getVerificationArr])
          .wFormShowLine(YES)
          .wFormCellName(@(FormCellVerification));
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
          sectionModel
          .wFormHeadTitle(@"ImageCellHeadView")
          .wFormSectionData([weakObject getImageArr])
          .wFormShowLine(YES)
          .wFormCellName(@(FormCellImage));
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
          sectionModel
          .wFormHeadTitle(@"SwitchCellHeadView")
          .wFormSectionData([weakObject getSwitchArr])
          .wFormShowLine(YES)
          .wFormCellName(@(FormCellSwitch));
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
          sectionModel
          .wFormHeadTitle(@"CheckCellHeadView")
          .wFormSectionData([weakObject getCheckArr])
          .wFormShowLine(YES)
          .wFormCellName(@(FormCellCheck));
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
          sectionModel
          .wFormHeadTitle(@"TagCellHeadView")
          .wFormSectionData([weakObject getTagArr])
          .wFormShowLine(YES)
          .wFormCellName(@(FormCellTag));
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
          sectionModel
          .wFormHeadTitle(@"TakePictureCellHeadView")
          .wFormSectionData([weakObject getTakePicArr])
          .wFormShowLine(YES)
          .wFormCellName(@(FormCellTakePicture));
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
    })
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
          WMZFormRowModel *rowModel =
          FormRowModel()
          .wFormCellName(@(FormCellCommit))
          .wFormRowData(@{@"fill":@(YES),@"type":@(FormClickClick)})
          .wFormCustomButton(^(UIButton * _Nullable button) {
              button.backgroundColor = [UIColor whiteColor];
              [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
          })
          .wFormBtn(@"退出");
        
          sectionModel
          .wFormHeadHeight(20)
          .wFormFootHeight(20)
          .wFormSectionData(@[rowModel])
          .wFormCellName(@(FormCellTag));
    });
    [self.view addSubview:form];
}

#pragma -mark delegate
//提交表单
- (void)form:(WMZForm *)form info:(NSDictionary *)commitInfo canCommit:(BOOL)success{
    NSLog(@"提交表单 %@ %d",commitInfo,success);
}
//点击cell
- (void)form:(WMZForm *)form didSelectRowAtCell:(WMZFormBaseCell *)cell{
    
}
//点击cell上控件的交互事件
- (void)form:(WMZForm *)form subViewDidSelectRowAtCell:(WMZFormBaseCell *)cell view:(UIView *)clickView type:(id)action{
    
}

- (NSArray*)getFormBaseArr{
    return @[
        FormRowModel()
        .wFormName(@"WMZFormBaseCell")
        .wFormDetail(@"It's time to make a snowman.James runs out. He makes a big pile of snow. "),
        
        FormRowModel()
        .wFormName(@"WMZFormBaseCell")
        .wFormDetail(@"He puts a big snowball on top")
        .wFormCustomNameLabel(^(UILabel * _Nullable label) {
            label.textColor = [UIColor redColor];
        }),
    ];
}

- (NSArray*)getFormNormalArr{
    return @[
        FormRowModel()
        .wFormName(@"WMZFormNormalCell")
        .wFormDetail(@"He puts a big snowball on top")
        .wFormCustomNameLabel(^(UILabel * _Nullable label) {
            label.textColor = [UIColor redColor];
        }),
        
        FormRowModel()
        .wFormName(@"WMZFormNormalCell")
        .wFormDetail(@"It's time to make a snowman.James runs out. He makes a big pile of snow. "),
    ];
}

- (NSArray*)getFormIconArr{
    return @[
        FormRowModel()
        .wFormName(@"WMZFormIconCell")
        .wFormDetail(@"He puts a big snowball on top")
        .wFormIcon(@"formIcon")
        .wFormCustomDetailLabel(^(UILabel * _Nullable detail) {
            detail.textColor = [UIColor yellowColor];
        })
        .wFormCustomImageView(^(UIImageView * _Nullable imageView) {
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = Form_GetWNum(40);
            imageView.contentMode = UIViewContentModeScaleToFill;
        }),
        
        FormRowModel()
        .wFormIcon(@"formIcon")
        .wFormName(@"WMZFormIconCell")
        .wFormDetail(@"It's time to make a snowman.James runs out"),
    ];
}

- (NSArray*)getFormInputArr{
    FormRowModel()
    .wFormCustomInput(^(UITextField * _Nullable textField) {
        
    });
    return @[
        FormRowModel()
        .wFormKey(@"age")   //设置唯一标志
        .wFormName(@"年龄")
        .wFormDetail(@"岁")
        .wFormRowData(@{@"maxNum":@(3)})
        .wFormOpenRule(YES)  //开启检验
        .wFormCustomInput(^(UITextField * _Nullable textField) {
            textField.placeholder = @"请输入年龄";
            textField.keyboardType = UIKeyboardTypePhonePad;
            textField.textAlignment = NSTextAlignmentRight;
            textField.font =  [UIFont systemFontOfSize:FormDefaultDetailFont];
        }),
        
        FormRowModel()
        .wFormName(@"身份证"),
        
        FormRowModel()
        .wFormName(@"车牌号")
        .wFormRowData(@{@"regular":@(FormRegularCar)})
        .wFormOpenRule(YES),
        
        FormRowModel()
        .wFormName(@"支付金额")
        .wFormRowData(@{
            @"regular":@"^([0-9]+|[0-9]{1,3}(,[0-9]{3})*)(.[0-9]{1,2})?$",
            @"ruleTip":@"金钱输入错误"})  //自定义规则 自定义提示
        .wFormOpenRule(YES)
        .wFormCustomInput(^(UITextField * _Nullable textField) {
            textField.placeholder = @"请输入支付金额";
            textField.keyboardType = UIKeyboardTypeDecimalPad;
            textField.textAlignment = NSTextAlignmentLeft;
            textField.font =  [UIFont systemFontOfSize:FormDefaultDetailFont];
        }),
    ];
}

- (NSArray*)getTextViewArr{
    return @[
        FormRowModel()
        .wFormRowData(@{@"maxNum":@(200),@"placeholder":@"请输入"})
        .wFormName(@"显示标题")
        .wFormCustomTextView(^(UITextView * _Nullable textView) {
            textView.textColor = [UIColor redColor];
        }),
        
        FormRowModel()
        .wFormKey(@"selfSign")
        .wFormDetail(@"个性签名")
        .wFormCustomDetailLabel(^(UILabel * _Nullable detail) {
            detail.textColor = [UIColor orangeColor];
            detail.font = [UIFont systemFontOfSize:14.0f];
        })
        .wFormValue(@"我是默认输入的内容"),
    ];
}

- (NSArray*)getVerificationArr{
    return @[
        FormRowModel()
        .wFormCustomButton(^(UIButton * _Nullable button) {
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 5;
            button.titleLabel.font = [UIFont systemFontOfSize:FormDefaultBtnFont];
        })
        .wFormCustomInput(^(UITextField * _Nullable textField) {
            textField.placeholder = @"请输入验证码";
            if (@available(iOS 10.0, *)) {
                textField.textContentType = UITextContentTypeTelephoneNumber;
                textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            }else
            {
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }
            textField.textAlignment = NSTextAlignmentLeft;
            textField.font =  [UIFont systemFontOfSize:FormDefaultDetailFont];
        })
        .wFormName(@"手机验证码")
        .wFormBtn(@"获取验证码"),
        
        
        FormRowModel()
        .wFormKey(@"code")
        .wFormName(@"验证码")
        .wFormBtn(@"获取验证码")
        .wFormTime(30)
        .wFormOpenRule(YES)
        .wFormRowData(@{@"regular":@"\\d{6}$",@"ruleTip":@"请输入六位数字的验证码"}),
    ];
}

- (NSArray*)getImageArr{
    return @[
    FormRowModel()
    .wFormValue(@[
        @"formIcon",
        @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
        @"formIcon",
        @"http://b-ssl.duitang.com/uploads/item/201509/25/20150925081558_N3ZhH.jpeg",
        @"formIcon",
        @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
        @"formIcon",
        @"http://b-ssl.duitang.com/uploads/item/201509/25/20150925081558_N3ZhH.jpeg",
        @"formIcon",
    ]),
    
    FormRowModel()
    .wFormValue(@[
        @"formIcon",
    ]),
    
    FormRowModel()
    .wFormName(@"选择图片")
    .wFormRowData(@{@"insert":@(YES),@"delete":@(YES)})
    .wFormValue(@[
        @"formIcon",
        @"http://b-ssl.duitang.com/uploads/blog/201307/12/20130712100502_Q4HNX.png",
        @"formIcon",
        @"http://b-ssl.duitang.com/uploads/item/201509/25/20150925081558_N3ZhH.jpeg",
    ]),
    ];
}

- (NSArray*)getSwitchArr{
     return @[
         FormRowModel()
         .wFormName(@"推送通知")
         .wFormDetail(@"你可能错过重要资讯通知,点击去设置允许通知")
         .wFormCustomDetailLabel(^(UILabel * _Nullable detail) {
             detail.textColor = [UIColor redColor];
             detail.font = [UIFont systemFontOfSize:13.0f];
         })
         ,
         
         FormRowModel()
         .wFormKey(@"switch")
         .wFormName(@"提示音开关")
         .wFormCustomSwitch(^(UISwitch * _Nullable switcher) {
             switcher.onTintColor = FormColor(0xADD8E6);
         })
         .wFormValue(@(YES)),
     ];
}

- (NSArray*)getCheckArr{
     return @[
         FormRowModel()
         .wFormName(@"是否是本地")
         .wFormDetail(@"你可能错过重要资讯通知,点击去设置允许通知")
         .wFormCustomDetailLabel(^(UILabel * _Nullable detail) {
             detail.textColor = [UIColor orangeColor];
             detail.font = [UIFont systemFontOfSize:12.0f];
         })
         ,
         
         FormRowModel()
         .wFormKey(@"check")
         .wFormName(@"提示音开关")
         .wFormValue(@(YES))
         .wFormCustomButton(^(UIButton * _Nullable button) {
             [button setImage:[UIImage formBundleImage:FormCheckDefaultIcon] forState:UIControlStateNormal];
             [button setImage:[UIImage formBundleImage:@"formIcon"] forState:UIControlStateSelected];
         }),
     ];
}

- (NSArray*)getTagArr{
    return @[
       FormRowModel()
       .wFormName(@"选择时间段")
       .wFormValue(@[
           @"测试1",@"测试2",@"测试3"
       ]),
       
       FormRowModel()
       .wFormName(@"选择时间")
       .wFormRowData(@{@"moreSelect":@(YES)})
       .wFormValue(@[
           @{@"image":@"form_notCheck",@"selectImage":@"form_check"},
           @{@"image":@"form_notCheck",@"selectImage":@"form_check"},
           @{@"image":@"form_notCheck",@"selectImage":@"form_check"},
           @{@"image":@"form_notCheck",@"selectImage":@"form_check"}
       ]),
       
       FormRowModel()
       .wFormKey(@"tag")
       .wFormName(@"选择时间")
       .wFormValue(@[
           @{@"position":@(FormBtnPositionLeft),
             @"isSelected":@(YES),
             @"name":@"测试1",
             @"image":@"form_notCheck",
             @"selectImage":@"form_check"},
           @{@"position":@(FormBtnPositionRight),
             @"name":@"测试2",
             @"image":@"form_notCheck",
             @"selectImage":@"form_check"},
          @{@"position":@(FormBtnPositionTop),
              @"name":@"测试3",
              @"image":@"form_notCheck",
              @"selectImage":@"form_check"},
           @{@"position":@(FormBtnPositionBottom),
               @"name":@"测试4",
               @"image":@"form_notCheck",
               @"selectImage":@"form_check"},
       ]),
    ];
}
- (NSArray*)getTakePicArr{
    return @[
            FormRowModel()
            .wFormKey(@"icCardFront")
            .wFormName(@"身份证正面")
            .wFormIcon(@"addPic"),
            
            FormRowModel()
            .wFormKey(@"icCardUnder")
            .wFormName(@"身份证反面")
            .wFormIcon(@"addPic"),
        ];
}

- (void)dealloc{
    
}
@end
