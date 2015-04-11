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

+(NSString *)parseClassName
{
    return @"Airport";
}

@end
