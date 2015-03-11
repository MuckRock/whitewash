//
//  MRGameDataStore.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRGameDataStore : NSObject

@property (nonatomic, readonly, copy) NSArray *data;

- (void)addData:(id)data;
- (void)removeData:(id)data;
- (id)popData;
- (void)moveDataAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
