//
//  MRGameDataStoreTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MRGameDataStore.h"

@interface MRGameDataStoreTests : XCTestCase

@end

@implementation MRGameDataStoreTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit {
    MRGameDataStore *store = [[MRGameDataStore alloc] init];
    XCTAssertNotNil(store, @"GameDataStore fails to return object on init");
}

- (void)testGameData {
    MRGameDataStore *store = [[MRGameDataStore alloc] init];
    XCTAssertNotNil(store.gameData, @"GameDataStore fails to create gameData array on init");
    XCTAssertEqual([store.gameData count], 0, @"gameData is not initially empty");
}

- (void)testAddData {
    MRGameDataStore *store = [[MRGameDataStore alloc] init];
    NSObject *data = [[NSObject alloc] init];
    [store addData:data];
    XCTAssertEqual([store.gameData count], 1, @"data does not get added to gameData array");
    XCTAssertEqualObjects(store.gameData[0], data, @"wrong data is added to gameData array");
}

- (void)testRemoveData {
    MRGameDataStore *store = [[MRGameDataStore alloc] init];
    NSObject *data = [[NSObject alloc] init];
    XCTAssertNoThrow([store removeData:data]);
    [store addData:data];
    [store removeData:data];
    XCTAssertEqual([store.gameData count], 0);
}

- (void)testMoveData {
    MRGameDataStore *store = [[MRGameDataStore alloc] init];
    NSObject *data1 = [[NSObject alloc] init];
    NSObject *data2 = [[NSObject alloc] init];
    [store addData:data1];
    [store addData:data2];
    XCTAssertEqualObjects(store.gameData[0], data1);
    [store moveDataAtIndex:1 toIndex:0];
    XCTAssertEqualObjects(store.gameData[0], data2, @"Failed to move data to proper index");
}

@end
