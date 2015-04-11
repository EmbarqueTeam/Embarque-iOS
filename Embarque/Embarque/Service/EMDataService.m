//
//  EMDataService.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMDataService.h"
#import "EMAirport.h"

@implementation EMDataService


+ (void)getAllAirportsWithBlock:(PFArrayResultBlock)block
{
    PFQuery *query = [PFQuery queryWithClassName:@"Airport"];
    
    [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    
    [query findObjectsInBackgroundWithBlock:block];
}

+ (void)old_getAllAirportsWithBlock:(void (^)(NSArray *airports, bool success))block
{
    PFQuery *query = [PFQuery queryWithClassName:@"Airport"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            block(objects, true);
        } else {
            // Log details of the failure
            if (DEBUG) {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            
            block(nil, false);
        }
    }];
}

@end
