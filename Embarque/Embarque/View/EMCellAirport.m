//
//  EMCellAirport.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMCellAirport.h"
#import "EMAirport.h"

@implementation EMCellAirport

-(void)configureWithObject:(id)object target:(id)target indexPath:(NSIndexPath *)indexPath
{
    if (object && [object isKindOfClass:[EMAirport class]]) {
        EMAirport *airport = object;
        
        NSDictionary *attributesTitle = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont fontWithName:@"HelveticaNeue-Light" size:26], NSFontAttributeName,
                                       [UIColor whiteColor], NSForegroundColorAttributeName, nil];
        NSDictionary *attributesSubtitle = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont fontWithName:@"HelveticaNeue-Light" size:20], NSFontAttributeName,
                                       [UIColor whiteColor], NSForegroundColorAttributeName, nil];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                       initWithString:[airport name]
                                                       attributes:attributesTitle];
        
        [attributedString appendAttributedString:[[NSMutableAttributedString alloc]
                                                  initWithString:@"\n"]];
        
        [attributedString appendAttributedString:[[NSMutableAttributedString alloc]
                                                  initWithString:[airport city]
                                                  attributes:attributesSubtitle]];
        
        [self.name setAttributedText:attributedString];
        
        if (airport.coverURL) {
            [self.cover sd_setImageWithURL:[(EMAirport *) object coverURL]];
        }
    }
}

@end
