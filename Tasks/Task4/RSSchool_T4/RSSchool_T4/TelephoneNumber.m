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

@property (nonatomic, retain) NSString *telephone;
@property (nonatomic, assign) NSUInteger numberLength;
@property (nonatomic, retain) NSString *countryCode;
@property (nonatomic, retain) NSString *country;

@end

@implementation TelephoneNumber

- (instancetype)initWithNumberLength:(NSUInteger)numberLength code:(NSString*)countryCode country:(NSString*)country
{
    self = [super init];
    if (self) {
        self.telephone = nil;
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
    TelephoneNumber *telephoneNumber = [TelephoneNumber new];
    telephoneNumber.telephone = number;
    NSMutableString *telephone = [NSMutableString stringWithString:number];
    if (telephone.length == 0 || ![self doesStringConsistOfDigits:telephone] || telephone.length > 12) {
        return telephoneNumber;
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
    for (NSUInteger i = 0; i < telephoneNumbers.count; i++) {
        if ([telephone hasPrefix:[telephoneNumbers objectAtIndex:i].countryCode]) {
            telephoneNumber = [telephoneNumbers objectAtIndex:i];
            NSUInteger numberLength = telephone.length - telephoneNumber.countryCode.length;
            switch (telephoneNumber.numberLength) {
                case 8:
                    if (numberLength >= 2) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length];
                        [telephone insertString:@"(" atIndex:telephoneNumber.countryCode.length + 1];
                        [telephone insertString:@") " atIndex:telephoneNumber.countryCode.length + 4];
                    }
                    if (numberLength > 5) {
                        [telephone insertString:@"-" atIndex:telephoneNumber.countryCode.length + 9];
                    }
                    break;
                case 9:
                    if (numberLength >= 2) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length];
                        [telephone insertString:@"(" atIndex:telephoneNumber.countryCode.length + 1];
                        [telephone insertString:@") " atIndex:telephoneNumber.countryCode.length + 4];
                    }
                    if (numberLength > 5) {
                        [telephone insertString:@"-" atIndex:telephoneNumber.countryCode.length + 9];
                    }
                    if (numberLength > 7) {
                        [telephone insertString:@"-" atIndex:telephoneNumber.countryCode.length + 12];
                    }
                    break;
                case 10:
                    if (numberLength >= 3) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length];
                        [telephone insertString:@"(" atIndex:telephoneNumber.countryCode.length + 1];
                        [telephone insertString:@") " atIndex:telephoneNumber.countryCode.length + 5];
                    }
                    if (numberLength > 6) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length + 10];
                    }
                    if (numberLength > 8) {
                        [telephone insertString:@" " atIndex:telephoneNumber.countryCode.length + 13];
                    }
                    break;
                default:
                    break;
            }
            break;
        }
    }
    
    if ([telephoneNumber isEqual: [telephoneNumbers objectAtIndex:0]] &&
        number.length > 1 && [number characterAtIndex:1] == '7') {
        telephoneNumber = [telephoneNumbers objectAtIndex:1];
    }
    telephoneNumber.telephone = [NSString stringWithFormat:@"+%@", telephone];
    return telephoneNumber;
}

@end
