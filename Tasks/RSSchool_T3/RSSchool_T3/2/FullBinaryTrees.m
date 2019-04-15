#import "FullBinaryTrees.h"
#import "TreeNode.h"
#import "NSMutableArray+AdditionalQueue.h"

@interface FullBinaryTrees()

@property (nonatomic, retain) NSMutableDictionary <NSNumber*, NSMutableArray<TreeNode*> *> *trees;

@end

@implementation FullBinaryTrees

- (NSMutableArray<TreeNode*>*)treesWithNodes:(NSUInteger)amount {
    NSMutableArray *binaryTrees = [self.trees objectForKey:[NSNumber numberWithUnsignedInteger:amount]];
    if (binaryTrees != nil) {
        return binaryTrees;
    }
    if (amount % 2 == 0) {
        return nil;
    }
    if (amount == 1) {
        TreeNode *node = [[TreeNode alloc] initWithValue:0];
        NSMutableArray *nodes = [NSMutableArray new];
        [nodes addObject:node];
        return nodes;
    }
    NSMutableArray *result = [NSMutableArray new];
    for (NSUInteger i = 1; i <= amount - 2; i += 2) {
        NSMutableArray *leftTrees = [self treesWithNodes:i];
        NSMutableArray *rightTrees = [self treesWithNodes:(amount - i - 1)];
        for (NSUInteger j = 0; j < [leftTrees count]; j++) {
            for (NSUInteger k = 0; k < [rightTrees count]; k++) {
                TreeNode *vertex = [[TreeNode alloc] initWithValue:0];
                [vertex setLeftSon:[leftTrees objectAtIndex:j]];
                [vertex setRightSon:[rightTrees objectAtIndex:k]];
                [result addObject:vertex];
            }
        }
    }
    [self.trees setObject:result forKey:[NSNumber numberWithUnsignedInteger:amount]];
    return result;
}

- (NSString*)transformTreeToStringView:(NSMutableArray<TreeNode*>*)trees {
    NSMutableArray *stringTrees = [NSMutableArray new];
    for (NSUInteger j = 0; j < [trees count]; j++) {
        NSMutableArray *queue = [NSMutableArray new];
        TreeNode *root = [trees objectAtIndex:j];
        [queue enqueue:root];
        NSMutableArray *stringTree = [NSMutableArray new];
        while (![queue isEmpty]) {
            for (NSUInteger i = 0; i < [queue count]; i++) {
                TreeNode *node = [queue deque];
                if (node != nil && [[node value] unsignedIntegerValue] == 0) {
                    [stringTree addObject:@"0"];
                    if ([node leftSon] == nil) {
                        node.leftSon = [[TreeNode alloc] initWithValue:1];
                    }
                    if ([node rightSon] == nil) {
                        node.rightSon = [[TreeNode alloc] initWithValue:1];
                    }
                    [queue enqueue:[node leftSon]];
                    [queue enqueue:[node rightSon]];
                } else {
                    [stringTree addObject:@"null"];
                }
            }
        }
        [queue release];
        [root release];
        for (NSUInteger i = [stringTree count] - 1; i >= 1; i--) {
            if (![[stringTree objectAtIndex:i] isEqualToString:@"null"]) {
                break;
            } else {
                [stringTree removeObjectAtIndex:i];
            }
        }
        NSString *modifiedStringTree = [NSString stringWithFormat:@"[%@]", [stringTree componentsJoinedByString:@", "]];
        [stringTrees addObject:modifiedStringTree];
        [stringTree release];
    }
    NSString *result = [NSString stringWithFormat:@"[%@]", [stringTrees componentsJoinedByString:@", "]];
    [stringTrees release];
    return result;
}

- (NSString*)stringForNodeCount:(NSInteger)count {
    NSMutableArray<TreeNode*>* trees = [self treesWithNodes:count];
    return [self transformTreeToStringView:trees];
}

@end
