//
//  MRGameDispatcher.m
//  Whitewash
//
//  Created by Allan Lasser on 3/30/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGameDispatcher.h"

#import "MRGame.h"
#import "MRGameViewController.h"
#import "MRSpamGameViewController.h"
#import "MRCompletedGameViewController.h"
#import "MRRuleset.h"

@interface MRGameDispatcher ()

@property (nonatomic) int rand;

@end

@implementation MRGameDispatcher

+ (MRGameDispatcher *)newDispatcher {
    MRGameDispatcher *dispatcher = [[MRGameDispatcher alloc] init];
    dispatcher.rand = arc4random() % 2;
    return dispatcher;
}

- (MRGameViewController *)newGame {
    /* Couldn't bugfix counting in time, had to hide CompletedGameViewController for now
    if (self.rand == 0)
    {
        return [MRSpamGameViewController newGameViewController];
    }
    else
    {
        return [MRCompletedGameViewController newGameViewController];
    }
    */
    return [MRSpamGameViewController newGameViewController];
}

@end
