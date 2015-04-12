//
//  EMAirport.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMAirport.h"
#import "NSString+MXAdditions.h"

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

- (NSString *)getRateAverageString
{
    NSString *result = nil;
    
    if (self.rateAverage) {
        result = self.rateAverage.stringValue;
    }else{
        return @"-";
    }
    
    if ([result contains:@"."]) {
        return result;
    }else{
        return [NSString stringWithFormat:@"%@.0",result];
    }
}
@end
