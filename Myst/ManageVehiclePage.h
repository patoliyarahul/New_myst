//
//  ManageVehiclePage.h
//  Myst
//
//  Created by Vipul Jikadra on 28/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateManageVehiclePage <NSObject>
- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowVehicleView:(NSMutableDictionary *)data;
@end
@interface ManageVehiclePage : UIViewController<UITableViewDataSource , UITableViewDelegate>
{
    IBOutlet UITableView *tblVehicle;
    IBOutlet UIView *carview;
    IBOutlet UIButton *btnAddvehicle;
}
- (IBAction)addVehicleFire:(id)sender;
@property (weak, nonatomic) id <DelegateManageVehiclePage> delegate;
@end
