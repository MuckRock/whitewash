//
//  MRGameDispatcher.h
//  Whitewash
//
//  Created by Allan Lasser on 3/30/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRGameViewController;

@interface MRGameDispatcher : NSObject

+ (MRGameDispatcher *)newDispatcher;
- (MRGameViewController *)newGame;

@end
