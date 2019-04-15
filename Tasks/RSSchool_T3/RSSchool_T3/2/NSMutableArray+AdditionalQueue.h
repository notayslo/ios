//
//  NSMutableArray+AdditionalQueue.h
//  RSSchool_T3
//
//  Created by Anton Sipaylo on 4/15/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (AdditionalQueue)
- (id) deque;
- (void) enqueue:(id)obj;
- (bool) isEmpty;
@end

NS_ASSUME_NONNULL_END
