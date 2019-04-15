//
//  NSMutableArray+AdditionalQueue.m
//  RSSchool_T3
//
//  Created by Anton Sipaylo on 4/15/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "NSMutableArray+AdditionalQueue.h"

@implementation NSMutableArray (AdditionalQueue)
- (id) deque {
    id head = [self objectAtIndex:0];
    if (head != nil) {
        [[head retain] autorelease];
        [self removeObjectAtIndex:0];
    }
    return head;
}

- (void) enqueue:(id)obj {
    [self addObject:obj];
}

- (bool) isEmpty {
    return [self count] == 0;
}
@end
