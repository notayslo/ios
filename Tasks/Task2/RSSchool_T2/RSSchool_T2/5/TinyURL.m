#import "TinyURL.h"

@interface TinyURL()

@property (nonatomic, retain) NSMutableDictionary <NSString*, NSString*> *urlDictionary;

@end

@implementation TinyURL

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlDictionary = [NSMutableDictionary new];
    }
    return self;
}

static int amountOfChars = 10;
static NSString *alias = @"https://therealanton.by/";

-(NSURL*)encode:(NSURL *)originalURL {
    NSString *url = [originalURL absoluteString];
    NSString *encoded = @"";
    for (NSUInteger i = 0; i < amountOfChars; i++) {
        encoded = [encoded stringByAppendingString:[NSString stringWithFormat:@"%uc", [url characterAtIndex:i]]];
    }
    encoded = [alias stringByAppendingString:encoded];
    if ([self.urlDictionary objectForKey:encoded] == nil) {
        self.urlDictionary[encoded] = url;
    } else {
        return [self encode:originalURL];
    }
    [url release];
    return [NSURL URLWithString:encoded];
}

-(NSURL*)decode:(NSURL *)shortenedURL {
    return [NSURL URLWithString: [self.urlDictionary valueForKey:[shortenedURL absoluteString]]];
}

- (void)dealloc
{
    [super dealloc];
    self.urlDictionary = nil;
    [self.urlDictionary dealloc];
}


@end
