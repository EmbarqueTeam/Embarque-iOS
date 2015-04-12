//
//  EMCellFeedback.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMCellFeedback.h"
#import "EMFeedbackItem.h"
#import "EMSessionManager.h"
#import "EMFeedback.h"
@interface EMCellFeedback ()

@property (assign, nonatomic) FeedbackType type;

@end

@implementation EMCellFeedback

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configureWithObject:(id)object target:(id)target indexPath:(NSIndexPath *)indexPath
{
    if (object && [object isKindOfClass:[EMFeedbackItem class]]) {
        
        EMFeedbackItem *feedback = object;
        
        [self.image setImage:[UIImage imageNamed:[feedback imageName]]];
        self.title.text = [feedback title];
        self.type = [feedback type];
        
        if (feedback.rating) {
            [self.slider setValue:feedback.rating.floatValue animated:YES];
        }
    }
}

- (IBAction)slideChanged:(UISlider *)sender {
    sender.value = (int)sender.value;
    
    switch (self.type) {
        case FeedbackTypeWifi:
            [[[EMSessionManager sharedInstance] feedbackToCreate] setWifi:@(sender.value)];
            break;
        case FeedbackTypePunctuality:
            [[[EMSessionManager sharedInstance] feedbackToCreate] setPunctuality:@(sender.value)];
            break;
        case FeedbackTypeFood:
            [[[EMSessionManager sharedInstance] feedbackToCreate] setFood:@(sender.value)];
            break;
        case FeedbackTypeConservation:
            [[[EMSessionManager sharedInstance] feedbackToCreate] setConservation:@(sender.value)];
            break;
        case FeedbackTypeSecurity:
            [[[EMSessionManager sharedInstance] feedbackToCreate] setSecurity:@(sender.value)];
            break;
        case FeedbackTypeInformation:
            [[[EMSessionManager sharedInstance] feedbackToCreate] setInformation:@(sender.value)];
            break;
        case FeedbackTypeButtonEnviar:
            break;
        default:
            break;
    }}

@end
