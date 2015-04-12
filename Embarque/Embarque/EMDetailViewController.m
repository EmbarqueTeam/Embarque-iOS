//
//  EMDetailViewController.m
//  Embarque
//
//  Created by Henrique Morbin on 12/04/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMDetailViewController.h"
#import "EMFeedbackItem.h"
#import "EMAirport.h"
#import "EMSessionManager.h"

#define CELL_FEEDBACK @"CellFeedback"
#define CELL_RATING @"CellRating"

@interface EMDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *arrayFeedbacks;
@property (strong, nonatomic) EMAirport *airport;

@end

@implementation EMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(barButtonPlusTouched:)];
    [self.tabBarController.navigationItem setRightBarButtonItem:barButton];
    
    self.tabBarController.navigationItem.title = self.airport.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)barButtonPlusTouched:(id)sender {
    UIStoryboard *feedbackStoryboard = [UIStoryboard storyboardWithName:@"Feedback" bundle:[NSBundle mainBundle]];
    UINavigationController *navFeedback = [feedbackStoryboard instantiateViewControllerWithIdentifier:@"FeedbackNavigationController"];
    [self presentViewController:navFeedback animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.arrayFeedbacks.count;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = nil;
    id object = nil;
    
    if (indexPath.section == 0) {
        identifier = CELL_FEEDBACK;
        object = self.arrayFeedbacks[indexPath.row];
    }else{
        identifier = CELL_RATING;
        object = self.airport;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                            forIndexPath:indexPath];
    
    
    SEL selector = NSSelectorFromString(@"configureWithObject:target:indexPath:");
    IMP imp = [cell methodForSelector:selector];
    void (*func) (id, SEL, id, id, id) = (void *)imp;
    
    if ([cell respondsToSelector:selector]){
        func(cell, selector, object, self, indexPath);
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90.0f;
    }else{
        return 120.0f;
    }
}


#pragma mark - Lazy loading
- (EMAirport *)airport
{
    if (!_airport) {
        _airport = [[EMSessionManager sharedInstance] selectedAirport];
    }
    
    return _airport;
}

- (NSArray *)arrayFeedbacks
{
    if (!_arrayFeedbacks) {
        _arrayFeedbacks = @[[EMFeedbackItem newFeedbackItemWithType:FeedbackTypePunctuality
                                                             rating:self.airport.punctuality],
                            [EMFeedbackItem newFeedbackItemWithType:FeedbackTypeInformation
                                                             rating:self.airport.information],
                            [EMFeedbackItem newFeedbackItemWithType:FeedbackTypeWifi
                                                             rating:self.airport.wifi],
                            [EMFeedbackItem newFeedbackItemWithType:FeedbackTypeFood
                                                             rating:self.airport.food],
                            [EMFeedbackItem newFeedbackItemWithType:FeedbackTypeConservation
                                                             rating:self.airport.conservation],
                            [EMFeedbackItem newFeedbackItemWithType:FeedbackTypeSecurity
                                                             rating:self.airport.security]
                            ];
    }
    
    return _arrayFeedbacks;
}
@end
