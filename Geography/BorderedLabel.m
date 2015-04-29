//
//  BorderedLabel.m
//  Geography
//
//  Created by Omar Rahman on 4/28/15.
//  Adapted from an answer from this StackOverflow post by user kprevas:
//  http://stackoverflow.com/questions/1103148/how-do-i-make-uilabel-display-outlined-text
//
//  Copyright (c) 2015 Omar Rahman. All rights reserved.
//

#import "BorderedLabel.h"

@implementation BorderedLabel

- (void)drawTextInRect:(CGRect)rect {
    
    CGSize shadowOffset = self.shadowOffset;
    UIColor *textColor = self.textColor;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 2);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = [UIColor blackColor];
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
}

@end
