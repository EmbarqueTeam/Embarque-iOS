//
//  EMFeedback.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMFeedback.h"

@implementation EMFeedback

@dynamic airport;
@dynamic punctuality;
@dynamic wifi;
@dynamic information;
@dynamic food;
@dynamic conservation;
@dynamic security;
@dynamic company;
@dynamic flight;

+(NSString *)parseClassName
{
    return @"Feedback";
}

@end

