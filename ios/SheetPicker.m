// SheetPicker.m
#import "RNWPicker.h"
#import "SheetPicker.h"

@implementation ByronSheetPicker

RCT_EXPORT_MODULE()

-(UIView *)view {
  return [RNWPicker new];
}

RCT_EXPORT_VIEW_PROPERTY(data, NSArray<NSDictionary *>)
RCT_EXPORT_VIEW_PROPERTY(index, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(onChangeIndex, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(color, NSString)
RCT_EXPORT_VIEW_PROPERTY(fontSize, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(lineSpacing, NSInteger)
RCT_EXPORT_VIEW_PROPERTY(selectedColor, NSString)

@end
