//
//  EMAirport.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMAirport.h"

@implementation EMAirport

@dynamic name;
@dynamic city;
@dynamic location;
@dynamic cover;
@dynamic rateAverage;
@dynamic conservation;
@dynamic food;
@dynamic information;
@dynamic punctuality;
@dynamic security;
@dynamic wifi;

+(NSString *)parseClassName
{
    return @"Airport";
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"[AIRPORT] %@ - %@", self.name, self.city];
}

-(NSURL *)coverURL
{
    if (self.cover) {
        return [NSURL URLWithString:self.cover.url];
    }
    
    return nil;
}
@end
