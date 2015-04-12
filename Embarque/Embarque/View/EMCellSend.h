//
//  EMCellSend.h
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EMCellSendDelegate;

@interface EMCellSend : UITableViewCell

@property (strong, nonatomic) id<EMCellSendDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;

@end

@protocol EMCellSendDelegate <NSObject>

@required

- (void)cellSend:(EMCellSend *)cellSend didTouchedSend:(UIButton *)btnSend;

@end