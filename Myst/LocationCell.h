//
//  LocationCell.h
//  Myst
//
//  Created by Vipul Jikadra on 19/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UIImageView *imgCheck;
@property (strong, nonatomic) IBOutlet UIButton *btnSelect;
@end
