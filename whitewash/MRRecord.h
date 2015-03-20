//
//  MRRecord.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRecord : NSObject

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger multiplier;
@property (nonatomic, readonly, copy) NSArray *turns;
@property (nonatomic, readonly) NSDate *date;

+ (MRRecord *)newRecord;

- (void)recordTurn:(id)turn;
- (void)modifyScoreBy:(NSInteger)amount;

- (NSUInteger)countTurns;

@end
