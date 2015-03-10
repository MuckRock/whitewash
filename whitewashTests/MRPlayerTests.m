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

@interface MRPlayerTests : XCTestCase

@property (nonatomic) MRPlayer *player;
@property (nonatomic) MRRecord *record;

@end

@implementation MRPlayerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _player = [MRPlayer newPlayerWithName:@"Bob"];
    _record = OCMClassMock([MRRecord class]);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _player = nil;
    _record = nil;
}

- (void)testNewPlayerWithName {
    XCTAssertNotNil(_player, @"Calling new player should return a new player");
    XCTAssertEqual(_player.name, @"Bob",
                   @"New players should be given the name passed to them");
}

- (void)testHistory {
    XCTAssertNotNil(_player.history,
                    @"New players should have a history");
    XCTAssertEqual([_player.history count], 0,
                   @"Player history should start empty");
}

- (void)testAddRecordToHistory {
    [_player addRecordToHistory:_record];
    XCTAssertEqual([_player.history count], 1,
                   @"Records should be added to the player history array");
    XCTAssertEqualObjects(_player.history[0], _record,
                          @"The same record should exist inside the array");
}

- (void)testRemoveRecordFromHistory {
    XCTAssertNoThrow([_player removeRecordFromHistory:_record]);
    [_player addRecordToHistory:_record];
    [_player removeRecordFromHistory:_record];
    XCTAssertEqual([_player.history count], 0);
}

@end
