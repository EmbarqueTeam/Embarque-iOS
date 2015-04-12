//
//  UIView+MXAdditions.m
//  FinancasPessoais
//
//  Created by Henrique Morbin on 28/11/14.
//  Copyright (c) 2014 Moolab. All rights reserved.
//

#import "UIView+MXAdditions.h"

@implementation UIView (MXAdditions)

-(float) x {
    return self.frame.origin.x;
}

-(void) setX:(float) newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

-(float) y {
    return self.frame.origin.y;
}

-(void) setY:(float) newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

-(float) width {
    return self.frame.size.width;
}

-(void) setWidth:(float) newWidth {
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

-(float) height {
    return self.frame.size.height;
}

-(void) setHeight:(float) newHeight {
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}

- (CGPoint) origin
{
    return self.frame.origin;
}

- (CGSize) size
{
    return self.frame.size;
}

- (float) top
{
    return self.y;
}

- (float) bottom
{
    return self.y+self.height;
}

- (float) left
{
    return self.x;
}

- (float) right
{
    return self.x+self.width;
}

- (float) width_2
{
    return self.width/2;
}

- (float) width_4
{
    return self.width/4;
}

- (float) height_2
{
    return self.height/2;
}

- (float) height_4
{
    return self.height/4;
}
@end
