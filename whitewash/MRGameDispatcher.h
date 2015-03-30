//
//  MRGameDispatcher.h
//  Whitewash
//
//  Created by Allan Lasser on 3/30/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRGame;

@interface MRGameDispatcher : NSObject

+ (MRGameDispatcher *)newDispatcher;
- (MRGame *)newGame;

@end
