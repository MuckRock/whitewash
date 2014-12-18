//
//  MRPrototypeTableViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 12/18/14.
//  Copyright (c) 2014 MuckRock. All rights reserved.
//

#import "MRPrototypeTableViewController.h"
#import "MRPrototype.h"

@implementation MRPrototypeTableViewController

@synthesize prototypes;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.prototypes = [[NSMutableArray alloc] init];
    [self loadInitialData];
}

- (void)loadInitialData {
    // Create some prototypes
    MRPrototype *prototype1 = [[MRPrototype alloc] initWithName:@"First Prototype"];
    MRPrototype *prototype2 = [[MRPrototype alloc] initWithName:@"Second Prototype"];
    
    // Add prototypes to list
    [self.prototypes addObject:prototype1];
    [self.prototypes addObject:prototype2];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.prototypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"prototype" forIndexPath:indexPath];
    MRPrototype *prototype = [self.prototypes objectAtIndex:indexPath.row];
    cell.textLabel.text = prototype.name;
    return cell;
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    
}

@end
