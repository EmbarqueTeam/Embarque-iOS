//
//  NSMutableArray+MXAdditions.m
//  Procon
//
//  Created by Henrique Morbin on 28/03/15.
//  Copyright (c) 2015 Queen Mob. All rights reserved.
//

#import "NSMutableArray+MXAdditions.h"

@implementation NSMutableArray (MXAdditions)

- (void)mx_sortWithAttribute:(NSString*)attr andAscending:(BOOL)ascending
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attr ascending:ascending];
    [self sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (void)mx_sortWithNumberAttribute:(NSString*)attr andAscending:(BOOL)ascending
{
    NSSortDescriptor *aSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:attr ascending:ascending comparator:^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    [self sortUsingDescriptors:[NSArray arrayWithObject:aSortDescriptor]];
}

@end
