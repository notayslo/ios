//
//  Character.m
//  RSSchool_T2
//
//  Created by Anton Sipaylo on 4/1/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

@interface Character()

@property (nonatomic, copy) NSString *characterName;

@end

@implementation Character

-(NSString*) name {
    return self.characterName;
}

-(BOOL) isClone {
    return self.isClone;
}

+(instancetype)createWithName:(NSString *)name isClone:(BOOL)clone {
    Character *character = [Character new];
    if (character.characterName != name) {
        character.characterName = name;
        character.isClone = clone;
    }
    return [character autorelease];
}

@end

