//
//  WMZFormRowModel.h
//  WMZForm
//
//  Created by wmz on 2020/4/18.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormMacro.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZFormRowModel : NSObject

WMZFormRowModel * FormRowModel(void);

//唯一id default @""
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormKey)          (NSString* formKey);
//id对应的value default -
@property(nonatomic,strong,readonly) WMZFormRowModel *(^wFormValue)        (id formValue);
//name 赋值
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormName)         (NSString* formName);
//detail 赋值
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormDetail)       (NSString* formDetail);
//warn 赋值
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormWarn)         (NSString* formWarn);
//imageView 赋值
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormIcon)         (NSString* formIcon);
//button 赋值
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormBtn)          (NSString* formBtn);
//time 赋值
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormTime)         (NSInteger formTime);

/*
Example-FormCellIcon/FormCellText
@{@"showAllText":@(YES)}展示全文
 
Example-FormCellInput
@{@"maxNum":@(100), 最大长度
   @"regular":@(type) / @"regular":@"customRegular",  正则规则
   @"ruleTip":@"自定义提示"}
 
Example-FormCellTextView
@{@"maxNum":@(100), 最大长度
  @"placeholder":"placeholder" }
 
Example-FormCellImage
@{@"insert":@(YES), 可添加图片
  @"deleteIcon":@"" 自定义删除的图片
  @"insertIcon":@"" 自定义增加的图片
  @"delete":@"YES"  可删除图片
  @"width":@(100)   整体宽度
  @"left":@(100)    整体左边距
  @"top":@(100)     整体上边距
  @"maxCount" :@(3) 最多显示图片的数量 默认9
  @"imageWidth":@(100)  图片宽度
 }
Example-FormCellTag
@{@"moreSelect":@(YES)} 多选
*/
@property(nonatomic,strong,readonly) WMZFormRowModel *(^wFormRowData)      (id formRowData);
//selectInfo 弹窗的info 设置此属性则使用系统的弹窗 不设置则使用自定义的弹窗
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
@property(nonatomic,strong,readonly) WMZFormRowModel *(^wFormSelectInfo)   (NSDictionary* formSelectInfo);
//inputCell open Rule default NO
@property(nonatomic,assign,readonly) WMZFormRowModel *(^wFormOpenRule)     (BOOL formOpenRule);
//value required  default YES
@property(nonatomic,assign,readonly) WMZFormRowModel *(^wFormRequired)     (BOOL formRequired);
//cellName  default FIFormBaseCell
@property(nonatomic,strong,readonly) WMZFormRowModel *(^wFormCellName)     (id formCellName);
//showLine default NO
@property(nonatomic,assign,readonly) WMZFormRowModel *(^wFormShowLine)     (BOOL formShowLine);
//editingStyle
@property(nonatomic,assign,readonly) WMZFormRowModel *(^wFormEditingStyle) (UITableViewCellEditingStyle formEditingStyle);
//cellHeight defalt UITableViewAutomaticDimension
@property(nonatomic,assign,readonly) WMZFormRowModel *(^wFormCellHeight)   (CGFloat formCellHeight);
//cellAccessoryType default  UITableViewCellAccessoryNone
@property(nonatomic,assign,readonly) WMZFormRowModel *(^wFormCellAccessoryType)(UITableViewCellAccessoryType formAccessoryType);
//ellSelectionStyle default  UITableViewCellSelectionStyleNone
@property(nonatomic,assign,readonly) WMZFormRowModel *(^wFormSelectionStyle)(UITableViewCellSelectionStyle formSelectionStyle);
//cell backGroundColor
@property(nonatomic,strong,readonly) WMZFormRowModel *(^wFormCellBackGround) (UIColor* formCellBackGround);
//showLine default NO
//[cell subViews] click block
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormClickBlock)      (FormCellViewClickBlock formClickBlock);
//value change
@property(nonatomic,copy,readonly)WMZFormRowModel *(^wFormValueChangeBlock) (FormValueChangeBlock formValueChangeBlock);
//custom nameLabel default nil
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormCustomNameLabel) (FormCustomLabel formCustomNameLabel);
//custom detailLabel default nil
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormCustomDetailLabel)(FormCustomLabel formCustomDetailLabel);
//custom valueLabel default nil
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormCustomValueLabel)(FormCustomLabel formCustomValueLabel);
//custom nameLabel default nil
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormCustomWarnLabel)  (FormCustomLabel formCustomWarnLabel);
//custom line default nil
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormCustomLineView)   (FormCustomView formCustomLineView);
//custom button default nil
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormCustomButton)     (FormCustomButton formCustomButton);
//custom imageView default nil
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormCustomImageView)  (FormCustomImageView formCustomImageView);
//custom textFiled default nil
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormCustomInput)      (FormCustomTextField formCustomInput);
//custom textView default nil
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormCustomTextView)   (FormCustomTextView formCustomTextView);
//custom switch default nil
@property(nonatomic,copy,readonly) WMZFormRowModel *(^wFormCustomSwitch)     (FormCustomSwitcher formCustomSwitch);


