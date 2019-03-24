#import "Diagonal.h"

@implementation Diagonal

- (NSNumber *) diagonalDifference:(NSArray *)array {
    NSInteger N = [array count];
    NSMutableArray *numbers = [NSMutableArray new];
    for (NSUInteger i = 0; i < N; i++) {
        NSArray *vector = [[array objectAtIndex:i] componentsSeparatedByString:@" "];
        [numbers addObjectsFromArray:vector];
    }
    NSInteger difference = 0;
    for (NSUInteger i = 0; i < N; i++) {
        NSInteger first = [[numbers objectAtIndex:i * N + i] integerValue];
        NSInteger second = [[numbers objectAtIndex:N - i - 1 + i * N] integerValue];
        difference += first - second;
    }
    return @(labs(difference));
}

@end
