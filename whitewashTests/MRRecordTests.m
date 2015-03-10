//
//  MRRecordTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MRRecord.h"

@interface MRRecordTests : XCTestCase

@property (nonatomic) MRRecord *record;
@property (nonatomic) id turn;

@end

@implementation MRRecordTests

- (void)setUp {
    [super setUp];
    _record = [MRRecord newRecord];
    _turn = OCMClassMock([NSObject class]);
}

- (void)tearDown {
    [super tearDown];
    _record = nil;
    _turn = nil;
}

- (void)testNewRecord {
    XCTAssertNotNil(_record, @"newRecord should return a new record");
    XCTAssertEqual(_record.score, 0, @"MRRecord score should start at 0");
    XCTAssertEqual([_record.turns count], 0, @"MRRecord turns should start at 0");
}

- (void)testRecordTurn {
    [_record recordTurn:_turn];
    XCTAssertEqual([_record.turns count], 1,
                   @"recordTurn should add turn to record");
    XCTAssertEqualObjects(_record.turns[0], _turn,
                          @"recordTurn should add the same turn to the record");
}

- (void)testModifyScore {
    [_record modifyScoreBy:10];
    XCTAssertEqual(_record.score, 10,
                   @"Should modify the score by a positive integer");
    [_record modifyScoreBy:-20];
    XCTAssertEqual(_record.score, -10,
                   @"Should modify the score by a negative integer");
}

@end
