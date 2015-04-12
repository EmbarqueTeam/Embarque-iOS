//
//  CellHistoric.h
//  Embarque
//
//  Created by Cleber Henriques on 4/12/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellHistoric : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelCompany;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelRatingPunctuality;
@property (weak, nonatomic) IBOutlet UILabel *labelRatingInformation;
@property (weak, nonatomic) IBOutlet UILabel *labelRatingWifi;
@property (weak, nonatomic) IBOutlet UILabel *labelRatingFood;
@property (weak, nonatomic) IBOutlet UILabel *labelRatingConservation;
@property (weak, nonatomic) IBOutlet UILabel *labelRatingSecurity;

@end
