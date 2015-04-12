//
//  NSMutableArray+MXAdditions.h
//  Procon
//
//  Created by Henrique Morbin on 28/03/15.
//  Copyright (c) 2015 Queen Mob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MXAdditions)

- (void)mx_sortWithAttribute:(NSString*)attr andAscending:(BOOL)ascending;
- (void)mx_sortWithNumberAttribute:(NSString*)attr andAscending:(BOOL)ascending;

@end
