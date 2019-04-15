//
//  TreeNode.m
//  RSSchool_T3
//
//  Created by Anton Sipaylo on 4/15/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

@implementation TreeNode: NSObject

-(instancetype)initWithValue:(NSUInteger)value {
    self = [super init];
    if (self) {
        _value = [NSNumber numberWithUnsignedInteger:value];
        _leftSon = nil;
        _rightSon = nil;
    }
    return self;
}

@end
