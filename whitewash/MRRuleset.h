//
//  MRRuleset.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRuleset : NSObject

@property (nonatomic, readonly, copy) NSArray *startState;
@property (nonatomic, readonly, copy) NSArray *moves;
@property (nonatomic, readonly, copy) NSArray *endState;

- (void)addStartStateRules:(NSArray *)rules;
- (void)addEndStateRules:(NSArray *)rules;
- (void)addMoveRules:(NSArray *)rules;

- (void)addStartStateRule:(id)rule;
- (void)addEndStateRule:(id)rule;
- (void)addMoveRule:(id)rule;

- (void)removeStartStateRule:(id)rule;
- (void)removeEndStateRule:(id)rule;
- (void)removeMoveRule:(id)rule;

@end
