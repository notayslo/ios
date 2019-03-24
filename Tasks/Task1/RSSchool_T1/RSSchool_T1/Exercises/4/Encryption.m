#import "Encryption.h"

@implementation Encryption

- (NSString *)encryption:(NSString *)string {
    NSString *withoutSpaces = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUInteger L = [withoutSpaces length];
    double sqrtL = sqrt((long double)L);
    NSUInteger lowerL = floor(sqrtL);
    NSUInteger upperL = sqrtL > (double)lowerL ? lowerL + 1 : lowerL;
    if (upperL * lowerL < L) {
        lowerL += 1;
    }
    NSString *result = [NSString new];
    for (NSUInteger i = 0; i < upperL; i++) {
        if (i != 0) {
            result = [result stringByAppendingFormat:@"%c", ' '];
        }
        NSUInteger j = 0;
        while (i + j * upperL < L) {
            char c = [withoutSpaces characterAtIndex:i + j * upperL];
            result = [result stringByAppendingFormat:@"%c", c];
            j++;
        }
    }
    return result;
}

@end
