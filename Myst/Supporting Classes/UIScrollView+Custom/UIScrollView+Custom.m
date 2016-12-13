//
//  UIScrollView+Custom.m
//  SaveLife
//
//  Created by animesh on 26/11/14.
//  Copyright (c) 2014 vsure. All rights reserved.
//

#import "UIScrollView+Custom.h"

@implementation UIScrollView (Custom)

- (void) conS_W:(float) width H:(float)height
{
    [self setContentSize:CGSizeMake(width, height)];
}

- (void) conO_X:(float) x Y:(float) y
{
    [self setContentOffset:CGPointMake(x, y)];
}

@end
