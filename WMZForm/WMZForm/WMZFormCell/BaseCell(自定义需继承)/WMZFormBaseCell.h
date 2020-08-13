//
//  WMZFormBaseCell.h
//  WMZForm
//
//  Created by wmz on 2020/2/20.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormRowModel.h"
#import "WMZFormSectionModel.h"
#import "WMZFormBtn.h"
#import "UIImageView+WebCache.h"
#import "WMZFormCellDelegate.h"
#import "WMZFormTool.h"
#import "WMZFormPhotoFunction.h"
#import "UIImage+imageNameWithBundle.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZFormBaseCell : UITableViewCell<UITextFieldDelegate,WMZFormCellDelegate>
@property(nonatomic,strong)UIView *BgView;
@property(nonatomic,strong)UILabel *nameLa;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *detailLa;
@property(nonatomic,strong)UILabel *warningLabel;
@property(nonatomic,strong)WMZFormBtn *btn;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)WMZFormRowModel *model;
@property(nonatomic,  weak)id<WMZFormCellDelegate> formDelagate;
@property(nonatomic,strong)WMZFormPhotoFunction *tool;
//正则对应的规则
@property(nonatomic,strong)NSMutableDictionary *regularDic;
//刷新当前tableView
- (UITableView*)getMytableView;
//刷新当前cell
- (void)tableViewUpdate;
//图片赋值
- (void)setShowImage:(UIImageView *)imageView withData:(id)image key:(NSString*)key;
- (void)setShowImage:(UIImageView *)imageView withData:(id)image key:(NSString*)key placeholderImage:(UIImage*)placeholderImage;
//设置阴影圆角
- (void)setBgView:(UIView*)view cornerRadius:(CGFloat)cornerRadius shadowRadius:(CGFloat)shadowRadius;
- (void)UI;
//设置富文本
- (void)attributedTextWithInfo:(NSDictionary*)info label:(UILabel*)la text:(NSString*)text;
@end
NS_ASSUME_NONNULL_END
