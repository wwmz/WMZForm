//
//  WMZFormBaseCell.m
//  WMZForm
//
//  Created by wmz on 2020/2/20.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormBaseCell.h"
@implementation WMZFormBaseCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self UI];
    }
    return self;
}
- (void)UI{}
//可继承去重写
- (void)setModel:(WMZFormRowModel *)model{
    _model = model;
    self.accessoryType = model.formAccessoryType == -1 ? UITableViewCellAccessoryNone:model.formAccessoryType;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.nameLa) {
        if (model.formCustomNameLabel) {
            model.formCustomNameLabel(self.nameLa);
        }else{
            self.nameLa.textColor = FormDefaultNameColor;
            self.nameLa.font = [UIFont systemFontOfSize:FormDefaultNameFont];
            self.nameLa.textAlignment = NSTextAlignmentLeft;
            self.nameLa.numberOfLines = 1;
            self.nameLa.backgroundColor = [UIColor clearColor];
            self.nameLa.layer.masksToBounds = NO;
            self.nameLa.layer.borderWidth = 0;
        }
        NSMutableAttributedString *mStr = nil;;
        if (model.formRequired) {
            NSString *formName = model.formName?[NSString stringWithFormat:@"* %@",model.formName]:@"";
            mStr =  [[NSMutableAttributedString alloc] initWithString:formName];
            [mStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[formName rangeOfString:@"*"]];
        }else{
            mStr =  [[NSMutableAttributedString alloc] initWithString:model.formName?:@""];
        }
        self.nameLa.attributedText = mStr;
    }
    
    if (self.detailLa) {
        if (model.formCustomDetailLabel) {
            model.formCustomDetailLabel(self.detailLa);
        }else{
            self.detailLa.textColor = FormDefaultDetailColor;
            self.detailLa.numberOfLines = 0;
            self.detailLa.font = [UIFont systemFontOfSize:FormDefaultDetailFont];
            self.detailLa.backgroundColor = [UIColor clearColor];
            self.detailLa.layer.masksToBounds = NO;
            self.detailLa.layer.borderWidth = 0;
            if ([model.formCellName isKindOfClass:[NSString class]]) {
               self.detailLa.textAlignment = [model.formCellName isEqualToString:@"WMZFormBaseCell"]?NSTextAlignmentRight:NSTextAlignmentLeft;
            }else if ([model.formCellName isKindOfClass:[NSNumber class]]){
                self.detailLa.textAlignment = ([model.formCellName intValue] == FormCellDefault)||(([model.formCellName intValue] == -1))?NSTextAlignmentRight:NSTextAlignmentLeft;
            }
        }
        if ((([model.formCellName isKindOfClass:[NSString class]]&&
             [model.formCellName isEqualToString:@"WMZFormBaseCell"])||
            ([model.formCellName isKindOfClass:[NSNumber class]]&&
            [model.formCellName intValue] == -1)||
            ([model.formCellName isKindOfClass:[NSNumber class]]&&
            [model.formCellName intValue] == FormCellDefault)||
            ([model.formCellName isKindOfClass:[NSNumber class]]&&
            [model.formCellName intValue] == FormCellNormal))&&
            (model.formName&&[model.formName length])) {
            self.detailLa.text = model.formDetail?:@" ";
        }else{
            self.detailLa.text = model.formDetail?:@"";
        }
    }

    
    if (self.warningLabel) {
        if (model.formCustomWarnLabel) {
            model.formCustomWarnLabel(self.warningLabel);
        }else{
            self.warningLabel.textColor = FormDefaultWarnColor;
            self.warningLabel.font =  [UIFont systemFontOfSize:FormDefaultWarnFont];
            self.warningLabel.textAlignment = NSTextAlignmentLeft;
            self.warningLabel.backgroundColor = [UIColor clearColor];
            self.warningLabel.layer.masksToBounds = NO;
            self.warningLabel.layer.borderWidth = 0;
        }
        self.warningLabel.text = model.formWarn;
    }


    if (model.formCustomLineView) {
        model.formCustomLineView(self.lineView);
    }else{
        self.lineView.backgroundColor = FormDefaultLineColor;
    }
    
    if (self.btn) {
        if (model.formCustomButton) {
            model.formCustomButton(self.btn);
        }else{
            [self.btn setImage:[UIImage formBundleImage:@" "] forState:UIControlStateNormal];
            [self.btn setImage:[UIImage formBundleImage:@" "] forState:UIControlStateSelected];
            [self.btn setTitleColor:FormDefaultBtnColor forState:UIControlStateNormal];
            self.btn.layer.masksToBounds = NO;
            self.btn.layer.borderWidth = 0;
            self.btn.layer.cornerRadius = 0;
            self.btn.titleLabel.font = [UIFont systemFontOfSize:FormDefaultBtnFont];
        }
    }

    if (self.textField) {
        if (model.formCustomInput) {
            model.formCustomInput(self.textField);
        }else{
            self.textField.placeholder = FormDefaultPlaceholder;
            self.textField.textColor = FormDefaultDetailColor;
            self.textField.font =  [UIFont systemFontOfSize:FormDefaultDetailFont];
            self.textField.textAlignment = NSTextAlignmentRight;
            self.textField.keyboardType = UIKeyboardTypeDefault;
            self.textField.secureTextEntry = NO;
            self.textField.backgroundColor = [UIColor clearColor];
            self.textField.layer.masksToBounds = NO;
            self.textField.layer.borderWidth = 0;
            if (@available(iOS 10.0, *)) {
                self.textField.textContentType = UITextContentTypeTelephoneNumber;
            }
            self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
        self.textField.delegate = self;
        self.textField.text = (model.formValue&&[model.formValue isKindOfClass:[NSString class]])?model.formValue:@"";
    }
    self.lineView.hidden = !model.formShowLine;
    self.backgroundColor = model.formCellBackGround?:[UIColor whiteColor];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
   [self updateWarningLabelWithText:@""];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *mainText = @"";
    if ([string isEqual:@""]) {
        if (![textField.text isEqualToString:@""]) {
            mainText = [textField.text substringToIndex:[textField.text length] - 1];
        }else{
            mainText = textField.text;
        }
    }else{
        mainText = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    NSString *tip = @"";

    if (self.model.formOpenRule&&
        !self.model.isSelected&&
        [self.model.formCellName isKindOfClass:[NSNumber class]]&&
        [self.model.formCellName intValue] == FormCellVerification) {
        [self updateWarningLabelWithText:@"请先获取验证码"];
        return NO;
    }
    
    if (self.model.formOpenRule&&mainText&&mainText.length) {
        if ([self.model.formRowData isKindOfClass:[NSDictionary class]]) {
            id maxNum = self.model.formRowData[@"maxNum"];
            NSString *ruleTip = self.model.formRowData[@"ruleTip"];
            id regular = self.model.formRowData[@"regular"];
            if (maxNum) {
                if (mainText.length>[maxNum intValue]) {
                    tip = [NSString stringWithFormat:@"最长%d个字符",[maxNum intValue]];
                    [self updateWarningLabelWithText:tip];
                }
            }
            if ([regular isKindOfClass:[NSNumber class]]) {
                regular = self.regularDic[regular];
            }
            
            if (regular&&[regular isKindOfClass:[NSString class]]) {
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
                BOOL isMatch = [pred evaluateWithObject:mainText];
                if (!isMatch) {
                    tip = ruleTip?:(self.model.formName?[NSString stringWithFormat:@"请输入正确格式的%@",self.model.formName]:@"请输入正确的格式");
                }
            }
        }
    }
    self.model.formValue = mainText?:@"";
    [self updateWarningLabelWithText:tip];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (!textField.text.length) {
        [self updateWarningLabelWithText:self.model.formWarn?:[NSString stringWithFormat:@"%@不能为空",self.model.formName?:@""]];
    }
}
//显示提示文本
- (void)updateWarningLabelWithText:(NSString*)text{
    if (!self.model.formOpenRule) return;
    self.model.formWarn = text?:@"";
    self.model.passRule = self.model.formWarn.length;
    self.warningLabel.text = self.model.formWarn;
    [self tableViewUpdate];
}

- (void)setShowImage:(UIImageView *)imageView withData:(id)image key:(NSString*)key{
    if (!image) return;
    if ([image isKindOfClass:[NSString class]]&&[image length]) {
        if ([image hasPrefix:@"http"]) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:image]];
        }else{
            imageView.image = [UIImage formBundleImage:image];
        }
    }else if ([image isKindOfClass:[UIImage class]]){
        imageView.image = image;
    }else if ([image isKindOfClass:[NSDictionary class]]){
        imageView.image = [UIImage formBundleImage:image[@"image"]?:@" "];
    }
    
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = FormDefaultLineColor;
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return _lineView;
}
- (NSMutableDictionary *)regularDic{
    if (!_regularDic) {
        _regularDic = [NSMutableDictionary dictionaryWithDictionary:@{
             @(FormRegularCar):
                 @"([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}(([0-9]{5}[DF])|([DF]([A-HJ-NP-Z0-9])[0-9]{4})))|([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳]{1})",
             @(FormRegularMobile):@"^1+[3578]+\\d{9}",
             @(FormRegularIdCard):@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)",
             @(FormRegularMoney):@"^([0-9]+|[0-9]{1,3}(,[0-9]{3})*)(.[0-9]{1,2})?$",
        }];
    }
    return _regularDic;
}
- (WMZFormPhotoFunction *)tool{
    if (!_tool) {
        _tool = [WMZFormPhotoFunction shareInstance];
    }
    return _tool;
}
- (void)tableViewUpdate{
    UITableView *tableView = [self getMytableView];
    [UIView setAnimationsEnabled:NO];
    [tableView beginUpdates];
    [tableView endUpdates];
    [UIView setAnimationsEnabled:YES];
}
//获取当前tableview
- (UITableView*)getMytableView
{
    UIView *tableView = self.superview;
    while (![NSStringFromClass([tableView class]) isEqualToString:@"WMZFormTableView"]) {
        tableView = tableView.superview;
        break;
    }
    return (UITableView*)tableView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

