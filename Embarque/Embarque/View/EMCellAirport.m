//
//  EMCellAirport.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMCellAirport.h"
#import "EMAirport.h"
#import <UIImageView+WebCache.h>

@implementation EMCellAirport

-(void)configureWithObject:(id)object target:(id)target indexPath:(NSIndexPath *)indexPath
{
    if (object && [object isKindOfClass:[EMAirport class]]) {
        self.name.text = [(EMAirport *)object name];
        [self.cover sd_setImageWithURL:[(EMAirport *) object coverURL]];
    }
}

@end
