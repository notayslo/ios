//
//  TelephoneNumber.h
//  RSSchool_T4
//
//  Created by Anton Sipaylo on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#ifndef TelephoneNumber_h
#define TelephoneNumber_h

@interface TelephoneNumber : NSObject

@property (nonatomic, assign, readonly) NSUInteger numberLength;
@property (nonatomic, retain, readonly) NSString *countryCode;
@property (nonatomic, assign, readonly) NSString *country;

- (instancetype)initWithNumberLength:(NSUInteger)numberLength code:(NSString*)countryCode country:(NSString*)country;

@end

#endif /* TelephoneNumber_h */
