//
//  NSString+MXAdditions.h
//  Morbix
//
//  Created by Henrique Morbin on 26/07/14.
//  Copyright (c) 2014 Henrique Morbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MXAdditions)

- (CGSize)sizeOfTextWithFont:(UIFont *)font height:(float)height;
- (CGSize)sizeOfTextWithFont:(UIFont *)font width:(float)width;
- (float)widthOfTextWithFont:(UIFont *)font height:(float)height minWidth:(float)minWidth;
- (float)heightOfTextWithFont:(UIFont *)font width:(float)width minHeight:(float)minHeight;
- (BOOL)contains:(NSString*)string;
- (NSString*)add:(NSString*)string;
- (NSDictionary*)firstAndLastName;
- (BOOL)isValidEmail;
- (BOOL)isValidCPF;
- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (NSString*)safeSubstringToIndex:(NSUInteger)index;
- (NSString*)stringByRemovingPrefix:(NSString*)prefix;
- (NSString*)stringByRemovingPrefixes:(NSArray*)prefixes;
- (BOOL)hasPrefixes:(NSArray*)prefixes;
- (BOOL)isEqualToOneOf:(NSArray*)strings;
- (BOOL)isBlank;
- (BOOL)isNotBlank;
- (NSString *)asciiDecoded;
- (NSString *)trimm;
- (NSString *)cleanMask;
@end