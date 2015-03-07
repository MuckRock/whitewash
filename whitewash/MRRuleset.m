//
//  MRRuleset.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRRuleset.h"

@interface MRRuleset ()

@property (nonatomic, strong) NSMutableArray *privateStartState;
@property (nonatomic, strong) NSMutableArray *privateMoves;
@property (nonatomic, strong) NSMutableArray *privateEndState;

@end

@implementation MRRuleset

- (instancetype)init {
    self = [super init];
    if (self) {
        self.privateStartState = [[NSMutableArray alloc] init];
        self.privateMoves = [[NSMutableArray alloc] init];
        self.privateEndState = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)startState {
    return [self.privateStartState copy];
}

- (NSArray *)moves {
    return [self.privateMoves copy];
}

- (NSArray *)endState {
    return [self.privateEndState copy];
}

# pragma mark -

# pragma mark Adding Individual Rules

- (void)addStartStateRule:(id)rule {
    [self.privateStartState addObject:rule];
}

- (void)addEndStateRule:(id)rule {
    [self.privateEndState addObject:rule];
}

- (void)addMoveRule:(id)rule {
    [self.privateMoves addObject:rule];
}

# pragma mark Removing Individual Rules

- (void)removeStartStateRule:(id)rule {
    [self.privateStartState removeObject:rule];
}

- (void)removeEndStateRule:(id)rule {
    [self.privateEndState removeObject:rule];
}

- (void)removeMoveRule:(id)rule {
    [self.privateMoves removeObject:rule];
}

# pragma mark Adding Arrays of Rules

- (void)addStartStateRules:(NSArray *)rules {
    [self.privateStartState addObjectsFromArray:rules];
}

- (void)addEndStateRules:(NSArray *)rules {
    [self.privateEndState addObjectsFromArray:rules];
}

- (void)addMoveRules:(NSArray *)rules {
    [self.privateMoves addObjectsFromArray:rules];
}

@end
