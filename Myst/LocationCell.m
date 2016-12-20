//
//  LocationCell.m
//  Myst
//
//  Created by Vipul Jikadra on 19/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "LocationCell.h"

@implementation LocationCell

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
        self.lblName.font = [UIFont fontWithName:@SFUIDisplay_Bold size:16];
        self.imgCheck.hidden = NO;
         _btnSelect.hidden = YES;
    }
    else
    {
        self.lblName.font = [UIFont fontWithName:@SFUIDisplay_Medium size:16];
        self.imgCheck.hidden = YES;
        _btnSelect.hidden = NO;
    }

}

@end
