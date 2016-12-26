//
//  VehicleListCell.m
//  Myst
//
//  Created by Vipul Jikadra on 15/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "VehicleListCell.h"

@implementation VehicleListCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    
    _lblPackage.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textViewTapped:)];
    [_lblPackage addGestureRecognizer:gestureRecognizer];
    
    _imgCheck.userInteractionEnabled = YES;
    UITapGestureRecognizer *gestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgCheckTapped:)];
    [_imgCheck addGestureRecognizer:gestureRecognizer1];
    
}
-(void)textViewTapped:(UITapGestureRecognizer *)recognizer
{
    [self.delegate myCellDelegateDidCheck:self];
}
-(void)imgCheckTapped:(UITapGestureRecognizer *)recognizer
{
    [self.delegate ImageTapped:self];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
