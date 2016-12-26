//
//  ContainerMenuCell.m
//  Loyalty App
//
//  Created by Techlect on 26/08/14.
//  Copyright (c) 2014 Techlect. All rights reserved.
//

#import "ContainerMenuCell.h"

@implementation ContainerMenuCell
@synthesize imgCell, lblTitle;

@synthesize imgLoggedUser;
@synthesize lblLoggedUserName, delegate, viewMenuView;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
   
}

@end
