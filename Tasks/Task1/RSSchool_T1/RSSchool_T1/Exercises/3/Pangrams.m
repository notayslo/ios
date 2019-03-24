#import "Pangrams.h"

@implementation Pangrams

- (BOOL)pangrams:(NSString *)string {
    const NSUInteger alphabetLength = 26;
    NSMutableArray *alphabet = [NSMutableArray new];
    for (NSUInteger i = 0; i < alphabetLength; i++) {
        [alphabet addObject:[NSNumber numberWithBool:NO]];
    }
    NSString *lowerString = [string lowercaseString];
    for (NSUInteger i = 0; i < lowerString.length; i++) {
        NSUInteger index = 0;
        if ((index = [lowerString characterAtIndex:i]) == ' ') {
            continue;
        }
        if (index >= 'A' && index <= 'Z') {
            index = index - 'A';
        } else if (index >= 'a' && index <= 'z') {
            index = index - 'a';
        }
        [alphabet replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];
    }
    for (NSUInteger i = 0; i < alphabetLength; i++) {
        if (![[alphabet objectAtIndex:i] boolValue]) {
            return NO;
        }
    }
    return YES;
}

@end
