//
//  Character.h
//  RSSchool_T2
//
//  Created by Anton Sipaylo on 4/1/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#ifndef Character_h
#define Character_h

#import "MatrixHacker.h"
@interface Character: NSObject <Character>

@property (nonatomic, copy, readonly) NSString *characterName;
@property (nonatomic) BOOL isClone;

@end

#endif /* Character_h */
