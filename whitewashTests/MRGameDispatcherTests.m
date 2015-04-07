//
//  MRGameDispatcherTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/30/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MRGame.h"
#import "MRGameDispatcher.h"

@interface MRGameDispatcherTests : XCTestCase

@end

@implementation MRGameDispatcherTests {
    MRGameDispatcher *dispatcher;
    MRGameViewController *game;
}

- (void)setUp {
    [super setUp];
    dispatcher = [[MRGameDispatcher alloc] init];
    game = [dispatcher newGame];
}

- (void)tearDown {
    dispatcher = nil;
    game = nil;
    [super tearDown];
}

- (void)testNewGame {
    XCTAssertNotNil(game);
}

@end
