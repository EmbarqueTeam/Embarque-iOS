//
//  EMSessionManager.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMSessionManager.h"

@implementation EMSessionManager

+(EMSessionManager *)sharedInstance
{
    static EMSessionManager *sharedInstance = nil;
    static dispatch_once_t pred;
    
    if (sharedInstance)
        return sharedInstance;
    
    dispatch_once(&pred, ^{
        sharedInstance = [EMSessionManager alloc];
        sharedInstance = [sharedInstance init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectedAirport = [[EMAirport alloc] init];
        [self.selectedAirport setObjectId:@"5SkclJGjsC"];
    }
    return self;
}

@end
