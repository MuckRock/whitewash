//
//  MRPrototypeTableViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 12/18/14.
//  Copyright (c) 2014 MuckRock. All rights reserved.
//

#import "MRPrototypeTableViewController.h"
#import "MRPrototypeViewController.h"
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
    MRPrototype *prototype1 = [[MRPrototype alloc] initWithName:@"First Prototype" andValue:[NSNumber numberWithInt:1]];
    MRPrototype *prototype2 = [[MRPrototype alloc] initWithName:@"Second Prototype" andValue:[NSNumber numberWithInt:2]];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrototypePrototypeCell" forIndexPath:indexPath];
    MRPrototype *prototype = [self.prototypes objectAtIndex:indexPath.row];
    cell.textLabel.text = prototype.name;
    return cell;
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PrototypeViewControllerSegue"]) {
        MRPrototypeViewController *prototypeView = [segue destinationViewController];
        MRPrototype *prototype = [self.prototypes objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        prototypeView.prototype = prototype;
    }
}

@end
