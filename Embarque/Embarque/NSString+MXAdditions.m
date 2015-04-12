//
//  NSString+MXAdditions.m
//  Morbix
//
//  Created by Henrique Morbin on 26/07/14.
//  Copyright (c) 2014 Henrique Morbin. All rights reserved.
//

#import "NSString+MXAdditions.h"

@implementation NSString (MXAdditions)

- (CGSize)sizeOfTextWithFont:(UIFont *)font height:(float)height
{
    NSDictionary *att = @{NSFontAttributeName:font};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:att
                                     context:nil];
    
    return rect.size;
}

- (CGSize)sizeOfTextWithFont:(UIFont *)font width:(float)width
{
    NSDictionary *att = @{NSFontAttributeName:font};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:att
                                     context:nil];
    
    return rect.size;
}

- (float)heightOfTextWithFont:(UIFont *)font width:(float)width minHeight:(float)minHeight
{
    return MAX(minHeight, [self sizeOfTextWithFont:font width:width].height+4);
}

- (float)widthOfTextWithFont:(UIFont *)font height:(float)height minWidth:(float)minWidth
{
    return MAX(minWidth, [self sizeOfTextWithFont:font height:height].width+4);
}
- (BOOL)contains:(NSString*)string {
    return [self rangeOfString:string].location != NSNotFound;
}

#define MaxEmailLength 254
- (BOOL)isValidEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL validEmail = [emailTest evaluateWithObject:self];
    if(validEmail && self.length <= MaxEmailLength)
        return YES;
    return NO;
}

- (BOOL)isValidCPF
{
    NSString *cpf = self;
    
    NSUInteger i, firstSum, secondSum, firstDigit, secondDigit, firstDigitCheck, secondDigitCheck;
    if(cpf == nil) return NO;
    
    if ([cpf length] != 11) return NO;
    if (([cpf isEqual:@"00000000000"]) || ([cpf isEqual:@"11111111111"]) || ([cpf isEqual:@"22222222222"])|| ([cpf isEqual:@"33333333333"])|| ([cpf isEqual:@"44444444444"])|| ([cpf isEqual:@"55555555555"])|| ([cpf isEqual:@"66666666666"])|| ([cpf isEqual:@"77777777777"])|| ([cpf isEqual:@"88888888888"])|| ([cpf isEqual:@"99999999999"])) return NO;
    
    firstSum = 0;
    for (i = 0; i <= 8; i++) {
        firstSum += [[cpf substringWithRange:NSMakeRange(i, 1)] intValue] * (10 - i);
    }
    
    if (firstSum % 11 < 2)
        firstDigit = 0;
    else
        firstDigit = 11 - (firstSum % 11);
    
    secondSum = 0;
    for (i = 0; i <= 9; i++) {
        secondSum = secondSum + [[cpf substringWithRange:NSMakeRange(i, 1)] intValue] * (11 - i);
    }
    
    if (secondSum % 11 < 2)
        secondDigit = 0;
    else
        secondDigit = 11 - (secondSum % 11);
    
    firstDigitCheck = [[cpf substringWithRange:NSMakeRange(9, 1)] intValue];
    secondDigitCheck = [[cpf substringWithRange:NSMakeRange(10, 1)] intValue];
    
    if ((firstDigit == firstDigitCheck) && (secondDigit == secondDigitCheck))
        return YES;
    return NO;
}

- (NSString*)add:(NSString*)string
{
    if(!string || string.length == 0)
        return self;
    return [self stringByAppendingString:string];
}

- (NSDictionary*)firstAndLastName
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSArray *comps = [self componentsSeparatedByString:@" "];
    if(comps.count > 0) dic[@"firstName"] = comps[0];
    if(comps.count > 1) dic[@"lastName"] = comps[1];
    return dic;
}

- (BOOL)containsOnlyLetters
{
    NSCharacterSet *blockedCharacters = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
}

- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbers = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbers].location == NSNotFound);
}

- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *blockedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
}

- (NSString*)safeSubstringToIndex:(NSUInteger)index
{
    if(index >= self.length)
        index = self.length - 1;
    return [self substringToIndex:index];
}

- (NSString*)stringByRemovingPrefix:(NSString*)prefix
{
    NSRange range = [self rangeOfString:prefix];
    if(range.location == 0) {
        return [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}

- (NSString*)stringByRemovingPrefixes:(NSArray*)prefixes
{
    for(NSString *prefix in prefixes) {
        NSRange range = [self rangeOfString:prefix];
        if(range.location == 0) {
            return [self stringByReplacingCharactersInRange:range withString:@""];
        }
    }
    return self;
}

- (BOOL)hasPrefixes:(NSArray*)prefixes
{
    for(NSString *prefix in prefixes) {
        if([self hasPrefix:prefix])
            return YES;
    }
    return NO;
}

- (BOOL)isEqualToOneOf:(NSArray*)strings
{
    for(NSString *string in strings) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isBlank
{
    return [self isEqualToString:@""];
}

- (BOOL)isNotBlank
{
    return ![self isEqualToString:@""];
}

- (NSString *)asciiDecoded
{
    NSString *string = self;
    string = [string stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
    string = [string stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    return string;
}

- (NSString *)trimm
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)cleanMask
{
    NSArray *arrayOfChars = @[@"-", @"/", @".", @"(", @")", @"|", @","];
    
    NSString *result = self;
    
    for (NSString *ch in arrayOfChars) {
        result = [result stringByReplacingOccurrencesOfString:ch withString:@""];
    }
    
    return result;
}
@end
