//
//  MRGameData.h
//  Whitewash
//
//  Created by Allan Lasser on 3/11/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRGameData : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSArray *files;

- (instancetype)initWithName:(NSString *)theName
                        body:(NSString *)theBody
                    andFiles:(NSArray *)theFiles;

@end
