//
//  WMZFormMacro.h
//  WMZForm
//
//  Created by wmz on 2020/2/20.
//  Copyright © 2020 wmz. All rights reserved.
//

#ifndef WMZFormMacro_h
#define WMZFormMacro_h
#import "IQKeyboardManager.h"
#import "Masonry.h"
#import "WMZDialog.h"
@class WMZFormBaseCell,WMZFormRowModel,WMZFormTableView,WMZFormSectionModel;
#define FormIsIphoneX ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
if ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0) {\
isPhoneX = YES;\
}\
}\
isPhoneX;\
})

#define Device_Form_Height [UIScreen mainScreen].bounds.size.height
#define Device_Form_Width  [UIScreen mainScreen].bounds.size.width
#define NavigationBar_Form_Height (([[UIApplication sharedApplication] statusBarFrame].size.height) + 44)
#define Form_GetWNum(A)   (A)/2.0*(Device_Form_Width/375)
#define FormColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define FormK1px (1 / UIScreen.mainScreen.scale)

//底部标签栏高度
#define FormTabBarHeight (FormIsIphoneX ? (49.f+34.f) : 49.f)
#define FormWeakSelf(obj) __weak typeof(obj) weakObject = obj;
#define FormStrongSelf(obj) __strong typeof(obj) strongObject = weakObject;

#define FormXOffset Form_GetWNum(30)
#define FormYOffset Form_GetWNum(25)

#define FormDefaultImageSize CGSizeMake(Form_GetWNum(80),Form_GetWNum(80))

#define FormDefaultNameColor  FormColor(0X111A34)
#define FormDefaultDetailColor  FormColor(0X989CA8)
#define FormDefaultLineColor  FormColor(0xE8E8E8)
#define FormDefaultNameFont  15.0f
#define FormDefaultDetailFont  14.0f

#define FormDefaultWarnColor  [UIColor redColor]
#define FormDefaultWarnFont  13.0f

#define FormDefaulTextViewMaxHeight   Form_GetWNum(200)
#define FormDefaulTextViewMinHeight   Form_GetWNum(150)
#define FormDefaulTextViewMaxWidth    Form_GetWNum(200)

#define FormTextMinWidth 0.01

#define FormDefaultBtnBgColor FormColor(0x024596)
#define FormDefaultBtnColor  FormColor(0Xffffff)
#define FormDefaultBtnSize  CGSizeMake(Form_GetWNum(160),Form_GetWNum(60))
#define FormDefaultBtnFont 13.0f

#define FormDefaultCheckSize CGSizeMake(Form_GetWNum(40),Form_GetWNum(40))

#define FormDefaulCollectionMaxHeight  Form_GetWNum(180)
#define FormDefaulCollectionMinHeight  Form_GetWNum(120)

#define FormDefaultCodeBackground FormColor(0x108ee9)
#define FormDefaultCodeSelectBackground FormColor(0xffffff)

#define FormDefaulICCardHeight   Form_GetWNum(250)

#define FormMaxCount 9
#define FormImageOffset 10

#define FormMinLines 4

#define SwitchTintColor FormColor(0x666666)

#define FormConfirmHeight Form_GetWNum(88)

#define FormAllTextColor FormColor(0x5bc3e6)

#define FormBgColor FormColor(0xF9F9F9)
#define FormHeadViewBgColor FormColor(0xF9F9F9)
#define FormFootViewBgColor FormColor(0xF9F9F9)
static NSString * _Nullable const FormDefaultPlaceholder =  @"请输入";
static NSString * _Nullable const FormCheckDefaultSelectIcon  = @"form_check";
static NSString * _Nullable const FormCheckDefaultIcon = @"form_notCheck";

//cell样式
typedef enum :NSInteger{
   FormCellDefault,
   FormCellNormal,
   FormCellIcon,
   FormCellInput,
   FormCellText,
   FormCellTextView,
   FormCellVerification,
   FormCellImage,
   FormCellSwitch,
   FormCellCheck,
   FormCellTag,
   FormCellCommit,
   FormCellEdit,
   FormCellTakePicture,
}FormCellType;

//常用正则表达式
typedef enum :NSInteger{
   FormRegularMobile = 1, //手机号码
   FormRegularIdCard,     //身份证
   FormRegularMoney,      //钱的输入格式
   FormRegularCar,        //车牌
}FormRegularType;


//点击按钮
typedef enum :NSInteger{
   FormClickCommit = 1,   //提交表单
   FormClickClick,        //点击操作
   FormVerficationClick,  //验证码点击
   FormEditTextField ,    //修改输入框内容
   FormEditImage,         //修改图片
}FormClickType;


//点击按钮
typedef enum :NSInteger{
   FormCellTypeSelect,         //普通选择
   FormCellTypeSelectPush,     //跳转选择列表
   FormCellTypeLocation ,      //选择地区
   FormCellTypeDate,           //选择日期
   FormCellTypeCalander,       //选择日历
}FormCellClickType;

typedef enum :NSInteger{
   FormFindRowTypeKey ,
   FormFindRowTypeIndexPath,
   FormFindRowTypeIndex,
}FormFindRowType;

typedef enum :NSInteger{
   FormRowActionDelete ,
   FormRowActionReload,
   FormRowActionFind,
}FormRowActionType;

typedef void (^FormCustomLabel)          (UILabel * _Nullable label);
typedef void (^FormCustomView)           (UIView *_Nullable view);
typedef void (^FormCustomButton)         (UIButton *_Nullable button);
typedef void (^FormCustomTextField)      (UITextField *_Nullable textField);
typedef void (^FormCustomSlider)         (UISlider *_Nullable slider);
typedef void (^FormCustomSwitcher)       (UISwitch *_Nullable switcher);
typedef void (^FormCustomTextView)       (UITextView *_Nullable textView);
typedef void (^FormCustomImageView)      (UIImageView *_Nullable imageView);
typedef void (^FormCustomProgressView)   (UIProgressView *_Nullable progressView);
typedef void (^FormCustomScrollView)     (UIScrollView *_Nullable scrollView);
typedef void (^FormCustomTableView)      (UITableView *_Nullable tableView);
typedef void (^FormCustomCollectionView) (UICollectionView *_Nullable collectionView);

typedef void (^FormSelectInfoBlock)      (id _Nullable anyId);
typedef void (^FormCellViewClickBlock)   (WMZFormBaseCell * _Nullable cell,id _Nonnull action);
typedef void (^FormValueChangeBlock)     (WMZFormRowModel * _Nullable model);

typedef void (^FormSectionBlock) (WMZFormSectionModel *_Nullable sectionModel);
typedef void (^FormRowBlock) (WMZFormRowModel *_Nullable rowModel);
typedef void (^FormCustomReload) (WMZFormTableView *_Nullable tableView);

typedef void(^FormConstraint) (MASConstraintMaker *make);
#endif /* WMZFormMacro_h */
