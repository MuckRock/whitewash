//
//  MRWebStore.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRGameData.h"

@interface MRWebStore : NSObject

@property (nonatomic, readonly, copy) NSArray *data;

- (void)addData:(MRGameData *)data;
- (void)removeData:(MRGameData *)data;
- (MRGameData *)popData;
- (void)moveDataAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
