//
//  MRGameData.m
//  Whitewash
//
//  Created by Allan Lasser on 3/11/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGameData.h"

@implementation MRGameData

@synthesize name;
@synthesize body;
@synthesize files;

- (instancetype)init {
    return [self initWithName:@"Empty Data" body:@"" andFiles:@[]];
}

- (instancetype)initWithName:(NSString *)theName body:(NSString *)theBody andFiles:(NSArray *)theFiles {
    self = [super init];
    if (self) {
        self.name = theName;
        self.body = theBody;
        self.files = theFiles;
    }
    return self;
}

@end
