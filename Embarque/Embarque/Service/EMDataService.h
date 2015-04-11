//
//  EMDataService.h
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMDataService : NSObject

+ (void)getAllAirportsWithBlock:(void (^)(NSArray *airports, bool success))blockName;

@end
