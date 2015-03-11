//
//  MRGameDataStoreTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MRGameDataStore.h"

@interface MRGameDataStoreTests : XCTestCase

@property (nonatomic) MRGameDataStore *store;
@property (nonatomic) id data;
@property (nonatomic) id moreData;

@end

@implementation MRGameDataStoreTests

- (void)setUp {
    [super setUp];
    _store = [[MRGameDataStore alloc] init];
    _data = OCMClassMock([NSObject class]);
    _moreData = OCMClassMock([NSObject class]);
}

- (void)tearDown {
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
    XCTAssertNotNil(_store.data,
                    @"GameDataStore fails to create gameData array on init");
    XCTAssertEqual([_store.data count], 0,
                   @"gameData is not initially empty");
}

- (void)testAddData {
    [_store addData:_data];
    XCTAssertEqual([_store.data count], 1,
                   @"data does not get added to gameData array");
    XCTAssertEqualObjects(_store.data[0], _data,
                          @"wrong data is added to gameData array");
}

- (void)testRemoveData {
    XCTAssertNoThrow([_store removeData:_data]);
    [_store addData:_data];
    [_store removeData:_data];
    XCTAssertEqual([_store.data count], 0);
}

- (void)testMoveData {
    [_store addData:_data];
    [_store addData:_moreData];
    XCTAssertEqualObjects(_store.data[0], _data);
    [_store moveDataAtIndex:1 toIndex:0];
    XCTAssertEqualObjects(_store.data[0], _moreData,
                          @"Failed to move data to proper index");
}

- (void)testPopData {
    [_store addData:_data];
    [_store addData:_moreData];
    id data = [_store popData];
    XCTAssertEqualObjects(data, _moreData,
                          @"Popping data should return the last item added");
    XCTAssertEqual([_store.data count], 1,
                   @"Popping data from the store should remove it from the stack");
}

- (void)testPopDataFromEmptyStore {
    XCTAssertThrows([_store popData],
                    @"Should throw an error if trying to pop from an empty store");
}

@end
