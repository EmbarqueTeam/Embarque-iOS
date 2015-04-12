//
//  EMAirportsViewController.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMAirportsViewController.h"
#import "EMDataService.h"
#import "UIScreen+MXAdditions.h"
#import "EMAirport.h"
#import "EMSessionManager.h"

#define CELL_AIRPORT @"CellAirport"
#define CELL_LOADING @"CellLoadingA"
#define CELL_EMPTY   @"CellEmptyA"

#define SEGUE_TABBAR @"segueTabBar"

@interface EMAirportsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *arrayDataSource;
@property (assign, nonatomic) BOOL isLoading;
@property (assign, nonatomic) BOOL isEmpty;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation EMAirportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayDataSource = [NSMutableArray new];
    [self.arrayDataSource addObject:[NSNull null]];
    
    [self configureCollection];
    [self loadAirports];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [MXGoogleAnalytics ga_trackScreen:@"Airports Screen"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - Methods
- (void)configureCollection
{
    [self.collectionView registerNib:[UINib nibWithNibName:CELL_AIRPORT bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_AIRPORT];
    [self.collectionView registerNib:[UINib nibWithNibName:CELL_LOADING bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_LOADING];
    [self.collectionView registerNib:[UINib nibWithNibName:CELL_EMPTY bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_EMPTY];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(startRefresh)
             forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
    
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
}

- (void)startRefresh
{
    [self loadAirportsWithCache:NO];
}

- (void)loadAirports
{
    [self loadAirportsWithCache:YES];
}

- (void)loadAirportsWithCache:(BOOL)cached
{
    self.isLoading = TRUE;
    
    [EMDataService getAllAirportsWithCache:cached block:^(NSArray *objects, NSError *error) {
        if (error) {
            if (DEBUG) {
                NSLog(@"%@", error.localizedDescription);
            }
        }
        
        [self.arrayDataSource removeAllObjects];
        
        if (objects && objects.count > 0) {
            [self.arrayDataSource addObjectsFromArray:objects];
            self.isEmpty = FALSE;
        }else{
            [self.arrayDataSource addObject:[NSNull null]];
            self.isEmpty = TRUE;
        }

        
        [self.collectionView reloadData];
        
        self.isLoading = FALSE;
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate
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
    EMAirport *airport = self.arrayDataSource[indexPath.row];
    [[EMSessionManager sharedInstance] setSelectedAirport:airport];
    
    [self performSegueWithIdentifier:SEGUE_TABBAR
                              sender:nil];
    
    [MXGoogleAnalytics ga_trackEventWith:@"Airports" action:@"Airport Selected" label:airport.name];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isLoading && !self.isEmpty) {
        
        CGSize size = [[UIScreen mainScreen] mx_contextSize];
        
        if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
            return CGSizeMake(size.width, 100.0f);
        }else{
            return CGSizeMake(size.height, 100.0f);
        }
    }else{
        return CGSizeMake(320.0f, 100.0f);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

@end
