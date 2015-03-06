//
//  MRRecordTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MRRecord.h"

@interface MRRecordTests : XCTestCase

@end

@implementation MRRecordTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit {
    MRRecord *record = [[MRRecord alloc] init];
    XCTAssertNotNil(record, @"MRRecord fails to initialize");
}

- (void)testNewRecord {
    MRRecord *record = [MRRecord newRecord];
    XCTAssertNotNil(record, @"newRecord fails to return a new record");
}

- (void)testScore {
    MRRecord *record = [MRRecord newRecord];
    XCTAssertEqual(record.score, 0, @"MRRecord score does not start at 0");
}

- (void)testTurns {
    MRRecord *record = [MRRecord newRecord];
    XCTAssertEqual([record.turns count], 0, @"MRRecord turns does not start at 0");
}

- (void)testRecordTurn {
    MRRecord *record = [MRRecord newRecord];
    NSObject *turn = [[NSObject alloc] init];
    [record recordTurn:turn];
    XCTAssertEqual([record.turns count], 1, @"recordTurn fails to add turn to record");
    XCTAssertEqualObjects(record.turns[0], turn, @"recordTurn fails to add the correct turn to the record");
}

- (void)testModifyScore {
    MRRecord *record = [MRRecord newRecord];
    [record modifyScoreBy:10];
    XCTAssertEqual(record.score, 10, @"modifyScore fails to modify the score by a positive integer");
    [record modifyScoreBy:-20];
    XCTAssertEqual(record.score, -10, @"modifyScore fails to modify the score by a negative integer");
}

@end
