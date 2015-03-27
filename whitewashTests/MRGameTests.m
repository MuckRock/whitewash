//
//  MRGameTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MRGame.h"
#import "MRRuleset.h"

@interface MRGameTests : XCTestCase

@end

@implementation MRGameTests {
    id url;
    id ruleset;
    MRGame *game;
}

- (void)setUp {
    [super setUp];
    url = OCMClassMock([NSURL class]);
    ruleset = OCMClassMock([MRRuleset class]);
    game = [MRGame gameWithURL:url andRulset:ruleset];
}

- (void)tearDown {
    [super tearDown];
    game = nil;
}


- (void)testConstructor {
    XCTAssertNotNil(game.record);
    XCTAssertNotNil(game.ruleset);
    XCTAssertNotNil(game.store);
    XCTAssertNotNil(game.url);
}

- (void)testTakeTurnWithValidMove {
    // mock a valid call to [game.ruleset validateMove:move]
    // since we want to test the effects of a positive return value
    id move = @"Left";
    MRTurn *turn = OCMClassMock([MRTurn class]);
    OCMStub([game.ruleset validateMove:move]).andReturn(turn);
    
    [game takeTurnWithMove:move];
    XCTAssertEqual([game.record.turns firstObject], turn);
}

- (void)testTakeTurnWithInvalidMove {
    // mock an invalid call to [game.ruleset validateMove:move]
    // since we want to test that an invalid move throws an exception
    id move = @"Left";
    OCMStub([game.ruleset validateMove:move]).andReturn(nil);
    XCTAssertThrows([game takeTurnWithMove:move]);
}

@end
