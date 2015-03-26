//
//  MRTurn.h
//  Whitewash
//
//  Created by Allan Lasser on 3/26/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRTurn : NSObject

@property (nonatomic, strong) id move;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger multiplier;

@end