//实例链式属性 调用此属性也一样
@property(nonatomic,  copy) NSString* formKey;
@property(nonatomic,strong) id formValue;
@property(nonatomic , copy) NSString* formName;
@property(nonatomic,  copy) NSString* formDetail;
@property(nonatomic,  copy) NSString* formWarn;
@property(nonatomic,  copy) NSString* formIcon;
@property(nonatomic,  copy) NSString* formBtn;
@property(nonatomic,assign) NSInteger formTime;
@property(nonatomic,assign) CGFloat formWidth;
@property(nonatomic,strong) UIColor* formCellBackGround;
@property(nonatomic,strong) id formRowData;
@property(nonatomic,strong) id formCellName;
@property(nonatomic,assign) BOOL formOpenRule;
@property(nonatomic,assign) BOOL formRequired;
@property(nonatomic,assign) UITableViewCellEditingStyle formEditingStyle;
@property(nonatomic,assign) BOOL formShowLine;
@property(nonatomic,assign) UITableViewCellAccessoryType formAccessoryType;
@property(nonatomic,assign) UITableViewCellSelectionStyle formSelectionStyle;
@property(nonatomic,assign) CGFloat formCellHeight;
@property(nonatomic,  copy) FormCellViewClickBlock formClickBlock;
@property(nonatomic,  copy) FormValueChangeBlock formValueChangeBlock;
@property(nonatomic,  copy) FormCustomLabel formCustomNameLabel;
@property(nonatomic,  copy) FormCustomLabel formCustomDetailLabel;
@property(nonatomic,  copy) FormCustomLabel formCustomValueLabel;
@property(nonatomic,  copy) FormCustomLabel formCustomWarnLabel;
@property(nonatomic,  copy) FormCustomView formCustomLineView;
@property(nonatomic,  copy) FormCustomButton formCustomButton;
@property(nonatomic,  copy) FormCustomImageView formCustomImageView;
@property(nonatomic,  copy) FormCustomTextField formCustomInput;
@property(nonatomic,  copy) FormCustomTextView formCustomTextView;
@property(nonatomic,  copy) FormCustomSwitcher formCustomSwitch;
@property(nonatomic,  copy) NSDictionary* formSelectInfo;
@property(nonatomic,strong) NSIndexPath *indexPath;



//自定义属性
@property(nonatomic,assign) BOOL isSelected;
@property(nonatomic,assign) BOOL passRule;
@property(nonatomic,assign) BOOL changeHeight;
@property(nonatomic,assign) CGFloat oneLineHeight;
@property(nonatomic,assign) CGFloat maxLineHeight;
@property(nonatomic,assign) CGRect rect;
@property(nonatomic,  copy) NSString* showContent;
@property(nonatomic,assign) NSInteger second;
@property(nonatomic,strong,nullable) NSTimer *timer;
@property(nonatomic,strong) id selectModel;
@property(nonatomic,assign) BOOL valueChangeBlock;

@property(nonatomic,strong,nullable)UIImage *addImage;
@property(nonatomic,strong,nullable)UIImage *deleteImage;
@property(nonatomic,assign)NSInteger deleteIndex;
@property(nonatomic,assign)NSInteger addIndex;
@end

NS_ASSUME_NONNULL_END
