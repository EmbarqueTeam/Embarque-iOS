//
//  UIScreen+MXAdditions.m
//  Kick Up Gravities
//
//  Created by Henrique Morbin on 28/03/15.
//  Copyright (c) 2015 Morbix. All rights reserved.
//

#import "UIScreen+MXAdditions.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@implementation UIScreen (MXAdditions)

- (CGRect)mx_contextBounds
{
    CGRect originalBound  = [[UIScreen mainScreen] bounds];
    
//    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
//        return originalBound;
//    }
    
    CGSize originalSize   = originalBound.size;
    CGPoint originalPoint = originalBound.origin;
    
    CGFloat screenHeight;
    CGFloat screenWidth;
    
    if (originalSize.width > originalSize.height){
        screenHeight = originalSize.width;
        screenWidth = originalSize.height;
    }else{
        screenHeight = originalSize.height;
        screenWidth = originalSize.width;
    }
    
    return CGRectMake(originalPoint.x,
                      originalPoint.y,
                      screenWidth,
                      screenHeight);
}

- (CGSize)mx_contextSize
{
    return [self mx_contextBounds].size;
}

- (CGPoint)mx_contextPoint
{
    return [self mx_contextBounds].origin;
}

@end
