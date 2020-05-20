//
//  WMZFormTextCell.m
//  WMZForm
//
//  Created by wmz on 2020/4/23.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZFormTextCell.h"
#import <CoreText/CoreText.h>
@implementation WMZFormTextCell
- (void)UI{
    self.nameLa = [UILabel new];
    [self.contentView addSubview:self.nameLa];

    [self.contentView addSubview:self.allTextLa];
    self.allTextLa.userInteractionEnabled = YES;
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allText:)];
    [self.allTextLa addGestureRecognizer:ta];
}
- (void)setModel:(WMZFormRowModel *)model{
    [super setModel:model];
    CGFloat left = model.formRowData[@"left"]?[model.formRowData[@"left"] floatValue]:FormXOffset;
    CGFloat right = model.formRowData[@"right"]?[model.formRowData[@"right"] floatValue]:FormXOffset;
    CGFloat top = model.formRowData[@"top"]?[model.formRowData[@"top"] floatValue]:5;
    CGFloat width = model.formWidth - left - right;
    CGFloat height = 20;
    self.nameLa.numberOfLines = 0;
    self.nameLa.text = model.formName?:@" ";
    if (!model.oneLineHeight) {
        model.oneLineHeight = [WMZFormTool heightForTextView:CGSizeMake(width, CGFLOAT_MAX) WithText:@"测试" WithFont:self.nameLa.font.pointSize];
    }
    if (!model.maxLineHeight) {
        model.maxLineHeight = [WMZFormTool heightForTextView:CGSizeMake(width, CGFLOAT_MAX) WithText:model.formName WithFont:self.nameLa.font.pointSize];
        
    }
    BOOL show = model.formRowData[@"showAllText"]?YES:NO;
    NSInteger minLine = model.formRowData[@"minLines"]?[model.formRowData[@"minLines"] intValue]:FormMinLines;
    self.nameLa.numberOfLines = show?(model.isSelected?0:minLine):0;
    if (show) {
        if (model.isSelected) {
            height = model.maxLineHeight;
        }else{
            if (model.oneLineHeight*minLine>=model.maxLineHeight) {
                height = model.maxLineHeight;
                show = NO;
            }else{
                height = (model.oneLineHeight*minLine);
            }
        }
    }else{
        height = model.maxLineHeight;
    }
    
    self.nameLa.frame = CGRectMake(left, top, model.formWidth - left - right, height);
    if (CGRectEqualToRect(self.model.rect,CGRectNull)&&show) {
        NSArray * arr = [self getSeparatedLinesFromLabel:self.nameLa];
        NSInteger num = show?(model.isSelected?(arr.count-1):(minLine-1)):(arr.count-1);
        if (num>(arr.count-1)) {
            num = arr.count - 1;
        }
        NSString *str = [[arr objectAtIndex:num] stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        self.model.rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.nameLa.font.pointSize]} context:nil];
    }
    self.allTextLa.text =  show?(model.isSelected?@"收起":@"全文"):@"";
    if (show) {
        if ((self.model.rect.size.width+30)>width) {
            self.allTextLa.frame = CGRectMake(left, CGRectGetMaxY(self.nameLa.frame), 50, self.model.rect.size.height);
        }else{
            self.allTextLa.frame = CGRectMake(self.model.rect.size.width+30, CGRectGetMaxY(self.nameLa.frame)- self.model.rect.size.height, 50, self.model.rect.size.height);
        }
        model.formCellHeight = CGRectGetMaxY(self.allTextLa.frame)+top;
    }else{
        model.formCellHeight = CGRectGetMaxY(self.nameLa.frame)+top;
    }
}

- (void)allText:(UITapGestureRecognizer*)ta{
    if (!self.model.formRowData[@"showAllText"]) return;
    self.model.isSelected = !self.model.isSelected;
    self.allTextLa.text =  self.model.isSelected?@"收起":@"全文";
    self.model.rect = CGRectNull;
    UITableView *tableView = [self getMytableView];
    [UIView setAnimationsEnabled:NO];
    [tableView reloadData];
    [UIView setAnimationsEnabled:YES];
}

- (UILabel *)allTextLa{
    if (!_allTextLa) {
        _allTextLa = [UILabel new];
        _allTextLa.textColor = FormAllTextColor;
    }
    return _allTextLa;
}
-(NSArray *)getSeparatedLinesFromLabel:(UILabel *)label
{
    NSString *text = [label text];
    UIFont   *font = [label font];
    CGRect    rect = [label frame];
    CFStringRef yourFriendlyCFString = (__bridge CFStringRef)@"";
    CTFontRef myFont = CTFontCreateWithName(yourFriendlyCFString, [font pointSize], NULL);

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}
@end
