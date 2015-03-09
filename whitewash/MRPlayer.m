//
//  MRPlayer.m
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRPlayer.h"
#import "MRRecord.h"

@interface MRPlayer ()

@property (nonatomic, strong) NSMutableArray *mutableHistory;

@end

@implementation MRPlayer

@synthesize name;

- (instancetype)init {
    return [self initWithName:@"New Player"];
}

- (instancetype)initWithName:(NSString *)playerName {
    self = [super init];
    if (self) {
        self.name = playerName;
        self.mutableHistory = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (MRPlayer *)newPlayerWithName:(NSString *)playerName {
    return [[MRPlayer alloc] initWithName:playerName];
}

# pragma mark - History

- (NSArray *)history {
    return [self.mutableHistory copy];
}

- (void)addRecordToHistory:(MRRecord *)record {
    [self.mutableHistory addObject:record];
}

- (void)removeRecordFromHistory:(MRRecord *)record {
    [self.mutableHistory removeObject:record];
}

@end