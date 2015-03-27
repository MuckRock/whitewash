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
    BOOL validMove = [rules evaluateWithObject:move];
    // if a valid move, create and return a turn object
    if (validMove) {
        MRTurn *turn = [[MRTurn alloc] init];
        turn.score = self.pointsPerTurn;
        turn.multiplier = self.pointMultiplier;
        turn.move = move;
        return turn;
    }
    // otherwise, raise an invalid move played error
    else {
        [NSException raise:@"Invalid Move" format:@"This move cannot be made, it is against the rules."];
        return nil;
    }
}

@end
