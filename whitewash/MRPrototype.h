//
//  MRPrototype.h
//  Whitewash
//
//  Created by Allan Lasser on 12/18/14.
//  Copyright (c) 2014 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRPrototype : NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)init;
- (instancetype)initWithName:(NSString *)theName;

- (NSString *)description;

@end
