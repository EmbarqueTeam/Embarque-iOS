//
//  EMFeedback.h
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import <Parse/Parse.h>

@class EMAirport;

@interface EMFeedback : PFObject <PFSubclassing>

@property (strong, nonatomic) EMAirport *airport;
@property (strong, nonatomic) NSNumber *punctuality;
@property (strong, nonatomic) NSNumber *information;
@property (strong, nonatomic) NSNumber *wifi;
@property (strong, nonatomic) NSNumber *food;
@property (strong, nonatomic) NSNumber *conservation;
@property (strong, nonatomic) NSNumber *security;

@end
