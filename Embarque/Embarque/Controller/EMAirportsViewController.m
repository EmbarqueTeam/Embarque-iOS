//
//  EMAirportsViewController.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMAirportsViewController.h"
#import "EMDataService.h"

#define CELL_AIRPORT @"CellAirport"
#define SEGUE_FEED   @"FeedSegue"

@interface EMAirportsViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *arrayDataSource;
@property (assign, nonatomic) BOOL isLoading;

@end

@implementation EMAirportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayDataSource = [NSMutableArray new];
    
    [self registerCellNib];
    [self loadAirports];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Methods
- (void)registerCellNib
{
    [self.collectionView registerNib:[UINib nibWithNibName:CELL_AIRPORT bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_AIRPORT];
}

- (void)loadAirports
{
    self.isLoading = TRUE;
    
    [EMDataService getAllAirportsWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.arrayDataSource removeAllObjects];
            [self.arrayDataSource addObjectsFromArray:objects];

            [self.collectionView reloadData];
        }else{
            if (DEBUG) {
                NSLog(@"%@", error.localizedDescription);
            }
        }
        
        self.isLoading = FALSE;
    }];
}

#pragma mark - UICollectionView DataSource and Delegates
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrayDataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_AIRPORT
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:SEGUE_FEED
                              sender:nil];
}

@end
