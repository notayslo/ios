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

+ (NSString*) deleteUnnessesarySymbolsInString:(NSString*)string {
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"() -"];
    return [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
}

+ (TelephoneNumber*) processNumber:(NSString*)number {
    NSLog(@"number = %@", number);
    NSMutableString *telephone = [NSMutableString stringWithString:[self deleteUnnessesarySymbolsInString:number]];
    
    NSLog(@"string without unnessesary symbols = %@", telephone);
    
    TelephoneNumber *telephoneNumber = [TelephoneNumber new];
    telephoneNumber.telephone = telephone;
    
    if (telephone.length == 0 || ![self doesStringConsistOfDigits:telephone] || telephone.length > 12) {
        return telephoneNumber;
    }
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
    for (NSUInteger i = 0; i < telephoneNumbers.count; i++) {
        telephoneNumber = [telephoneNumbers objectAtIndex:i];
        if ([telephone hasPrefix:telephoneNumber.countryCode]) {
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
    telephoneNumber.telephone = [NSString stringWithString: telephone];
    NSLog(@"telephone = %@", telephone);
    return telephoneNumber;
}

@end
