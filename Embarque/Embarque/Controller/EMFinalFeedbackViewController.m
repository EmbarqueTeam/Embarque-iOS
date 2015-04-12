//
//  EMFinalFeedbackViewController.m
//  Embarque
//
//  Created by Cleber Henriques on 4/12/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMFinalFeedbackViewController.h"
#import "EMSessionManager.h"
#import "EMFeedback.h"

@interface EMFinalFeedbackViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textCompany;
@property (weak, nonatomic) IBOutlet UITextField *textFlight;

@end

@implementation EMFinalFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [MXGoogleAnalytics ga_trackScreen:@"Feedback Final Screen"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions
- (IBAction)btnSendTouched:(id)sender
{
    [[[EMSessionManager sharedInstance] feedbackToCreate] setCompany:self.textCompany.text];
    [[[EMSessionManager sharedInstance] feedbackToCreate] setFlight:self.textFlight.text];
    
    [[[EMSessionManager sharedInstance] feedbackToCreate] saveEventually];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"io.embarque.show_message" object:nil];
    }];
    
    [MXGoogleAnalytics ga_trackEventWith:@"Feedback Final" action:@"Sent"];
}

- (IBAction)btnSkipTouched:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"io.embarque.show_message" object:nil];
    }];
    
    [MXGoogleAnalytics ga_trackEventWith:@"Feedback Final" action:@"Cancelled"];
}

@end
