//
//  CellHistoric.m
//  Embarque
//
//  Created by Cleber Henriques on 4/12/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "CellHistoric.h"
#import "EMFeedback.h"
@implementation CellHistoric

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configureWithObject:(id)object target:(id)target indexPath:(NSIndexPath *)indexPath
{
    if (object && [object isKindOfClass:[EMFeedback class]]) {
        
        EMFeedback *feedback = object;
        
        self.labelCompany.text = feedback.company;
        self.labelRatingPunctuality.text = [NSString stringWithFormat:@"%@", feedback.punctuality];
        self.labelRatingFood.text = [NSString stringWithFormat:@"%@", feedback.food];
        self.labelRatingInformation.text = [NSString stringWithFormat:@"%@", feedback.information];
        self.labelRatingConservation.text = [NSString stringWithFormat:@"%@", feedback.conservation];
        self.labelRatingSecurity.text = [NSString stringWithFormat:@"%@", feedback.security];
        self.labelRatingWifi.text = [NSString stringWithFormat:@"%@", feedback.wifi];
    }
}
@end
