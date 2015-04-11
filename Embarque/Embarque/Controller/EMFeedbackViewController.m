//
//  EMFeedbackViewController.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMFeedbackViewController.h"
#import "EMFeedbackItem.h"

@interface EMFeedbackViewController ()

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellFeedback" forIndexPath:indexPath];
    
    id objeto = [self.arrayFeedbacks objectAtIndex:indexPath.row];
    
    SEL selector = NSSelectorFromString(@"configureWithObject:target:indexPath:");
    IMP imp = [cell methodForSelector:selector];
    void (*func)(id, SEL, id, id, id) = (void *)imp;
    if ([cell respondsToSelector:selector]) {
        func(cell, selector, objeto, self, indexPath);
    }
    
    return cell;
}

#pragma mark - Lazy loading
- (NSArray *)arrayFeedbacks
{
    if (!_arrayFeedbacks) {
        _arrayFeedbacks = @[[EMFeedbackItem newFeedbackItemWithTitle:@"Pontualidade" andImageName:@"Clock"],
                           [EMFeedbackItem newFeedbackItemWithTitle:@"Informação e Atendimento" andImageName:@"Question"],
                           [EMFeedbackItem newFeedbackItemWithTitle:@"Wifi e tomadas" andImageName:@"Wifi"],
                           [EMFeedbackItem newFeedbackItemWithTitle:@"Praça de Alimentação" andImageName:@"Food"],
                           [EMFeedbackItem newFeedbackItemWithTitle:@"Conservação e Limpeza" andImageName:@"TrashCan"],
                           [EMFeedbackItem newFeedbackItemWithTitle:@"Segurança" andImageName:@"Security"]
                           ];
    }
    
    return _arrayFeedbacks;
}
@end
