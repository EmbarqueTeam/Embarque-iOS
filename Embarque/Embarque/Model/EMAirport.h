//
//  EMAirport.h
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import <Parse/Parse.h>

@interface EMAirport : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) PFGeoPoint *location;
@property (strong, nonatomic) PFFile *cover;
@property (strong, nonatomic) NSNumber *rateAverage;
@property (strong, nonatomic) NSNumber *conservation;
@property (strong, nonatomic) NSNumber *food;
@property (strong, nonatomic) NSNumber *information;
@property (strong, nonatomic) NSNumber *punctuality;
@property (strong, nonatomic) NSNumber *security;
@property (strong, nonatomic) NSNumber *wifi;

-(NSURL *)coverURL;
- (NSString *)getRateAverageString;

@end
