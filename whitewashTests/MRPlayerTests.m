//
//  MRPlayerTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MRPlayer.h"

@interface MRPlayerTests : XCTestCase

@end

@implementation MRPlayerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit {
    MRPlayer *player = [[MRPlayer alloc] init];
    XCTAssertNotNil(player, @"init fails to return anything");
    XCTAssertNotNil(player.name, @"MRPlayer fails to initialize without a name");
}

- (void)testInitWithName {
    MRPlayer *player = [[MRPlayer alloc] initWithName:@"Bob"];
    XCTAssertNotNil(player, @"initWithName fails to return anything");
    XCTAssertEqual(player.name, @"Bob", @"MRPlayer fails to initialize with the right name.");
}

- (void)testNewPlayerWithName {
    MRPlayer *player = [MRPlayer newPlayerWithName:@"Bob"];
    XCTAssertNotNil(player, @"newPlayerWithName fails to return anything");
    XCTAssertEqual(player.name, @"Bob", @"newPlayerWithName fails to return a new object with the right name");
}

- (void)testHistory {
    MRPlayer *player = [MRPlayer newPlayerWithName:@"Bob"];
    XCTAssertNotNil(player.history, @"New player does not return a history array after creation");
    XCTAssertEqual([player.history count], 0, @"New player does not return an empty history array after creation");
}

@end
