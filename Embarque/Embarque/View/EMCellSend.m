//
//  EMCellSend.m
//  Embarque
//
//  Created by Cleber Henriques on 4/11/15.
//  Copyright (c) 2015 Cleber Henriques. All rights reserved.
//

#import "EMCellSend.h"
#import "UIButton+ANDYHighlighted.h"
#import "UIColor+ColorWithHexAndAlpha.h"

@implementation EMCellSend

- (void)awakeFromNib {
    [self.btnSend setHighlightedBackgroundColor:[UIColor colorWithHex:@"61C2DB" andAlpha:1.0]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btnSendTouched:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellSend:didTouchedSend:)]) {
        [self.delegate cellSend:self didTouchedSend:sender];
    }
}

@end
