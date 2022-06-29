/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface RNWPicker : UIPickerView

@property (nonatomic, copy) NSArray<NSDictionary *> *data;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSString *color;
@property (nonatomic, assign) NSString *selectedColor;
@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, assign) NSInteger lineSpacing;
@property (nonatomic, copy) RCTDirectEventBlock onChangeIndex;

@end
