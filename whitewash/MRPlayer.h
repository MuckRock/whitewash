//
//  MRPlayer.h
//  Whitewash
//
//  Created by Allan Lasser on 3/6/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRPlayer : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *history;

- (instancetype)initWithName:(NSString *)playerName;
+ (MRPlayer *)newPlayerWithName:(NSString *)playerName;

@end
