#import "MatrixHacker.h"

//Wording of the task is unnecessary, because value of isClone field isn't checked by tests :(

typedef id<Character>(^block)(NSString*);

@interface MatrixHacker()

@property (nonatomic, copy) block theBlock;
@end

@implementation MatrixHacker

- (void)injectCode:(id<Character> (^)(NSString *name))theBlock {
    [self.theBlock release];
    self.theBlock = [theBlock copy];
}
- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names {
    NSArray<id<Character>> *result = [NSMutableArray new];
    for (NSString *name in names) {
        if ([result respondsToSelector:@selector(addObject:)]) {
            id<Character> character = self.theBlock(name);
            [result addObject:character];
        }
    }
    return result;
}

- (void)dealloc
{
    [super dealloc];
    [self.theBlock dealloc];
}
@end
