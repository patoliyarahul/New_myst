//
//  PackageCell.m
//  Myst
//
//  Created by Vipul Jikadra on 30/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "PackageCell.h"

@implementation PackageCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        self.lblPackageName.textColor = [obNet colorWithHexString:@"575CFF"];
        self.lblPrice.textColor = [obNet colorWithHexString:@"575CFF"];
        self.lblPackageDesc.textColor = [obNet colorWithHexString:@"575CFF"];
        self.imgCheck.hidden = NO;
    }
    else
    {
        self.lblPackageName.textColor = [obNet colorWithHexString:@"5E5E5E"];
        self.lblPrice.textColor = [obNet colorWithHexString:@"5E5E5E"];
        self.lblPackageDesc.textColor = [obNet colorWithHexString:@"5E5E5E"];
        self.imgCheck.hidden = YES;
    }
    
    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
    
}

@end
