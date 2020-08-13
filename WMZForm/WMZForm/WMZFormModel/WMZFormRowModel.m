//
//  WMZFormRowModel.m
//  WMZForm
//
//  Created by wmz on 2020/4/18.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormRowModel.h"

@implementation WMZFormRowModel
WMZFormRowModel * FormRowModel(void){
    return  [WMZFormRowModel  new];
}

- (WMZFormRowModel * _Nonnull (^)(BOOL))wFormRequired{
    return ^WMZFormRowModel*(BOOL formRequired){
        self.formRequired = formRequired;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(NSString * _Nonnull))wFormKey{
    return ^WMZFormRowModel*(NSString* formKey){
        self.formKey = formKey;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(id _Nonnull))wFormValue{
    return ^WMZFormRowModel*(id formValue){
        self.formValue = formValue;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(UIColor * _Nonnull))wFormCellBackGround{
    return ^WMZFormRowModel*(UIColor* formCellBackGround){
        self.formCellBackGround = formCellBackGround;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(NSString * _Nonnull))wFormName{
    return ^WMZFormRowModel*(NSString* formName){
        self.formName = formName;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(NSString * _Nonnull))wFormDetail{
    return ^WMZFormRowModel*(NSString* formDetail){
        self.formDetail = formDetail;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(NSString * _Nonnull))wFormBtn{
    return ^WMZFormRowModel*(NSString* formBtn){
        self.formBtn = formBtn;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(NSDictionary * _Nonnull))wFormSelectInfo{
    return ^WMZFormRowModel*(NSDictionary* formSelectInfo){
        self.formSelectInfo = formSelectInfo;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(id _Nonnull))wFormRowData{
    return ^WMZFormRowModel*(id  formRowData){
        self.formRowData = formRowData;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(NSString * _Nonnull))wFormIcon{
    return ^WMZFormRowModel*(NSString *formIcon){
        self.formIcon = formIcon;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(BOOL))wFormOpenRule{
    return ^WMZFormRowModel*(BOOL formOpenRule){
        self.formOpenRule = formOpenRule;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(UITableViewCellEditingStyle))wFormEditingStyle{
    return ^WMZFormRowModel*(UITableViewCellEditingStyle formEditingStyle){
        self.formEditingStyle = formEditingStyle;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(UITableViewCellAccessoryType))wFormCellAccessoryType{
    return ^WMZFormRowModel*(UITableViewCellAccessoryType formCellAccessoryType){
        self.formAccessoryType = formCellAccessoryType;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(UITableViewCellSelectionStyle))wFormSelectionStyle{
    return ^WMZFormRowModel*(UITableViewCellSelectionStyle formSelectionStyle){
          self.formSelectionStyle = formSelectionStyle;
          return self;
      };
}

- (WMZFormRowModel * _Nonnull (^)(NSString * _Nonnull))wFormWarn{
    return ^WMZFormRowModel*(NSString *formWarn){
        self.formWarn = formWarn;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(id _Nonnull))wFormCellName{
    return ^WMZFormRowModel*(id formCellName){
        self.formCellName = formCellName;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(CGFloat))wFormCellHeight{
    return ^WMZFormRowModel*(CGFloat formCellHeight){
        self.formCellHeight = formCellHeight;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(BOOL))wFormShowLine{
    return ^WMZFormRowModel*(BOOL formShowLine){
        self.formShowLine = formShowLine;
        return self;
    };
}


- (WMZFormRowModel * _Nonnull (^)(FormCustomLabel _Nonnull))wFormCustomNameLabel{
    return ^WMZFormRowModel*(FormCustomLabel formCustomNameLabel){
        self.formCustomNameLabel = formCustomNameLabel;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(FormCustomLabel _Nonnull))wFormCustomDetailLabel{
    return ^WMZFormRowModel*(FormCustomLabel formCustomDetailLabel){
        self.formCustomDetailLabel = formCustomDetailLabel;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(FormCustomLabel _Nonnull))wFormCustomWarnLabel{
    return ^WMZFormRowModel*(FormCustomLabel formCustomWarnLabel){
        self.formCustomWarnLabel = formCustomWarnLabel;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(FormCustomView _Nonnull))wFormCustomLineView{
    return ^WMZFormRowModel*(FormCustomView formCustomLineView){
        self.formCustomLineView = formCustomLineView;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(FormCustomButton _Nonnull))wFormCustomButton{
    return ^WMZFormRowModel*(FormCustomButton formCustomButton){
        self.formCustomButton = formCustomButton;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(FormCustomImageView _Nonnull))wFormCustomImageView{
    return ^WMZFormRowModel*(FormCustomImageView formCustomImageView){
        self.formCustomImageView = formCustomImageView;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(FormCustomTextField _Nonnull))wFormCustomInput{
    return ^WMZFormRowModel*(FormCustomTextField formCustomInput){
        self.formCustomInput = formCustomInput;
        return self;
    };
}
- (WMZFormRowModel * _Nonnull (^)(FormCustomTextView _Nonnull))wFormCustomTextView{
    return ^WMZFormRowModel*(FormCustomTextView formCustomTextView){
        self.formCustomTextView = formCustomTextView;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(FormCustomSwitcher _Nonnull))wFormCustomSwitch{
    return ^WMZFormRowModel*(FormCustomSwitcher formCustomSwitch){
        self.formCustomSwitch = formCustomSwitch;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(FormCustomLabel _Nonnull))wFormCustomValueLabel{
    return ^WMZFormRowModel*(FormCustomLabel formCustomValueLabel){
        self.formCustomValueLabel = formCustomValueLabel;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(NSInteger))wFormTime{
    return ^WMZFormRowModel*(NSInteger formTime){
        self.formTime = formTime;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(FormCellViewClickBlock _Nonnull))wFormClickBlock{
    return ^WMZFormRowModel*(FormCellViewClickBlock formClickBlock){
        self.formClickBlock = formClickBlock;
        return self;
    };
}

- (WMZFormRowModel * _Nonnull (^)(FormValueChangeBlock _Nonnull))wFormValueChangeBlock{
    return ^WMZFormRowModel*(FormValueChangeBlock formValueChangeBlock){
        self.formValueChangeBlock = formValueChangeBlock;
        return self;
    };
}

- (void)setFormValue:(id)formValue{
    _formValue = formValue;
    if (!self.valueChangeBlock) {
        if (self.formValueChangeBlock) {
            self.formValueChangeBlock(self);
        }
    }
}

- (instancetype)init{
    if (self = [super init]) {
        self.formKey = @"";
        self.formCellName = @(-1);
        self.formAccessoryType = -1;
        self.formSelectionStyle = -1;
        self.formTime = 60;
        self.rect = CGRectNull;
        self.formEditingStyle = UITableViewCellEditingStyleNone;
    }
    return self;
}
@end
