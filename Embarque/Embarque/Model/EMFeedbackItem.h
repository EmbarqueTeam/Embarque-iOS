//
//  EMFeedbackItem.h
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FeedbackType) {
    FeedbackTypePunctuality,
    FeedbackTypeInformation,
    FeedbackTypeWifi,
    FeedbackTypeFood,
    FeedbackTypeConservation,
    FeedbackTypeSecurity,
    FeedbackTypeButtonEnviar
};
@class EMFeedback;

@interface EMFeedbackItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *cellIdentifier;
@property (assign, nonatomic) FeedbackType type;

+(instancetype)newFeedbackItemWithType:(FeedbackType)type;

@end
