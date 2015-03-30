//
//  MRPlayer.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRPlayer.h"
#import "MRRecord.h"

@interface MRPlayer ()

@property (nonatomic, strong) NSMutableArray *mutableHistory;

@end

@implementation MRPlayer

@synthesize name;

- (instancetype)init {
    return [self initWithName:@"New Player"];
}

- (instancetype)initWithName:(NSString *)playerName {
    self = [super init];
    if (self) {
        self.name = playerName;
        self.mutableHistory = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (MRPlayer *)newPlayerWithName:(NSString *)playerName {
    return [[MRPlayer alloc] initWithName:playerName];
}

# pragma mark - History

- (NSArray *)history {
    return [self.mutableHistory copy];
}

- (void)addRecordToHistory:(MRRecord *)record {
    [self.mutableHistory addObject:record];
}

- (void)removeRecordFromHistory:(MRRecord *)record {
    [self.mutableHistory removeObject:record];
}

- (NSUInteger)countTotalTurns {
    NSUInteger count = 0;
    for (MRRecord *record in _mutableHistory) {
        count += [record.turns count];
    }
    return count;
}

- (NSUInteger)countTotalGames {
    return [_mutableHistory count];
}

- (NSInteger)bestScore {
    NSInteger best = [(MRRecord *)[_mutableHistory firstObject] score];
    for (MRRecord *record in _mutableHistory) {
        if ([record score] > best) {
            best = [record score];
        }
    }
    return best;
}

- (NSInteger)bestMultiplier {
    NSInteger best = [(MRRecord *)[_mutableHistory firstObject] multiplier];
    for (MRRecord *record in _mutableHistory ) {
        if ([record multiplier] > best) {
            best = [record multiplier];
        }
    }
    return best;
}

- (NSInteger)todayScore {
    NSInteger score = 0;
    NSDate *today = [self getDateToday];
    for (MRRecord *record in _mutableHistory) {
        // if record's datetime comes after today at 00:00
        if ([record.date compare:today] == NSOrderedDescending) {
            score += record.score;
        }
    }
    return score;
}

- (NSInteger)todayMultiplier {
    NSInteger count = 1;
    NSDate *today = [self getDateToday];
    for (MRRecord *record in _mutableHistory) {
        // if record's datetime comes after today at 00:00
        if ([record.date compare:today] == NSOrderedDescending) {
            count += 1;
        }
    }
    return count;
}

- (NSDate *)getDateToday {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *comps = [cal components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                     fromDate:now];
    NSDate *today = [cal dateFromComponents:comps];
    return today;
}

@end
