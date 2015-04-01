//
//  MRPlayerTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "MRPlayer.h"
#import "MRRecord.h"

@interface MRPlayerTests : XCTestCase

@end

@implementation MRPlayerTests {
    MRPlayer *player;
    MRRecord *record;
}

- (void)setUp {
    [super setUp];
    player = [MRPlayer newPlayerWithName:@"Bob"];
    record = [MRRecord newRecord];
    MRTurn *mockTurn = OCMClassMock([MRTurn class]);
    OCMStub([record score]).andReturn(5);
    OCMStub([mockTurn score]).andReturn(1);
    OCMStub([mockTurn multiplier]).andReturn(1);
    [record addTurn:mockTurn];
    
}

- (void)tearDown {
    [super tearDown];
    player = nil;
    record = nil;
}

- (void)testNewPlayerWithName {
    XCTAssertNotNil(player, @"Calling new player should return a new player");
    XCTAssertEqual(player.name, @"Bob",
                   @"New players should be given the name passed to them");
}

- (void)testHistory {
    XCTAssertNotNil(player.history,
                    @"New players should have a history");
    XCTAssertEqual([player.history count], 0,
                   @"Player history should start empty");
}

- (void)testAddRecordToHistory {
    [player addRecordToHistory:record];
    XCTAssertEqual([player.history count], 1,
                   @"Records should be added to the player history array");
    XCTAssertEqualObjects(player.history[0], record,
                          @"The same record should exist inside the array");
}

- (void)testRemoveRecordFromHistory {
    XCTAssertNoThrow([player removeRecordFromHistory:record]);
    [player addRecordToHistory:record];
    [player removeRecordFromHistory:record];
    XCTAssertEqual([player.history count], 0);
}

- (void)testCountTotalTurns {
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    XCTAssertEqual([player countTotalTurns], 5,
                   @"Player should know how many turns they've taken");
}

- (void)testCountTotalGames {
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    XCTAssertEqual([player countTotalGames], 5,
                   @"Player should know how many games they've played");
}

- (void)testBestScore {
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    XCTAssertGreaterThan([player bestScore], 0);
}

- (void)testBestMultiplier {
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    [player addRecordToHistory:record];
    XCTAssertGreaterThan([player bestMultiplier], 1);
}

@end
