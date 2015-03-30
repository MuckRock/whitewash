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

@interface MRGameTests : XCTestCase

@end

@implementation MRGameTests {
    id url;
    MRRuleset *ruleset;
    MRGame *game;
}

- (void)setUp {
    [super setUp];
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"communications" ofType:@"json"]];
    NSArray *validMoves = @[@"Left", @"Right"];
    NSPredicate *rule = [NSPredicate predicateWithFormat:@"SELF IN %@", validMoves];
    ruleset = [MRRuleset rulesetWithRules:@[rule]];
    game = [MRGame gameWithURL:url andRuleset:ruleset];
}

- (void)tearDown {
    [super tearDown];
    game = nil;
}


- (void)testConstructor {
    XCTAssertNotNil(game.record);
    XCTAssertNotNil(game.ruleset);
    XCTAssertNotNil(game.store);
}

- (void)testTakeTurnWithValidMove {
    // mock a valid call to [game.ruleset validateMove:move]
    // since we want to test the effects of a positive return value
    id move = @"Left";
    MRTurn *turn = OCMClassMock([MRTurn class]);
    OCMStub([game.ruleset validateMove:move]).andReturn(turn);
    
    [game takeTurnWithMove:move];
    XCTAssertNotNil([game.record.turns firstObject]);
}

- (void)testTakeTurnWithInvalidMove {
    // mock an invalid call to [game.ruleset validateMove:move]
    // since we want to test that an invalid move throws an exception
    OCMStub([game.ruleset validateMove:@"Up"]).andReturn(nil);
    XCTAssertThrows([game takeTurnWithMove:@"Up"]);
}

@end
