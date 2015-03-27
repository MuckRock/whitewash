//
//  MRRuleset.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRRuleset.h"
#import "MRTurn.h"

@interface MRRuleset ()

@property (nonatomic) NSInteger pointsPerTurn;
@property (nonatomic) NSInteger pointMultiplier;

@end

@implementation MRRuleset

@synthesize rules;

+ (MRRuleset *)rulesetWithRules:(NSArray *)rules {
    return [[MRRuleset alloc] initWithRules:rules];
}

- (instancetype)initWithRules:(NSArray *)theRules {
    self = [super init];
    if (self) {
        // should be an array of NSPredicates
        self.rules = [NSCompoundPredicate andPredicateWithSubpredicates:theRules];
    }
    return self;
}

- (MRTurn *)validateMove:(id)move {
    MRTurn *turn = nil;
    BOOL validMove = [self.rules evaluateWithObject:move];
    if (validMove) {
        turn = [[MRTurn alloc] init];
        turn.score = self.pointsPerTurn;
        turn.multiplier = self.pointMultiplier;
        turn.move = move;
        return turn;
    }
    return turn;
}

@end
