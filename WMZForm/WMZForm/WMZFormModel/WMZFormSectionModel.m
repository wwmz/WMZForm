


//
//  WMZFormSectionModel.m
//  WMZForm
//
//  Created by wmz on 2020/4/18.
//  Copyright © 2020 wmz. All rights reserved.

#import "WMZFormSectionModel.h"
@implementation WMZFormSectionModel

WMZFormSectionModel * FormSectionModel(void){
    return  [WMZFormSectionModel  new];
}

- (WMZFormSectionModel * _Nonnull (^)(NSArray<WMZFormRowModel *> * _Nonnull))wFormSectionData{
    return ^WMZFormSectionModel*(NSArray<WMZFormRowModel *> * formSectionData){
        self.formSectionData = formSectionData;
        return self;
    };
}

- (WMZFormSectionModel * _Nonnull (^)(NSString * _Nonnull))wFormHeadTitle{
    return ^WMZFormSectionModel*(NSString * formHeadTitle){
        self.formHeadTitle = formHeadTitle;
        return self;
    };
}

- (WMZFormSectionModel * _Nonnull (^)(CGFloat))wFormHeadHeight{
    return ^WMZFormSectionModel*(CGFloat  formHeadHeight){
        self.formHeadHeight = formHeadHeight;
        return self;
    };
}

- (WMZFormSectionModel * _Nonnull (^)(NSString * _Nonnull))wFormFootTitle{
    return ^WMZFormSectionModel*(NSString * formFootTitle){
        self.formFootTitle = formFootTitle;
        return self;
    };
}


- (WMZFormSectionModel * _Nonnull (^)(CGFloat))wFormFootHeight{
    return ^WMZFormSectionModel*(CGFloat  formFootHeight){
        self.formFootHeight = formFootHeight;
        return self;
    };
}

- (WMZFormSectionModel * _Nonnull (^)(UIColor * _Nonnull))wFormHeadBackGround{
    return ^WMZFormSectionModel*(UIColor*  formHeadBackGround){
        self.formHeadBackGround = formHeadBackGround;
        return self;
    };
}

- (WMZFormSectionModel * _Nonnull (^)(UIColor * _Nonnull))wFormFootBackGround{
    return ^WMZFormSectionModel*(UIColor*  formFootBackGround){
        self.formFootBackGround = formFootBackGround;
        return self;
    };
}

- (WMZFormSectionModel * _Nonnull (^)(id _Nonnull))wFormCellName{
    return ^WMZFormSectionModel*(id formCellName){
        self.formCellName = formCellName;
        return self;
    };
}
- (WMZFormSectionModel * _Nonnull (^)(CGFloat))wFormCellHeight{
    return ^WMZFormSectionModel*(CGFloat formCellHeight){
        self.formCellHeight = formCellHeight;
        return self;
    };
}
- (WMZFormSectionModel * _Nonnull (^)(BOOL))wFormShowLine{
    return ^WMZFormSectionModel*(BOOL formShowLine){
        self.formShowLine = formShowLine;
        return self;
    };
}

- (WMZFormSectionModel * _Nonnull (^)(NSDictionary * _Nonnull))wFormSectionInfo{
    return ^WMZFormSectionModel*(NSDictionary* formSectionInfo){
        self.formSectionInfo = formSectionInfo;
        return self;
    };
}
- (WMZFormSectionModel * _Nonnull (^)(UITableViewCellAccessoryType))wFormCellAccessoryType{
    return ^WMZFormSectionModel*(UITableViewCellAccessoryType formCellAccessoryType){
        self.formAccessoryType = formCellAccessoryType;
        return self;
    };
}

- (WMZFormSectionModel * _Nonnull (^)(NSString * _Nonnull))wFormSectionKey{
    return ^WMZFormSectionModel*(NSString* formSectionKey){
        self.formSectionKey = formSectionKey;
        return self;
    };
}

