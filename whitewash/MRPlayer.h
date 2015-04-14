//
//  MRPlayer.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRRecord.h"

@interface MRPlayer : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *history;
@property (nonatomic) NSInteger rank;

- (instancetype)initWithName:(NSString *)playerName;
+ (MRPlayer *)newPlayerWithName:(NSString *)playerName;

- (void)addRecordToHistory:(MRRecord *)record;
- (void)removeRecordFromHistory:(MRRecord *)record;

- (NSUInteger)countTotalTurns;
- (NSUInteger)countTotalGames;
- (NSInteger)bestScore;
- (NSInteger)bestMultiplier;
- (NSInteger)todayScore;
- (NSInteger)todayMultiplier;

- (NSInteger)gamesNeededForNextRank;
- (float)progressToNextRank;

@end
