//
//  ManageOrdersPage.h
//  Myst
//
//  Created by Vipul Jikadra on 31/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageOrdersPage : UIViewController<UITableViewDataSource , UITableViewDelegate>
{
    
    IBOutlet UITableView *tblOrder;

    IBOutlet UIView *carview;
    IBOutlet UIButton *btnAddvehicle;
}
- (IBAction)addVehicleFire:(id)sender;
@end
