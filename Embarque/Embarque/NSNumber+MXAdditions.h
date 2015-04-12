//
//  NSNumber+MXAdditions.h
//  Procon
//
//  Created by Henrique Morbin on 24/02/15.
//  Copyright (c) 2015 Queen Mob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (MXAdditions)

- (NSString *)toCurrencyString_BRFormat;
- (NSString *)toCurrencyString_USFormat;
@end
