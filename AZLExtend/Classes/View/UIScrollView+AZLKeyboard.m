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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(azl_keyboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
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

- (void)azl_keyboardDisappear:(NSNotification*)notification {
    if (self.contentOffset.y+self.bounds.size.height > self.contentSize.height) {
        [self setContentOffset:CGPointMake(0, self.contentSize.height-self.bounds.size.height) animated:YES];
    }
   
}

@end
