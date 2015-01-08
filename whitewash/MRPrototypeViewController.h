//
//  MRPrototypeViewController.h
//  Whitewash
//
//  Created by Allan Lasser on 12/18/14.
//  Copyright (c) 2014 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRPrototype.h"

@interface MRPrototypeViewController : UIViewController

@property (nonatomic, weak) MRPrototype *prototype;
@property (nonatomic, weak) IBOutlet UILabel *simpleLabel;

- (IBAction)unwindToPrototype:(UIStoryboardSegue *)segue;

@end
