//
//  MRRulesetTests.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "MRRuleset.h"
#import "MRTurn.h"

@interface MRRulesetTests : XCTestCase

@property (nonatomic) MRRuleset *ruleset;

@end

@implementation MRRulesetTests

- (void)setUp {
    [super setUp];
    NSPredicate *swipeLeft = [NSPredicate predicateWithFormat:@"move == 'Left'"];
    NSPredicate *swipeRight = [NSPredicate predicateWithFormat:@"move == 'Right'"];
    self.ruleset = [MRRuleset rulesetWithRules:@[swipeLeft, swipeRight]];
}

- (void)testValidateMoveForValidMove {
    NSString *move = @"Left";
    MRTurn *turn = [self.ruleset validateMove:move];
    XCTAssertNotNil(turn);
}

- (void)testValidateMoveForInvalidMove {
    NSString *move = @"Up";
    MRTurn *turn = [self.ruleset validateMove:move];
    XCTAssertNil(turn);
}

- (void)tearDown {
    [super tearDown];
    self.ruleset = nil;
}

@end
