//
//  UIScrollView+AZLKeyboard.m
//  AZLExtend
//
//  Created by lizihong on 2020/3/25.
//

#import "UIScrollView+AZLKeyboard.h"
#import "UIView+AZLExtend.h"


@implementation UIScrollView (AZLKeyboard)

- (void)azl_addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(azl_keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)azl_removeKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)azl_keyboardWillAppear:(NSNotification*)notification {
    UIView *resopnseView = [self azl_getResponseView];
    if (resopnseView) {
        CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect responseRect = [resopnseView convertRect:resopnseView.frame toView:[UIApplication sharedApplication].keyWindow];
        CGFloat responseBottomInScrollView = responseRect.origin.y+responseRect.size.height+10;
        CGFloat moveOffset = responseBottomInScrollView-keyboardRect.origin.y;
        if (moveOffset > 0) {
            CGPoint targetOffset = self.contentOffset;
            targetOffset.y += moveOffset;
            [self setContentOffset:targetOffset animated:YES];
        }
    }
}

@end
