//
//  EMDataService.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMDataService.h"
#import "EMAirport.h"
#import "EMSessionManager.h"

@implementation EMDataService


+ (void)getAllAirportsWithCache:(BOOL)cached block:(PFArrayResultBlock)block
{
    PFQuery *query = [PFQuery queryWithClassName:@"Airport"];
    
    if (cached) {
        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }else{
        [query setCachePolicy:kPFCachePolicyNetworkOnly];
    }
    
    
    [query findObjectsInBackgroundWithBlock:block];
}

+ (void)getFeedbacksBySelectedAirportWithBlock:(PFArrayResultBlock)block
{
    PFQuery *query = [PFQuery queryWithClassName:@"Feedback"];
    [query whereKey:@"airport" equalTo:[[EMSessionManager sharedInstance] selectedAirport]];
    [query orderByDescending:@"createdAt"];
    
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    
    [query findObjectsInBackgroundWithBlock:block];
}

@end
