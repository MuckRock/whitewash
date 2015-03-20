//
//  MRRecord.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRRecord.h"

@interface MRRecord ()

@property (nonatomic) NSInteger privateScore;
@property (nonatomic) NSInteger privateMultiplier;
@property (nonatomic, strong) NSMutableArray *mutableTurns;

@end

@implementation MRRecord

- (instancetype)init {
    self = [super init];
    if (self) {
        self.privateScore = 0;
        self.privateMultiplier = 1;
        self.mutableTurns = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (MRRecord *)newRecord {
    return [[MRRecord alloc] init];
}

- (NSInteger)score {
    return self.privateScore;
}

- (NSInteger)multiplier {
    return self.privateMultiplier;
}

- (NSMutableArray *)turns {
    return [self.mutableTurns copy];
}

- (void)recordTurn:(id)turn {
    [self.mutableTurns addObject:turn];
}

- (void)modifyScoreBy:(NSInteger)amount {
    self.privateScore = self.privateScore + (amount * self.privateMultiplier);
}

- (NSUInteger)countTurns {
    return [_mutableTurns count];
}

@end
