//
//  EMFeedbackItem.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMFeedbackItem.h"

@implementation EMFeedbackItem

+(instancetype)newFeedbackItemWithTitle:(NSString *)title andImageName:(NSString *)imageName andCellIdentifier:(NSString *)cellIdentifier
{
    EMFeedbackItem *item = [[EMFeedbackItem alloc] init];
    
    item.title = title;
    item.imageName = imageName;
    item.cellIdentifier = cellIdentifier;

    return item;
}

+(instancetype)newFeedbackItemWithType:(FeedbackType)type
{
    EMFeedbackItem *item = [[EMFeedbackItem alloc] init];
    item.type = type;
   
    NSString *title;
    NSString *imageName;
    NSString *cellIdentifier = @"CellFeedback";
    
    switch (type) {
        case FeedbackTypeWifi:
            title = @"Wifi e tomadas";
            imageName = @"Wifi";
            break;
        case FeedbackTypePunctuality:
            title = @"Pontualidade";
            imageName = @"Clock";
            break;
        case FeedbackTypeFood:
            title = @"Praça de Alimentação";
            imageName = @"Food";
            break;
        case FeedbackTypeConservation:
            title = @"Conservação e Limpeza";
            imageName = @"TrashCan";
            break;
        case FeedbackTypeSecurity:
            title = @"Segurança";
            imageName = @"Security";
            break;
        case FeedbackTypeInformation:
            title = @"Informação e atendimento";
            imageName = @"Question";
            break;
        case FeedbackTypeButtonEnviar:
            title = @"Enviar";
            imageName = @"Enviar";
            cellIdentifier = @"CellSend";
            break;
        default:
            break;
    }
                          
    item.title = title;
    item.imageName = imageName;
    item.cellIdentifier = cellIdentifier;
    return item;
}

@end
