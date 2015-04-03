//
//  MRGameDataQueue.h
//  Whitewash
//
//  Created by Allan Lasser on 4/3/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRGameDataQueue : NSObject

@property (nonatomic, readonly) NSArray *queue;

+ (MRGameDataQueue *)newQueue;

- (void)enqueue:(id)data;
- (id)dequeue;

@end
