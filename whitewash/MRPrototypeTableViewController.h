//
//  MRPrototypeTableViewController.h
//  Whitewash
//
//  Created by Allan Lasser on 12/18/14.
//  Copyright (c) 2014 MuckRock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRPrototypeTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *prototypes;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
