//
//  MRPrototypeViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 12/18/14.
//  Copyright (c) 2014 MuckRock. All rights reserved.
//

#import "MRPrototypeViewController.h"
#import "MRPrototype.h"

@implementation MRPrototypeViewController

@synthesize prototype, simpleLabel;

- (IBAction)unwindToPrototype:(UIStoryboardSegue *)segue {
    
}

- (void)viewDidLoad {
    if (self.prototype) {
        NSLog([prototype description]);
        self.simpleLabel.text = [self.prototype.simpleValue stringValue];
    }
}

@end
