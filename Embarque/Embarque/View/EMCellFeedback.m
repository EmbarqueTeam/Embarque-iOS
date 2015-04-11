//
//  EMCellFeedback.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMCellFeedback.h"
#import "EMFeedbackItem.h"

@implementation EMCellFeedback

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configureWithObject:(id)object target:(id)target indexPath:(NSIndexPath *)indexPath
{
    if (object && [object isKindOfClass:[EMFeedbackItem class]]) {
        [self.image setImage:[UIImage imageNamed:[(EMFeedbackItem *)object imageName]]];
        self.title.text = [(EMFeedbackItem *)object title];
    }
}
- (IBAction)slideChanged:(UISlider *)sender {
    sender.value = (int)sender.value;
}

@end
