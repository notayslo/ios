#import "RomanTranslator.h"

@implementation RomanTranslator
- (NSString *)romanFromArabic:(NSString *)arabicString {
    NSLog(@"Recursion level, arabicString = %@", arabicString);
    NSArray *values = @[@(1000), @(900), @(500), @(400), @(100), @(90), @(50), @(40), @(10), @(9), @(5), @(4), @(1)];
    NSArray *symbols = @[@"M", @"CM", @"D", @"CD", @"C", @"XC", @"L", @"XL", @"X", @"IX", @"V", @"IV", @"I"];
    NSUInteger number = [arabicString integerValue];
    NSUInteger index = 0;
    NSString *result = @"";
    while (number > 0) {
        NSUInteger value = [[values objectAtIndex:index] unsignedIntegerValue];
        if (number >= value) {
            NSString *str = [result stringByAppendingString:[symbols objectAtIndex: index]];
            result = str;
            number -= value;
        } else {
            index++;
        }
    }
    return result;
}

- (NSString *)arabicFromRoman:(NSString *)romanString {
    NSDictionary *dictionary = @{@"M" : @(1000), @"D" : @(500), @"C" : @(100), @"L" : @(50), @"X" : @(10), @"V" : @(5), @"I" : @(1)};
    NSUInteger i = 0;
    NSString *previousSymbol = [romanString substringWithRange:NSMakeRange(i, 1)];
    NSUInteger number = [dictionary[previousSymbol] unsignedIntegerValue];
    for (i = 1; i < [romanString length]; i++) {
        NSString *currentSymbol = [romanString substringWithRange:NSMakeRange(i, 1)];
        if ([dictionary[currentSymbol] unsignedIntegerValue] > [dictionary[previousSymbol] unsignedIntegerValue]) {
            number += [dictionary[currentSymbol] unsignedIntegerValue] - 2 * [dictionary[previousSymbol] unsignedIntegerValue];
        } else {
            number += [dictionary[currentSymbol] unsignedIntegerValue];
        }
        previousSymbol = currentSymbol;
        [currentSymbol release];
    }
    [previousSymbol release];
    return [NSString stringWithFormat:@"%lu", number];
}
@end
