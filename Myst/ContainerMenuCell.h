//
//  ContainerMenuCell.h
//  Loyalty App
//
//  Created by Techlect on 26/08/14.
//  Copyright (c) 2014 Techlect. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContainerMenuCellDelegate <NSObject>
@end

@interface ContainerMenuCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgCell;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@property (strong, nonatomic) IBOutlet UIImageView *imgLoggedUser;
@property (strong, nonatomic) IBOutlet UILabel *lblLoggedUserName;

@property (strong, nonatomic) IBOutlet UIView *viewMenuView;
@property (strong, nonatomic) id <ContainerMenuCellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;

@end
