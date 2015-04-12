//
//  EMFeedViewController.m
//  Embarque
//
//  Created by Henrique Morbin on 11/04/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMFeedViewController.h"
#import "EMDataService.h"

@interface EMFeedViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayDataSource;

@end

@implementation EMFeedViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    self.arrayDataSource = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(barButtonPlusTouched:)];
    [self.tabBarController.navigationItem setRightBarButtonItem:barButton];
    
    [self loadFeedbacksWithCache:YES];
}

#pragma mark - Actions
- (IBAction)barButtonPlusTouched:(id)sender
{
    UIStoryboard *feedbackStoryboard = [UIStoryboard storyboardWithName:@"Feedback" bundle:[NSBundle mainBundle]];
    UINavigationController *navFeedback = [feedbackStoryboard instantiateViewControllerWithIdentifier:@"FeedbackNavigationController"];
    [self presentViewController:navFeedback animated:YES completion:nil];
}

#pragma mark - Datasour
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellHistoric" forIndexPath:indexPath];
    
    id objeto = [self.arrayDataSource objectAtIndex:indexPath.row];
    
    SEL selector = NSSelectorFromString(@"configureWithObject:target:indexPath:");
    IMP imp = [cell methodForSelector:selector];
    void (*func)(id, SEL, id, id, id) = (void *)imp;
    if ([cell respondsToSelector:selector]) {
        func(cell, selector, objeto, self, indexPath);
    }
    
    return cell;
}

- (void)loadFeedbacksWithCache:(BOOL)cached
{
    [EMDataService getFeedbacksBySelectedAirportWithCache:cached
                                                    block:^(NSArray *objects, NSError *error) {
                                                        if (error) {
                                                            if (DEBUG) {
                                                                NSLog(@"%@", error.localizedDescription);
                                                            }
                                                        }
                                                        
                                                        [self.arrayDataSource removeAllObjects];
                                                        
                                                        [self.arrayDataSource addObjectsFromArray:objects];
                                                        
                                                        [self.tableView reloadData];
                                                    }];
}
@end
