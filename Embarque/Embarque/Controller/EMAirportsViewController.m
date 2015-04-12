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
#define CELL_LOADING @"CellLoadingA"
#define CELL_EMPTY   @"CellEmptyA"

#define SEGUE_FEED   @"FeedSegue"

@interface EMAirportsViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *arrayDataSource;
@property (assign, nonatomic) BOOL isLoading;
@property (assign, nonatomic) BOOL isEmpty;

@end

@implementation EMAirportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayDataSource = [NSMutableArray new];
    [self.arrayDataSource addObject:[NSNull null]];
    
    [self registerCellNib];
    //[self loadAirports];
    
    self.isLoading = true;
    [self performSelector:@selector(loadAirports) withObject:nil afterDelay:3.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Methods
- (void)registerCellNib
{
    [self.collectionView registerNib:[UINib nibWithNibName:CELL_AIRPORT bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_AIRPORT];
    [self.collectionView registerNib:[UINib nibWithNibName:CELL_LOADING bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_LOADING];
    [self.collectionView registerNib:[UINib nibWithNibName:CELL_EMPTY bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_EMPTY];
}

- (void)loadAirports
{
    self.isLoading = TRUE;
    
    [EMDataService getAllAirportsWithBlock:^(NSArray *objects, NSError *error) {
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

        [self.collectionView reloadData];
        
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
    NSString *identifier = nil;
    
    if (self.isLoading) {
        identifier = CELL_LOADING;
    }else if (self.isEmpty){
        identifier = CELL_EMPTY;
    }else{
        identifier = CELL_AIRPORT;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
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
