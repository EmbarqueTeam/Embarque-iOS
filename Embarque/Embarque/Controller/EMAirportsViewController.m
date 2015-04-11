//
//  EMAirportsViewController.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMAirportsViewController.h"
#import "EMDataService.h"
@interface EMAirportsViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation EMAirportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellNib];
    [self loadAirports];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellAirport" forIndexPath:indexPath];
    
    id objeto = [self.dataSource objectAtIndex:indexPath.row];
    
    SEL selector = NSSelectorFromString(@"configureWithObject:target:indexPath:");
    IMP imp = [cell methodForSelector:selector];
    void (*func)(id, SEL, id, id, id) = (void *)imp;
    if ([cell respondsToSelector:selector]) {
        func(cell, selector, objeto, self, indexPath);
    }
    
    return cell;
}

-(void)registerCellNib
{
    [self.collectionView registerNib:[UINib nibWithNibName:@"CellAirport" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CellAirport"];
}

- (void)loadAirports
{
    [EMDataService getAllAirportsWithBlock:^(NSArray *airports, bool success) {
        self.dataSource = airports;
        [self.collectionView reloadData];
    }];
}
@end
