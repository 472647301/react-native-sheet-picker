/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNWPicker.h"

#import <React/RCTConvert.h>

@interface RNWPicker() <UIPickerViewDataSource, UIPickerViewDelegate>
@end

@implementation RNWPicker

- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
    self.delegate = self;
    self.dataSource = self;
    [self selectRow:0 inComponent:0 animated:YES]; // Workaround for missing selection indicator lines (see https://stackoverflow.com/questions/39564660/uipickerview-selection-indicator-not-visible-in-ios10)
  }
  return self;
}

- (UIColor *)colorWithHexString:(NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
 
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

RCT_NOT_IMPLEMENTED(- (instancetype)initWithCoder:(NSCoder *)aDecoder)

- (void)setData:(NSArray<NSDictionary *> *)data {
    _data = data;
    [self setNeedsLayout];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    dispatch_async(dispatch_get_main_queue(), ^{
      [self selectRow:index inComponent:0 animated:NO];
    });
}

- (void)setColor:(NSString *)color {
    _color = color;
}

- (void)setSelectedColor:(NSString *)selectedColor {
    _selectedColor = selectedColor;
}

- (void)setFontSize:(NSInteger)fontSize {
    _fontSize = fontSize;
}

- (void)setLineSpacing:(NSInteger)lineSpacing {
    _lineSpacing = lineSpacing;
}

- (UILabel *)createUILabel:(CGRect)rect row:(NSInteger)row {
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    
    NSString *text = _data[row][@"label"];
    
    label.font = [UIFont systemFontOfSize:_fontSize];
    
    if (row == _index) {
        label.textColor = [self colorWithHexString:_selectedColor];
    } else {
        label.textColor = [self colorWithHexString:_color];
    }
    
    NSMutableParagraphStyle *attrStyle = [NSMutableParagraphStyle new];
    attrStyle.lineSpacing = _lineSpacing;
    attrStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:text];
    [attrString addAttribute:NSParagraphStyleAttributeName value:attrStyle range:NSMakeRange(0, text.length)];
    label.attributedText = attrString;
    
    label.numberOfLines = 1;
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

#pragma mark - UIPickerViewDataSource protocol

- (NSInteger)numberOfComponentsInPickerView:(__unused UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _data.count;
}

#pragma mark - UIPickerViewDelegate methods

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = (id)view;
    if (!label) {
        CGRect rect = (CGRect){
            CGPointZero,
            {
              [pickerView rowSizeForComponent:component].width,
              [pickerView rowSizeForComponent:component].height,
            }
        };
        label = [self createUILabel:rect row:row];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_index == row) return;
    _index = row;
    UILabel *labelSelected = (UILabel*)[pickerView viewForRow:row forComponent:component];
    [labelSelected setTextColor:[self colorWithHexString:_selectedColor]];
    if (_onChangeIndex) _onChangeIndex(@{@"index": @(row)});
}

@end
