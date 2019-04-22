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
@property (nonatomic, assign) NSString *country;

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

@end
