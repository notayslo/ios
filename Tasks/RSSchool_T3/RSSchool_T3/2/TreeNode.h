//
//  TreeNode.h
//  RSSchool_T3
//
//  Created by Anton Sipaylo on 4/15/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#ifndef TreeNode_h
#define TreeNode_h

@interface TreeNode: NSObject

@property (nonatomic, retain, readwrite) NSNumber *value;
@property (nonatomic, retain, readwrite) TreeNode *leftSon;
@property (nonatomic, retain, readwrite) TreeNode *rightSon;

-(instancetype)initWithValue:(NSUInteger)value;
@end

#endif /* TreeNode_h */
