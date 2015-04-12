//
//  UIView+MXAdditions.h
//  FinancasPessoais
//
//  Created by Henrique Morbin on 28/11/14.
//  Copyright (c) 2014 Moolab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MXAdditions)

@property float x;
@property float y;
@property float width;
@property float height;

- (CGPoint) origin;
- (CGSize) size;
- (float) top;
- (float) bottom;
- (float) left;
- (float) right;
- (float) width_2;
- (float) width_4;
- (float) height_2;
- (float) height_4;
@end
