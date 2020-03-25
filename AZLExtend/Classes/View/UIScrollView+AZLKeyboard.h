//
//  UIScrollView+AZLKeyboard.h
//  AZLExtend
//
//  Created by lizihong on 2020/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (AZLKeyboard)

/// 添加键盘监听，自动根据键盘调整offset (viewWillAppear里调用)
- (void)azl_addKeyboardNotification;
/// 移除键盘监听 (viewWillDisappear里调用)
- (void)azl_removeKeyboardNotification;


@end

NS_ASSUME_NONNULL_END
