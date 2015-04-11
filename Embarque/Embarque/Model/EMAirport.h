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

@end
