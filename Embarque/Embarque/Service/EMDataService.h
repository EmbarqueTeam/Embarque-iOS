//
//  EMDataService.h
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface EMDataService : NSObject

+ (void)getAllAirportsWithBlock:(PFArrayResultBlock)block;

@end
