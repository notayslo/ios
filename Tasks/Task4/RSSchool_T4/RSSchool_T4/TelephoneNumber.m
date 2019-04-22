//
//  TelephoneNumber.m
//  RSSchool_T4
//
//  Created by Anton Sipaylo on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TelephoneNumber.h"

@interface TelephoneNumber ()

@property (nonatomic, assign) NSUInteger numberLength;
@property (nonatomic, retain) NSString *countryCode;
@property (nonatomic, retain) NSString *country;

@end

@implementation TelephoneNumber

- (instancetype)initWithNumberLength:(NSUInteger)numberLength code:(NSString*)countryCode country:(NSString*)country
{
    self = [super init];
    if (self) {
        self.numberLength = numberLength;
        self.countryCode = [NSString stringWithString:countryCode];
        self.country = [NSString stringWithString:country];
    }
    return self;
}

+ (BOOL) doesStringConsistOfDigits:(NSString*)string {
    NSUInteger i = 0;
    if ([string characterAtIndex:i] == '+') {
        i++;
    }
    for (; i < string.length; i++) {
        if ([string characterAtIndex:i] < '0' || [string characterAtIndex:i] > '9') return NO;
    }
    return YES;
}

+ (TelephoneNumber*) processNumber:(NSString*)number {
    if (number.length == 0 || ![self doesStringConsistOfDigits:number])
        return nil;
    NSMutableString *telephone = [NSMutableString stringWithString:number];
    if ([number characterAtIndex:0] == '+') {
        telephone = [NSMutableString stringWithString:[number substringFromIndex:1]];
    }
    
    NSArray<TelephoneNumber*> *telephoneNumbers = @[[[TelephoneNumber alloc] initWithNumberLength:10 code:@"7" country:@"RU"],
                         [[TelephoneNumber alloc] initWithNumberLength:10 code:@"7" country:@"KZ"],
                         [[TelephoneNumber alloc] initWithNumberLength:8 code:@"373" country:@"MD"],
                         [[TelephoneNumber alloc] initWithNumberLength:8 code:@"374" country:@"AM"],
                         [[TelephoneNumber alloc] initWithNumberLength:9 code:@"375" country:@"BY"],
                         [[TelephoneNumber alloc] initWithNumberLength:9 code:@"380" country:@"UA"],
                         [[TelephoneNumber alloc] initWithNumberLength:9 code:@"992" country:@"TJ"],
                         [[TelephoneNumber alloc] initWithNumberLength:8 code:@"993" country:@"TM"],
                         [[TelephoneNumber alloc] initWithNumberLength:9 code:@"994" country:@"AZ"],
                         [[TelephoneNumber alloc] initWithNumberLength:9 code:@"996" country:@"KG"],
                         [[TelephoneNumber alloc] initWithNumberLength:9 code:@"998" country:@"UZ"]];
    TelephoneNumber *telephoneNumber = nil;
    for (NSUInteger i = 0; i < telephoneNumbers.count; i++) {
        telephoneNumber = [telephoneNumbers objectAtIndex:i];
        if ([telephone hasPrefix:telephoneNumber.countryCode]) {
            NSUInteger numberLength = telephone.length - telephoneNumber.countryCode.length;
            switch (telephoneNumber.numberLength) {
                case 8:
                    if (numberLength > 5) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length];
                        [telephone insertString:@"(" atIndex:telephoneNumber.countryCode.length + 1];
                        [telephone insertString:@") " atIndex:telephoneNumber.countryCode.length + 4];
                        [telephone insertString:@"-" atIndex:telephoneNumber.countryCode.length + 9];
                    } else if (numberLength >= 2) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length];
                        [telephone insertString:@"(" atIndex:telephoneNumber.countryCode.length + 1];
                        [telephone insertString:@") " atIndex:telephoneNumber.countryCode.length + 4];
                    }
                    break;
                case 9:
                    if (numberLength > 7) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length];
                        [telephone insertString:@"(" atIndex:telephoneNumber.countryCode.length + 1];
                        [telephone insertString:@") " atIndex:telephoneNumber.countryCode.length + 4];
                        [telephone insertString:@"-" atIndex:telephoneNumber.countryCode.length + 9];
                        [telephone insertString:@"-" atIndex:telephoneNumber.countryCode.length + 12];
                    } else if (numberLength > 5) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length];
                        [telephone insertString:@"(" atIndex:telephoneNumber.countryCode.length + 1];
                        [telephone insertString:@") " atIndex:telephoneNumber.countryCode.length + 4];
                        [telephone insertString:@"-" atIndex:telephoneNumber.countryCode.length + 9];
                    } else if (numberLength >= 2) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length];
                        [telephone insertString:@"(" atIndex:telephoneNumber.countryCode.length + 1];
                        [telephone insertString:@") " atIndex:telephoneNumber.countryCode.length + 4];
                    }
                    break;
                case 10:
                    if (numberLength > 8) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length];
                        [telephone insertString:@"(" atIndex:telephoneNumber.countryCode.length + 1];
                        [telephone insertString:@") " atIndex:telephoneNumber.countryCode.length + 5];
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length + 10];
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length + 13];
                    } else if (numberLength > 6) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length];
                        [telephone insertString:@"(" atIndex:telephoneNumber.countryCode.length + 1];
                        [telephone insertString:@") " atIndex:telephoneNumber.countryCode.length + 5];
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length + 10];
                    } else if (numberLength >= 3) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length];
                        [telephone insertString:@"(" atIndex:telephoneNumber.countryCode.length + 1];
                        [telephone insertString:@") " atIndex:telephoneNumber.countryCode.length + 5];
                    }
                    break;
                default:
                    break;
            }
            break;
        }
    }
    NSLog(@"telephone = %@", telephone);
    
//    NSMutableArray<NSString*> *patterns = [NSMutableArray new];
//    for (NSUInteger i = 0; i < telephoneNumbers.count; i++) {
//        TelephoneNumber *telephoneNumber = [telephoneNumbers objectAtIndex:i];
//        NSString *regularExpression = [NSString stringWithFormat:@"%@\\d{%@}", [telephoneNumber countryCode], [telephoneNumber numberLength]];
//        NSRange range = NSMakeRange(0, [telephone length]);
//        NSError *error = nil;
//        [patterns addObject:regularExpression];
//        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[patterns objectAtIndex:i] options:nil error:error];
//        NSArray *matches = [regex matchesInString:telephone options:nil range:range];
//    }
    return telephoneNumber;
}

@end
