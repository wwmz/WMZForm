//
//  WMZFormSectionModel.h
//  WMZForm
//
//  Created by wmz on 2020/4/18.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormRowModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZFormSectionModel : NSObject

WMZFormSectionModel * FormSectionModel(void);
//唯一id default @""
@property(nonatomic,copy,readonly)   WMZFormSectionModel *(^wFormSectionKey)       (NSString* formSectionKey);
//custom headView title default nil
@property(nonatomic,copy,readonly)   WMZFormSectionModel *(^wFormHeadTitle)        (NSString*  formHeadTitle);
//custom headView height default 0.01
@property(nonatomic,assign,readonly) WMZFormSectionModel *(^wFormHeadHeight)       (CGFloat  formHeadHeight);
//custom footView title default nil
@property(nonatomic,copy,readonly)   WMZFormSectionModel *(^wFormFootTitle)        (NSString*  formFootTitle);
//custom footView height default 0.01
@property(nonatomic,assign,readonly) WMZFormSectionModel *(^wFormFootHeight)       (CGFloat  formFootHeight);
//custom headView backGround default gray
@property(nonatomic,copy,readonly)   WMZFormSectionModel *(^wFormHeadBackGround)   (UIColor*  formHeadBackGround);
//custom footView backGround default gray
@property(nonatomic,copy,readonly)   WMZFormSectionModel *(^wFormFootBackGround)   (UIColor*  formFootBackGround);
//custom button default nil
@property(nonatomic,copy,readonly)   WMZFormSectionModel *(^wFormSectionData)      (NSArray <WMZFormRowModel*>* formSectionData);
//cellName  default FIFormBaseCell
@property(nonatomic,strong,readonly) WMZFormSectionModel *(^wFormCellName)         (id formCellName);
//showLine default NO
@property(nonatomic,assign,readonly) WMZFormSectionModel *(^wFormShowLine)         (BOOL formShowLine);
//cellHeight defalt UITableViewAutomaticDimension
@property(nonatomic,assign,readonly) WMZFormSectionModel *(^wFormCellHeight)       (CGFloat formCellHeight);
//cellAccessoryType default  UITableViewCellAccessoryNone
@property(nonatomic,assign,readonly) WMZFormSectionModel *(^wFormCellAccessoryType)(UITableViewCellAccessoryType formAccessoryType);
//custom nameLabel default nil
@property(nonatomic,copy,readonly) WMZFormSectionModel *(^wFormCustomNameLabel)    (FormCustomLabel formCustomNameLabel);
//custom detailLabel default nil
@property(nonatomic,copy,readonly) WMZFormSectionModel *(^wFormCustomDetailLabel)  (FormCustomLabel formCustomDetailLabel);
//custom nameLabel default nil
@property(nonatomic,copy,readonly) WMZFormSectionModel *(^wFormCustomWarnLabel)    (FormCustomLabel formCustomWarnLabel);
//custom line default nil
@property(nonatomic,copy,readonly) WMZFormSectionModel *(^wFormCustomLineView)     (FormCustomView formCustomLineView);
//custom button default nil
@property(nonatomic,copy,readonly) WMZFormSectionModel *(^wFormCustomButton)       (FormCustomButton formCustomButton);
//custom imageView default nil
@property(nonatomic,copy,readonly) WMZFormSectionModel *(^wFormCustomImageView)    (FormCustomImageView formCustomImageView);
//custom textFiled default nil
@property(nonatomic,copy,readonly) WMZFormSectionModel *(^wFormCustomInput)        (FormCustomTextField formCustomInput);
//custom textView default nil
@property(nonatomic,copy,readonly) WMZFormSectionModel *(^wFormCustomTextView)     (FormCustomTextView formCustomTextView);
//custom switch default nil
@property(nonatomic,copy,readonly) WMZFormSectionModel *(^wFormCustomSwitch)       (FormCustomSwitcher formCustomSwitch);
//section Data
//@{
// @"fold":@(YES) 可折叠
//}
@property(nonatomic,strong,readonly) WMZFormSectionModel *(^wFormSectionInfo)      (NSDictionary* formSectionInfo);

//实例链式属性
@property(nonatomic,strong) NSArray  *formSectionData;
@property(nonatomic,  copy) NSString *formHeadTitle;
@property(nonatomic,assign) CGFloat  formHeadHeight;
@property(nonatomic,  copy) NSString *formFootTitle;
@property(nonatomic,assign) CGFloat  formFootHeight;
@property(nonatomic,strong) UIColor *formHeadBackGround;
@property(nonatomic,strong) UIColor *formFootBackGround;
@property(nonatomic,  copy) NSString *formSectionKey;
@property(nonatomic,strong) id formCellName;
@property(nonatomic,strong) NSDictionary* formSectionInfo;
@property(nonatomic,assign) BOOL formShowLine;
@property(nonatomic,assign) UITableViewCellAccessoryType formAccessoryType;
@property(nonatomic,assign) CGFloat formCellHeight;
@property(nonatomic,  copy) FormCustomLabel formCustomNameLabel;
@property(nonatomic,  copy) FormCustomLabel formCustomDetailLabel;
@property(nonatomic,  copy) FormCustomLabel formCustomWarnLabel;
@property(nonatomic,  copy) FormCustomView formCustomLineView;
@property(nonatomic,  copy) FormCustomButton formCustomButton;
@property(nonatomic,  copy) FormCustomImageView formCustomImageView;
@property(nonatomic,  copy) FormCustomTextField formCustomInput;
@property(nonatomic,  copy) FormCustomTextView formCustomTextView;
@property(nonatomic,  copy) FormCustomSwitcher formCustomSwitch;

//特殊属性
//展开状态
@property(nonatomic,assign)BOOL open;
@property(nonatomic,assign) NSInteger  sectionIndex;
@end

NS_ASSUME_NONNULL_END
