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

@property (nonatomic) MRGameDataStore *store;
@property (nonatomic) NSObject *data;
@property (nonatomic) NSObject *moreData;

@end

@implementation MRGameDataStoreTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _store = [[MRGameDataStore alloc] init];
    _data = [[NSObject alloc] init];
    _moreData = [[NSObject alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    _store = nil;
    _data = nil;
    _moreData = nil;
}

- (void)testInit {
    XCTAssertNotNil(_store,
                    @"GameDataStore fails to return object on init");
}

- (void)testGameData {
    XCTAssertNotNil(_store.gameData,
                    @"GameDataStore fails to create gameData array on init");
    XCTAssertEqual([_store.gameData count], 0,
                   @"gameData is not initially empty");
}

- (void)testAddData {
    [_store addData:_data];
    XCTAssertEqual([_store.gameData count], 1,
                   @"data does not get added to gameData array");
    XCTAssertEqualObjects(_store.gameData[0], _data,
                          @"wrong data is added to gameData array");
}

- (void)testRemoveData {
    XCTAssertNoThrow([_store removeData:_data]);
    [_store addData:_data];
    [_store removeData:_data];
    XCTAssertEqual([_store.gameData count], 0);
}

- (void)testMoveData {
    [_store addData:_data];
    [_store addData:_moreData];
    XCTAssertEqualObjects(_store.gameData[0], _data);
    [_store moveDataAtIndex:1 toIndex:0];
    XCTAssertEqualObjects(_store.gameData[0], _moreData,
                          @"Failed to move data to proper index");
}

@end
