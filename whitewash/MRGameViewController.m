//
//  MRGameViewController.m
//  Whitewash
//
//  Created by Allan Lasser on 3/9/15.
//  Copyright (c) 2015 MuckRock. All rights reserved.
//

#import "MRGameViewController.h"

#import "MRGame.h"
#import "MRRecord.h"

@interface MRGameViewController ()

@property (nonatomic, strong) MRGame *game;

@end

@implementation MRGameViewController

@synthesize delegate;
@synthesize playerHistory;

- (void)viewDidLoad {
    [super viewDidLoad];
    _game = [[MRGame alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [self.delegate gameViewController:self didCompleteGame:_game.record];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
