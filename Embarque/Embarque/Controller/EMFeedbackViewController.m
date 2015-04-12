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

@interface EMFeedbackViewController () <EMCellSendDelegate>

@property (strong, nonatomic) NSArray *arrayFeedbacks;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EMFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSLog(@"CellSendTouched");
}

#pragma mark - Lazy loading
- (NSArray *)arrayFeedbacks
{
    if (!_arrayFeedbacks) {
        _arrayFeedbacks = @[[EMFeedbackItem newFeedbackItemWithTitle:@"Pontualidade" andImageName:@"Clock" andCellIdentifier:@"CellFeedback"],
                           [EMFeedbackItem newFeedbackItemWithTitle:@"Informação e Atendimento" andImageName:@"Question" andCellIdentifier:@"CellFeedback"],
                           [EMFeedbackItem newFeedbackItemWithTitle:@"Wifi e tomadas" andImageName:@"Wifi" andCellIdentifier:@"CellFeedback"],
                           [EMFeedbackItem newFeedbackItemWithTitle:@"Praça de Alimentação" andImageName:@"Food" andCellIdentifier:@"CellFeedback"],
                           [EMFeedbackItem newFeedbackItemWithTitle:@"Conservação e Limpeza" andImageName:@"TrashCan" andCellIdentifier:@"CellFeedback"],
                           [EMFeedbackItem newFeedbackItemWithTitle:@"Segurança" andImageName:@"Security" andCellIdentifier:@"CellFeedback"],
                           [EMFeedbackItem newFeedbackItemWithTitle:@"Enviar" andImageName:@"Enviar" andCellIdentifier:@"CellSend"]
                           ];
    }
    
    return _arrayFeedbacks;
}
@end
