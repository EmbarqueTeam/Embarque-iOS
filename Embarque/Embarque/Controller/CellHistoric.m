//
//  CellHistoric.m
//  Embarque
//
//  Created by Cleber Henriques on 4/12/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "CellHistoric.h"
#import "EMFeedback.h"
#import "DateTools.h"
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
        self.labelTime.text = [feedback.updatedAt timeAgoSinceNow];
        self.labelRatingPunctuality.text = [NSString stringWithFormat:@"%@", feedback.punctuality ? feedback.punctuality : @0];
        self.labelRatingFood.text = [NSString stringWithFormat:@"%@", feedback.food ? feedback.food : @0];
        self.labelRatingInformation.text = [NSString stringWithFormat:@"%@", feedback.information ? feedback.information : @0];
        self.labelRatingConservation.text = [NSString stringWithFormat:@"%@", feedback.conservation ? feedback.conservation : @0];
        self.labelRatingSecurity.text = [NSString stringWithFormat:@"%@", feedback.security ? feedback.security : @0];
        self.labelRatingWifi.text = [NSString stringWithFormat:@"%@", feedback.wifi ? feedback.wifi : @0];
    }
}
@end
