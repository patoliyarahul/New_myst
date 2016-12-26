//
//  VehicleListCell.h
//  Myst
//
//  Created by Vipul Jikadra on 15/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VehicleListCellDelegate <NSObject>
-(void) myCellDelegateDidCheck:(UITableViewCell*)checkedCell;
-(void) ImageTapped:(UITableViewCell*)checkedCell;
@end
@interface VehicleListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblYear;
@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UIButton *btnSelect;

@property (strong, nonatomic) IBOutlet UILabel *lblPackage;
@property (strong, nonatomic) IBOutlet UIImageView *imgCheck;
@property (strong, nonatomic) IBOutlet UIButton *btnMsg;
@property (nonatomic, weak) id <VehicleListCellDelegate> delegate;

@end
