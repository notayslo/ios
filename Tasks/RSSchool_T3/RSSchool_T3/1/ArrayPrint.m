#import "ArrayPrint.h"

@implementation NSArray (RSSchool_Extension_Name)

- (NSString*) print {
    NSMutableArray<NSString*> *result = [NSMutableArray new];
    for (NSUInteger i = 0; i < [self count]; i++) {
        id element = [self objectAtIndex:i];
        NSString *description = nil;
        if ([element isKindOfClass:[NSNumber class]]) {
            description = [NSString stringWithFormat:@"%lld", [element longLongValue]];
        } else if ([element isKindOfClass:[NSNull class]]) {
            description = @"null";
        } else if ([element isKindOfClass:[NSArray class]]) {
            description = [element print];
        } else if ([element isKindOfClass:[NSString class]]) {
            description = [NSString stringWithFormat:@"\"%@\"", element];
        } else {
            description = @"unsupported";
        }
        [result addObject:description];
    }
    NSString* stringResult = [NSString stringWithFormat:@"[%@]", [result componentsJoinedByString:@","]];
    [result release];
    return stringResult;
}

@end
