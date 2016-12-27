//
//  ExploreCell.m
//  Myst
//
//  Created by Vipul Jikadra on 27/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "ExploreCell.h"

@implementation ExploreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = _imgPackage.bounds;
    UIColor *blackColor = [UIColor colorWithRed:22/255.0f green:22/255.0f blue:22/255.0f alpha:0.6f];
    UIColor *clearColor = [UIColor clearColor];
    layer.colors = [NSArray arrayWithObjects:(id)clearColor.CGColor, (id)blackColor.CGColor, nil];
    //[myView.layer insertSublayer:layer atIndex:0];
    // Add the gradient to the view
    [_imgPackage.layer insertSublayer:layer atIndex:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
