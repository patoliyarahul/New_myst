//
//  PaymentCell.m
//  Myst
//
//  Created by Vipul Jikadra on 22/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "PaymentCell.h"

@implementation PaymentCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    
    _lblCard.textAlignment = NSTextAlignmentLeft;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
