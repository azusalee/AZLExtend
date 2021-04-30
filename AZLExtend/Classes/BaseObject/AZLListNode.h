//
//  AZLListNode.h
//  AZLExtend_Example
//
//  Created by lizihong on 2021/4/30.
//  Copyright © 2021 azusalee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 链表
@interface AZLListNode : NSObject

@property (nonatomic, strong) AZLListNode *next;
@property (nonatomic, strong) id value;

@end

NS_ASSUME_NONNULL_END
