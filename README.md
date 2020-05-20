# WMZForm
先看看效果吧
| 实现页面                | 图片                       |
|-----------------------|-----------------------------------------------------|
| 单纯表单页面(可各种配置调样式)               | ![单纯表单.gif](https://upload-images.jianshu.io/upload_images/9163368-7ec31dc28be50359.gif?imageMogr2/auto-orient/strip)|
| 实现的一个简单朋友圈              | ![朋友圈.gif](https://upload-images.jianshu.io/upload_images/9163368-a9f7b2803a7ea8cd.gif?imageMogr2/auto-orient/strip)|
| 简单实现一些设置的界面              | ![设置.gif](https://upload-images.jianshu.io/upload_images/9163368-ac0e739822a16515.gif?imageMogr2/auto-orient/strip)|
| 所有属性的页面-比较多比较杂乱              | ![所有属性.gif](https://upload-images.jianshu.io/upload_images/9163368-535ae0912b320ca6.gif?imageMogr2/auto-orient/strip)|

##  简单一句话概括这个控件 - 表单~不止于表单
### 特效
- 支持可自定义cell,cell需要继承于baseCell
- 支持实现目前大多数表单的功能
- 支持自定义选择弹窗的内容
- 性能优化,高度缓存
- 可链式可属性轻松调用
- 可自定义cell上的ui控件
- 可自定义无数据占位图

### 目前自带的样式介绍

 -   FormCellDefault       ~ 默认样式
   - FormCellNormal       ~ 左右文本
 -   FormCellIcon            ~ 带图片+文本
-    FormCellInput           ~  单行输入框
 -   FormCellText            ~  只有一个文本
-    FormCellTextView    ~  多行输入
 -   FormCellVerification ~ 验证码输入
-    FormCellImage         ~ 九宫格选择/显示图片
-    FormCellSwitch        ~ 开关
-    FormCellCheck         ~ 选择
-    FormCellTag             ~ 标签
 -   FormCellCommit      ~ 按钮
-    FormCellEdit            ~ 编辑
-    FormCellTakePicture~ 添加图片



## 用法介绍
### 初始化添加数据 - 属性有点多这里没法一次性说清 详情可以看demo 或者来问我
```
    //初始化
     WMZForm *form =
     Form(CGRectMake(0, NavigationBar_Form_Height, self.view.bounds.size.width , self.view.bounds.size.height - NavigationBar_Form_Height))

    //直接不带section 用row直接添加
    .wAddFormRow(^(WMZFormRowModel * _Nullable rowModel) {
        rowModel
        .wFormValue(@"AllPropertiesVC")
        .wFormName(@"全部属性demo")
        .wFormCellAccessoryType(UITableViewCellAccessoryDisclosureIndicator)
        .wFormShowLine(YES);
    });

    //直接section添加 WMZFormRowModel为子集
    .wAddFormSection(^(WMZFormSectionModel * _Nullable sectionModel) {
          //子集
          WMZFormRowModel *rowModel =
          FormRowModel()
          //tableviewCell的类名 自定义的时候传@"customCellName"你创建的cell的类名即可
          .wFormCellName(@(FormCellCommit))
          .wFormRowData(@{@"fill":@(YES),@"type":@(FormClickClick)})
           //自定义button
          .wFormCustomButton(^(UIButton * _Nullable button) {
              button.backgroundColor = [UIColor whiteColor];
              [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
          })
          .wFormBtn(@"退出");
        
          sectionModel
          .wFormHeadHeight(20)
          .wFormFootHeight(20)
           //添加section的数据 rowModel组成的数据
          .wFormSectionData(@[rowModel])
          .wFormCellName(@(FormCellTag));
    });
```
### 直接添加也可以
```
 //添加row
 [form wAddFormRow:addModel atIndex:0];
//添加section
 [form wAddFormSection:sectionModel atIndex:1];
```

### 代理方法
```
/*
 *formCell点击
 @param cell  所在的cell (cell.model为model cell.indexPath 为其所在的indexPath)
 */
- (void)form:(WMZForm*)form didSelectRowAtCell:(WMZFormBaseCell*)cell;

/*
 *form提交
 @param commitInfo  提交的信息 为一个带value和key的字典
 @param success  是否通过检验规则可以提交
 */
- (void)form:(WMZForm*)form info:(NSDictionary*)commitInfo canCommit:(BOOL)success;

/*
 *formCell上的view点击 用于cell上的控件的交互事件
 @param clickView  点击的view
 @param cell  所在的cell
 @param action  根据action判断交互的事件
 */
- (void)form:(WMZForm*)form
        subViewDidSelectRowAtCell:(WMZFormBaseCell*)cell
        view:(UIView*)clickView
        type:(id)action;
```

### 数据更新删除等 提供了多个实例方法
```
 //addRow 非初始化增加row调用 默认插入最后
- (BOOL)wAddFormRow:(WMZFormRowModel*)rowModel;
//addRow 非初始化增加row调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormRow:(WMZFormRowModel*)rowModel atIndex:(NSInteger)index;
//addRow 非初始化增加row调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormRowBlock:(FormRowBlock)addFormRow atIndex:(NSInteger)index;
//addSection 非初始化增加section调用 默认插入最后
- (BOOL)wAddFormSection:(WMZFormSectionModel*)sectionModel;
//addSection 非初始化增加section调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormSection:(WMZFormSectionModel*)sectionModel atIndex:(NSInteger)index;
//addSection 非初始化增加section调用 插入index的位置 传入-1不刷新
- (BOOL)wAddFormSectionBlock:(FormSectionBlock)addFormSection atIndex:(NSInteger)index;
//deleleSectionWithKey
- (BOOL)wDeleteFormSectionWithKey:(NSString*)key;
//deleleSectionWithKey
- (BOOL)wDeleteFormSectionWithIndex:(NSInteger)index;
//deleleRowWithKey
- (BOOL)wDeleteFormRowWithKey:(NSString*)key;
//deleleRowWithIndexPath
- (BOOL)wDeleteFormRowWithIndexPath:(NSIndexPath*)indexPath;
//reloadRow With key
- (BOOL)wReloadRowWithKey:(NSString*)key;
//reloadRow With indexPath
- (BOOL)wReloadRowWithIndexPath:(NSIndexPath*)indexPath;
//reloadSection With key
- (BOOL)wReloadSectionWithKey:(NSString*)key;
//reloadSection With index
- (BOOL)wReloadSectionWithIndex:(NSInteger)index;
//getRow With key
- (WMZFormRowModel*)wFindRowModelWithKey:(NSString*)key;
//getRow With indexPath
- (WMZFormRowModel*)wFindRowModelWithIndexPath:(NSIndexPath*)indexPath;
//getSection With key
- (WMZFormSectionModel*)wFindSectionModelWithKey:(NSString*)key;
//getSection With index
- (WMZFormSectionModel*)wFindSectionModelWithIndex:(NSInteger)index;
//reloadData
- (void)wReloadData;
//自定义刷新
- (void)wReloadData:(FormCustomReload)block;

```
安装
==============

### CocoaPods
1. 将 cocoapods 更新至最新版本.
2. 在 Podfile 中添加 `pod 'WMZForm'`。
3. 执行 `pod install` 或 `pod update`。
4. 导入 #import "WMZForm.h"。

### 注:要消除链式编程的警告 
要在Buildding Settings 把CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF 设为NO

### 手动安装
1. 下载 WMZForm 文件夹内的所有内容。
2. 将 WMZForm 内的源文件和依赖的库添加(拖放)到你的工程。
3. 导入 #import "WMZForm.h"

### 依赖
1WMZDialog（弹窗控件）
2 Masonry
3 SDWebImage
4 IQKeyboardManager 

使用过程中如果有什么bug欢迎给我提issue 我看到就会解决
觉得有用的话给个star

 [简书地址](https://www.jianshu.com/p/fb3c85f71924)

