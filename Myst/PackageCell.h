//
//  PackageCell.h
//  Myst
//
//  Created by Vipul Jikadra on 17/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackageCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblPackageDesc;
@property (strong, nonatomic) IBOutlet UILabel *lblPackageName;
@property (strong, nonatomic) IBOutlet UIImageView *imgCheck;
@end
