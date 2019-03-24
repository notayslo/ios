#import "SummArray.h"

@implementation SummArray

- (NSNumber *)summArray:(NSArray *)array {
    NSInteger sum = 0;
    for (NSUInteger i = 0; i < [array count]; i++) {
        sum += [[array objectAtIndex: i] integerValue];
    }
    return [NSNumber numberWithInteger: sum];
}

@end
