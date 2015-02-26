//
//  MRCommunication.h
//  Whitewash
//
//  Created by Allan Lasser on 2/19/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRCommunication : NSObject <NSCopying>

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *message;
@property (nonatomic) NSUInteger attachments;

- (instancetype)initFromJSON:(NSDictionary *)json; // Designated initializer:
                                                   // MRCommunication should be
                                                   // initialized from a JSON
                                                   // item from the MuckRock API

@end
