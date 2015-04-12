//
//  EMFeedViewController.m
//  Embarque
//
//  Created by Henrique Morbin on 11/04/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMFeedViewController.h"
#import "EMDataService.h"
#import "EMAirport.h"
#import "EMSessionManager.h"

#define CELL_LOADING @"CellLoadingB"
#define CELL_EMPTY   @"CellEmptyB"
#define CELL_HISTORY @"CellHistoric"

@interface EMFeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayDataSource;
@property (assign, nonatomic) BOOL isLoading;
@property (assign, nonatomic) BOOL isEmpty;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) EMAirport *airport;

@end

@implementation EMFeedViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.arrayDataSource = [[NSMutableArray alloc] init];
    [self.arrayDataSource addObject:[NSNull null]];
    
    [self configureTable];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(barButtonPlusTouched:)];
    [self.tabBarController.navigationItem setRightBarButtonItem:barButton];
    
    [self loadFeedbacks];
    
    self.tabBarController.navigationItem.title = self.airport.name;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [MXGoogleAnalytics ga_trackScreen:@"History Screen"];
}

#pragma mark - Actions
- (IBAction)barButtonPlusTouched:(id)sender
{
    UIStoryboard *feedbackStoryboard = [UIStoryboard storyboardWithName:@"Feedback" bundle:[NSBundle mainBundle]];
    UINavigationController *navFeedback = [feedbackStoryboard instantiateViewControllerWithIdentifier:@"FeedbackNavigationController"];
    [self presentViewController:navFeedback animated:YES completion:nil];
    
    [MXGoogleAnalytics ga_trackEventWith:@"History" action:@"Plus Selected"];
}

#pragma mark - Methods
- (void)configureTable
{
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [self.tableView registerNib:[UINib nibWithNibName:CELL_LOADING bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:CELL_LOADING];
    [self.tableView registerNib:[UINib nibWithNibName:CELL_EMPTY bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:CELL_EMPTY];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(startRefresh)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}

- (void)startRefresh
{
    [self loadFeedbacks];
}

- (void)loadFeedbacks
{
    self.isLoading = TRUE;
    
    
    [EMDataService getFeedbacksBySelectedAirportWithBlock:^(NSArray *objects, NSError *error) {
                                                        if (error) {
                                                            if (DEBUG) {
                                                                NSLog(@"%@", error.localizedDescription);
                                                            }
                                                        }
                                                        
                                                        [self.arrayDataSource removeAllObjects];
                                                        
                                                        if (objects && objects.count > 1) {
                                                            [self.arrayDataSource addObjectsFromArray:objects];
                                                            self.isEmpty = FALSE;
                                                        }else{
                                                            [self.arrayDataSource addObject:[NSNull null]];
                                                            self.isEmpty = TRUE;
                                                        }
                                                        
                                                        
                                                        [self.tableView reloadData];
                                                        
                                                        self.isLoading = FALSE;
                                                        [self.refreshControl endRefreshing];
                                                    }];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;

    if (self.isLoading) {
        identifier = CELL_LOADING;
    }else if (self.isEmpty){
        identifier = CELL_EMPTY;
    }else{
        identifier = CELL_HISTORY;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                            forIndexPath:indexPath];

    id objeto = [self.arrayDataSource objectAtIndex:indexPath.row];
    
    
    SEL selector = NSSelectorFromString(@"configureWithObject:target:indexPath:");
    IMP imp = [cell methodForSelector:selector];
    void (*func)(id, SEL, id, id, id) = (void *)imp;
    if ([cell respondsToSelector:selector]) {
        func(cell, selector, objeto, self, indexPath);
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 133.0f;
}

#pragma mark - Lazy loading
- (EMAirport *)airport
{
    if (!_airport) {
        _airport = [[EMSessionManager sharedInstance] selectedAirport];
    }
    
    return _airport;
}
@end
