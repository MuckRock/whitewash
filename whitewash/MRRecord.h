//
//  MRRecord.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRTurn.h"

@interface MRRecord : NSObject

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSDate *date;
@property (nonatomic, readonly, copy) NSArray *turns;
@property (nonatomic, readonly) NSDate *date;

+ (MRRecord *)newRecord;
- (void)addTurn:(MRTurn *)turn;
- (void)removeTurn:(MRTurn *)turn;

- (NSUInteger)countTurns;

@end
