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

@property (nonatomic) id url1;
@property (nonatomic) id url2;
@property (nonatomic) MRGame *game;

@end

@implementation MRGameTests

- (void)setUp {
    [super setUp];
    _url1 = OCMClassMock([NSURL class]);
    _url2 = OCMClassMock([NSURL class]);
    _game = [[MRGame alloc] initWithInputURL:_url1 andOutputURL:_url2];
}

- (void)tearDown {
    [super tearDown];
    _url1 = nil;
    _url2 = nil;
    _game = nil;
}

- (void)testInitWithInputURLandOutputURL {
    XCTAssertNotNil(_game);
    XCTAssertEqual(_game.inputURL, _url1);
    XCTAssertEqual(_game.outputURL, _url2);
    XCTAssertNotNil(_game.record);
}

- (void)testTakeTurn {
    id turn = OCMClassMock([NSDictionary class]);
    NSInteger preTurnScore = _game.record.score;
    [_game takeTurn:turn];
    XCTAssertEqual([_game.record.turns count], 1,
                   @"Game should update the record with the turn when it is taken");
    XCTAssertNotEqual(preTurnScore, _game.record.score,
                      @"Game should update the record with a new score");
}

@end
