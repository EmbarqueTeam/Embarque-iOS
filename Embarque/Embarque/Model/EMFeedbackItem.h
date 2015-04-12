//
//  EMFeedbackItem.h
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMFeedbackItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *cellIdentifier;

+(instancetype)newFeedbackItemWithTitle:(NSString *)title andImageName:(NSString *)imageName andCellIdentifier:(NSString *)cellIdentifier;

@end
