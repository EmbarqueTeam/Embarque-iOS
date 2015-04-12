//
//  EMSessionManager.h
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMAirport.h"

@class EMFeedback;

@interface EMSessionManager : NSObject

@property (strong,nonatomic) EMAirport *selectedAirport;
@property (strong,nonatomic) EMFeedback *feedbackToCreate;
+(EMSessionManager *)sharedInstance;

@end
