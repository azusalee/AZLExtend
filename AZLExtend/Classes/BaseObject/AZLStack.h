//
//  AZLStack.h
//  AZLExtend_Example
//
//  Created by lizihong on 2021/4/30.
//  Copyright © 2021 azusalee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 堆栈结构对象(利用链表实现)
@interface AZLStack : NSObject

/// 压入一个对象
- (void)pushObject:(id)obj;
/// 弹出一个对象
- (nullable id)popObject;

@end

NS_ASSUME_NONNULL_END
