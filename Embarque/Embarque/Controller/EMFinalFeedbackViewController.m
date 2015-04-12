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
    [self showToast];
    
    [[[EMSessionManager sharedInstance] feedbackToCreate] setCompany:self.textCompany.text];
    [[[EMSessionManager sharedInstance] feedbackToCreate] setFlight:self.textFlight.text];
    
    [[[EMSessionManager sharedInstance] feedbackToCreate] saveEventually];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [MXGoogleAnalytics ga_trackEventWith:@"Feedback Final" action:@"Sent"];
}

- (IBAction)btnSkipTouched:(id)sender
{
    [self showToast];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [MXGoogleAnalytics ga_trackEventWith:@"Feedback Final" action:@"Cancelled"];
}

#pragma mark - Methods
-(void)showToast
{
    [self.view makeToast:@"Feedback enviado com sucesso!"];
}

@end
