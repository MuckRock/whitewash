//
//  MRRecord.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRRecord.h"
#import "MRTurn.h"

@interface MRRecord ()

@property (nonatomic, strong) NSMutableArray *mutableTurns;

@end

@implementation MRRecord

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableTurns = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (MRRecord *)newRecord {
    return [[MRRecord alloc] init];
}

- (NSMutableArray *)turns {
    return [self.mutableTurns copy];
}

- (NSInteger)score {
    NSInteger score = 0;
    for (MRTurn *turn in self.mutableTurns) {
        score += turn.score * turn.multiplier;
    }
    return score;
}

- (NSDate *)date {
    MRTurn *lastTurn = [self.mutableTurns lastObject];
    return lastTurn.date;
}

- (void)addTurn:(MRTurn *)turn {
    [self.mutableTurns addObject:turn];
}

- (void)removeTurn:(MRTurn *)turn {
    [self.mutableTurns removeObject:turn];
}

@end
