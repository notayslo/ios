#import "KidnapperNote.h"

@implementation KidnapperNote

- (BOOL)checkMagazine:(NSString *)magazine note:(NSString *)note {
    NSArray *magazineWords = [magazine componentsSeparatedByString:@" "];
    NSMutableArray *lowerMagazineWords = [NSMutableArray new];
    for (NSUInteger i = 0; i < [magazineWords count]; i++) {
        NSString *string = [[magazineWords objectAtIndex:i] lowercaseString];
        [lowerMagazineWords addObject:string];
    }
    NSArray *noteWords = [note componentsSeparatedByString:@" "];
    BOOL result = YES;
    for (NSUInteger i = 0; i < [noteWords count]; i++) {
        NSString *string = [[noteWords objectAtIndex:i] lowercaseString];
        NSUInteger size = [lowerMagazineWords count];
        for (NSUInteger j = 0; j < [lowerMagazineWords count]; j++) {
            if ([string isEqualToString:[lowerMagazineWords objectAtIndex:j]]) {
                [lowerMagazineWords removeObjectAtIndex:j];
                break;
            }
        }
        [string release];
        if (size == [lowerMagazineWords count]) {
            result = NO;
            break;
        }
    }
    [lowerMagazineWords release];
    return result;
}
@end
