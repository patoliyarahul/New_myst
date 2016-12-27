//
//  ExploreCell.h
//  Myst
//
//  Created by Vipul Jikadra on 27/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExploreCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgPackage;
@property (strong, nonatomic) IBOutlet UILabel *lblPackageName;
@property (strong, nonatomic) IBOutlet UILabel *lblPackageDescrption;
@property (strong, nonatomic) IBOutlet UIButton *btnRequest;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *AI;

@end
