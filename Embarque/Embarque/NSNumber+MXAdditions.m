//
//  NSNumber+MXAdditions.m
//  Procon
//
//  Created by Henrique Morbin on 24/02/15.
//  Copyright (c) 2015 Queen Mob. All rights reserved.
//

#import "NSNumber+MXAdditions.h"

@implementation NSNumber (MXAdditions)

- (NSString *)toCurrencyString_BRFormat
{
    BOOL negativo;
    
    if (self.doubleValue < 0) {
        negativo = true;
    }else{
        negativo = false;
    }
    
    NSString *valueFormatted = [NSString stringWithFormat:@"%.2f", fabs(self.doubleValue)];
    NSString *inteiro = [valueFormatted substringToIndex:[valueFormatted rangeOfString:@"."].location];
    NSString *decimal = [valueFormatted substringFromIndex:[valueFormatted rangeOfString:@"."].location+1];
    
    NSMutableString *mutableString = [NSMutableString new];
    for (int i = 1; i < inteiro.length+1; i++) {
        NSString *c = [inteiro substringWithRange:NSMakeRange(inteiro.length-i, 1)];
        if ((i % 3 == 0) && i < inteiro.length) {
            [mutableString insertString:[NSString stringWithFormat:@".%@",c] atIndex:0];
        }else{
            [mutableString insertString:c atIndex:0];
        }
    }
    inteiro = mutableString;
    
    
    valueFormatted = [NSString stringWithFormat:@"%@%@,%@", negativo?@"-":@"", inteiro, decimal];
    
    return valueFormatted;
}

- (NSString *)toCurrencyString_USFormat
{
    return [NSString stringWithFormat:@"%.2f", self.doubleValue];
    
}

@end
