//
//  EMFeedbackViewController.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMFeedbackViewController.h"
#import "EMFeedbackItem.h"
#import "EMCellSend.h"
#import "EMCellFeedback.h"
#import "EMSessionManager.h"
#import "EMFeedback.h"
@interface EMFeedbackViewController () <EMCellSendDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *arrayFeedbacks;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EMFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EMSessionManager sharedInstance] setFeedbackToCreate:[EMFeedback new]];
    [[[EMSessionManager sharedInstance] feedbackToCreate] setAirport:[[EMSessionManager sharedInstance] selectedAirport]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource & Delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayFeedbacks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id objeto = [self.arrayFeedbacks objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[objeto cellIdentifier] forIndexPath:indexPath];
    
    if ([[objeto cellIdentifier] isEqualToString:@"CellSend"]) {
        [(EMCellSend *)cell setDelegate:self];
    }
    
    SEL selector = NSSelectorFromString(@"configureWithObject:target:indexPath:");
    IMP imp = [cell methodForSelector:selector];
    void (*func)(id, SEL, id, id, id) = (void *)imp;
    if ([cell respondsToSelector:selector]) {
        func(cell, selector, objeto, self, indexPath);
    }
    
    return cell;
}

#pragma mark - CellSend Delegate
-(void)cellSend:(EMCellSend *)cellSend didTouchedSend:(UIButton *)btnSend
{
    [[[EMSessionManager sharedInstance] feedbackToCreate] saveEventually];
}

#pragma mark - Lazy loading
- (NSArray *)arrayFeedbacks
{
    if (!_arrayFeedbacks) {
        _arrayFeedbacks = @[[EMFeedbackItem newFeedbackItemWithType:FeedbackTypePunctuality],
                           [EMFeedbackItem newFeedbackItemWithType:FeedbackTypeInformation],
                           [EMFeedbackItem newFeedbackItemWithType:FeedbackTypeWifi],
                           [EMFeedbackItem newFeedbackItemWithType:FeedbackTypeFood],
                           [EMFeedbackItem newFeedbackItemWithType:FeedbackTypeConservation],
                           [EMFeedbackItem newFeedbackItemWithType:FeedbackTypeSecurity],
                           [EMFeedbackItem newFeedbackItemWithType:FeedbackTypeButtonEnviar]
                           ];
    }
    
    return _arrayFeedbacks;
}
@end
