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
@property (nonatomic, readonly) NSArray *turns;

+ (MRRecord *)newRecord;

- (void)recordTurn:(id)turn;
- (void)modifyScoreBy:(NSInteger)amount;

@end
