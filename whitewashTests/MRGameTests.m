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
#import "MRWebStore.h"

@interface MRGameTests : XCTestCase

@end

@implementation MRGameTests {
    id url1;
    id url2;
    MRGame *game;
}

- (void)setUp {
    [super setUp];
    url1 = OCMClassMock([NSURL class]);
    url2 = OCMClassMock([NSURL class]);
    game = [[MRGame alloc] initWithInputURL:url1 andOutputURL:url2];
    [game populateInputDataStore];

}

- (void)tearDown {
    [super tearDown];
    url1 = nil;
    url2 = nil;
    game = nil;
}

- (void)testInitWithInputURLandOutputURL {
    XCTAssertNotNil(game);
    XCTAssertEqual(game.inputURL, url1);
    XCTAssertEqual(game.outputURL, url2);
    XCTAssertNotNil(game.inputData);
    XCTAssertNotNil(game.outputData);
    XCTAssertNotNil(game.record);
}

- (void)testTakeTurn {
    id turn = OCMClassMock([NSDictionary class]);
    NSInteger preTurnScore = game.record.score;
    [game takeTurn:turn];
    XCTAssertEqual([game.record.turns count], 1,
                   @"Game should update the record with the turn when it is taken");
    XCTAssertNotEqual(preTurnScore, game.record.score,
                      @"Game should update the record with a new score");
}

- (void)testPopulateInputDataStore {
    XCTAssertGreaterThan([game.inputData.data count], 0,
                     @"GameDataStore should populate with data from endpoint");
}

- (void)testUploadOutputDataStore {
    XCTAssert(NO, @"Method not yet implemented");
}

@end
