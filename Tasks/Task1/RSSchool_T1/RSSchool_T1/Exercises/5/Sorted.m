#import "Sorted.h"

@implementation ResultObject
@end

@implementation Sorted

- (void) reverseArray:(NSMutableArray*)array {
    for (NSUInteger i = 0, j = [array count] - 1; i < j; i++, j--) {
        [array exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
}

- (BOOL) isSorted:(NSMutableArray*) array {
    for (NSUInteger i = 1; i < [array count]; i++) {
        if ([[array objectAtIndex:i] integerValue] < [[array objectAtIndex:(i - 1)] integerValue]) {
            return NO;
        }
    }
    return YES;
}

- (ResultObject*)sorted:(NSString*)string {
    ResultObject *value = [ResultObject new];
    NSMutableArray *numbers =[NSMutableArray arrayWithArray:[string componentsSeparatedByString:@" "]];
    NSArray *numbersSorted = [numbers sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        return [str1 compare:str2 options:(NSNumericSearch)];
    }];
    NSUInteger mismatches = 0;
    NSUInteger firstMismatch = 0;
    NSUInteger lastMismatch = 0;
    for (NSUInteger i = 0, count = [numbers count]; i < count; i++) {
        if ([[numbers objectAtIndex:i] integerValue] != [[numbersSorted objectAtIndex:i] integerValue]) {
            if (mismatches == 0) {
                firstMismatch = i;
            }
            else if (mismatches == 2 && i - lastMismatch != 1) {
                value.detail = nil;
                value.status = NO;
                return value;
            }
            lastMismatch = i;
            mismatches++;
        }
    }
    if (mismatches == 0) {
        value.detail = nil;
        value.status = YES;
        return value;
    }
    if (mismatches == 2) {
        value.detail = [NSString stringWithFormat:@"swap %lu %lu", firstMismatch + 1, lastMismatch + 1];
        value.status = YES;
        return value;
    }
    
    NSRange range = NSMakeRange(firstMismatch, lastMismatch - firstMismatch + 1);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[numbers objectsAtIndexes:indexSet]];
    [self reverseArray:array];
    if ([self isSorted:array]) {
        value.detail = [NSString stringWithFormat:@"reverse %lu %lu", firstMismatch + 1, lastMismatch + 1];
        value.status = YES;
    } else {
        value.detail = nil;
        value.status = NO;
    }
    
    return value;
}

@end
