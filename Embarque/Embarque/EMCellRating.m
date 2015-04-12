//
//  EMCellRating.m
//  Embarque
//
//  Created by Henrique Morbin on 12/04/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMCellRating.h"
#import "EMAirport.h"

@implementation EMCellRating

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithObject:(id)object target:(id)target indexPath:(NSIndexPath *)indexPath
{
    if (object && [object isKindOfClass:[EMAirport class]]) {
        EMAirport *airport = object;
        
        self.labelRating.text = [airport getRateAverageString];
    }
}

@end