- (WMZFormSectionModel * _Nonnull (^)(FormCustomLabel _Nonnull))wFormCustomNameLabel{
    return ^WMZFormSectionModel*(FormCustomLabel formCustomNameLabel){
        self.formCustomNameLabel = formCustomNameLabel;
        return self;
    };
}
- (WMZFormSectionModel * _Nonnull (^)(FormCustomLabel _Nonnull))wFormCustomDetailLabel{
    return ^WMZFormSectionModel*(FormCustomLabel formCustomDetailLabel){
        self.formCustomDetailLabel = formCustomDetailLabel;
        return self;
    };
}
- (WMZFormSectionModel * _Nonnull (^)(FormCustomLabel _Nonnull))wFormCustomWarnLabel{
    return ^WMZFormSectionModel*(FormCustomLabel formCustomWarnLabel){
        self.formCustomWarnLabel = formCustomWarnLabel;
        return self;
    };
}
- (WMZFormSectionModel * _Nonnull (^)(FormCustomView _Nonnull))wFormCustomLineView{
    return ^WMZFormSectionModel*(FormCustomView formCustomLineView){
        self.formCustomLineView = formCustomLineView;
        return self;
    };
}
- (WMZFormSectionModel * _Nonnull (^)(FormCustomButton _Nonnull))wFormCustomButton{
    return ^WMZFormSectionModel*(FormCustomButton formCustomButton){
        self.formCustomButton = formCustomButton;
        return self;
    };
}
- (WMZFormSectionModel * _Nonnull (^)(FormCustomImageView _Nonnull))wFormCustomImageView{
    return ^WMZFormSectionModel*(FormCustomImageView formCustomImageView){
        self.formCustomImageView = formCustomImageView;
        return self;
    };
}
- (WMZFormSectionModel * _Nonnull (^)(FormCustomTextField _Nonnull))wFormCustomInput{
    return ^WMZFormSectionModel*(FormCustomTextField formCustomInput){
        self.formCustomInput = formCustomInput;
        return self;
    };
}
- (WMZFormSectionModel * _Nonnull (^)(FormCustomTextView _Nonnull))wFormCustomTextView{
    return ^WMZFormSectionModel*(FormCustomTextView formCustomTextView){
        self.formCustomTextView = formCustomTextView;
        return self;
    };
}
- (WMZFormSectionModel * _Nonnull (^)(FormCustomSwitcher _Nonnull))wFormCustomSwitch{
    return ^WMZFormSectionModel*(FormCustomSwitcher formCustomSwitch){
        self.formCustomSwitch = formCustomSwitch;
        return self;
    };
}

- (void)setFormHeadTitle:(NSString *)formHeadTitle{
    _formHeadTitle = formHeadTitle;
    if (formHeadTitle&&
        ![formHeadTitle isEqualToString:@""]&&
        self.formHeadHeight == 0.01) {
        self.formHeadHeight = 40;
    }
}


- (void)setFormFootTitle:(NSString *)formFootTitle{
    _formFootTitle = formFootTitle;
    if (formFootTitle&&
        ![formFootTitle isEqualToString:@""]&&
        self.formFootHeight == 0.01) {
        self.formFootHeight = 40;
    }
}

- (void)setFormSectionData:(NSArray *)formSectionData{
    _formSectionData = formSectionData;
    [_formSectionData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL *   _Nonnull stop) {
      if ([NSStringFromClass([obj class]) isEqualToString:@"WMZFormRowModel"]) {
          WMZFormRowModel *rowModel = (WMZFormRowModel*)obj;
          if (([self.formCellName isKindOfClass:[NSNumber class]]&&
              [self.formCellName intValue]!= -1)) {
              if ([rowModel.formCellName isKindOfClass:[NSNumber class]]&&
                  [rowModel.formCellName intValue]== -1) {
                  rowModel.formCellName = self.formCellName;
              }
          }
          if (self.formShowLine) {
              if (idx == _formSectionData.count - 1 && !rowModel.formShowLine) {
                  rowModel.formShowLine = NO;
              }else{
                  rowModel.formShowLine = YES;
              }
          }
          if (self.formAccessoryType!= -1 &&
              rowModel.formAccessoryType == -1) {
              rowModel.formAccessoryType = self.formAccessoryType;
          }
          if (self.formCellHeight!= 0 &&
              rowModel.formCellHeight == 0) {
              rowModel.formCellHeight = self.formCellHeight;
          }
          if (self.formCustomNameLabel && !rowModel.formCustomNameLabel){
              rowModel.formCustomNameLabel = self.formCustomNameLabel;
          }
          if (self.formCustomDetailLabel && !rowModel.formCustomDetailLabel){
              rowModel.formCustomDetailLabel = self.formCustomDetailLabel;
          }
          if (self.formCustomWarnLabel && !rowModel.formCustomWarnLabel){
              rowModel.formCustomWarnLabel = self.formCustomWarnLabel;
          }
          if (self.formCustomLineView && !rowModel.formCustomLineView){
              rowModel.formCustomLineView = self.formCustomLineView;
          }
          if (self.formCustomButton && !rowModel.formCustomButton){
              rowModel.formCustomButton = self.formCustomButton;
          }
          if (self.formCustomTextView && !rowModel.formCustomTextView){
              rowModel.formCustomTextView = self.formCustomTextView;
          }
          if (self.formCustomInput && !rowModel.formCustomInput){
              rowModel.formCustomInput = self.formCustomInput;
          }
          if (self.formCustomSwitch && !rowModel.formCustomSwitch){
              rowModel.formCustomSwitch = self.formCustomSwitch;
          }
          if (self.formCustomImageView && !rowModel.formCustomImageView){
              rowModel.formCustomImageView = self.formCustomImageView;
          }
       }
    }];
}

- (instancetype)init{
    if (self = [super init]) {
        self.formSectionInfo = @{};
        self.formSectionData = @[];
        self.formHeadHeight = 0.01;
        self.formFootHeight = 0.01;
        self.formCellName = @(-1);
        self.formAccessoryType = -1;
    }
    return self;
}

@end
