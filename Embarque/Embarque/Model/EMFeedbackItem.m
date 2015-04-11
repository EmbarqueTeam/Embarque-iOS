//
//  EMFeedbackItem.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMFeedbackItem.h"

@implementation EMFeedbackItem

+(instancetype)newFeedbackItemWithTitle:(NSString *)title andImageName:(NSString *)imageName
{
    EMFeedbackItem *item = [[EMFeedbackItem alloc] init];
    
    item.title = title;
    item.imageName = imageName;
    
    return item;
}
@end
