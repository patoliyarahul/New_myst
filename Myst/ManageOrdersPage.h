//
//  ManageOrdersPage.h
//  Myst
//
//  Created by Vipul Jikadra on 31/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateManageOrdersPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowTipView:(NSMutableDictionary *)data;
@end
@interface ManageOrdersPage : UIViewController<UITableViewDataSource , UITableViewDelegate>
{
    
    IBOutlet UITableView *tblOrder;

    IBOutlet UIView *carview;
    IBOutlet UIButton *btnAddvehicle;
}
- (IBAction)addVehicleFire:(id)sender;
@property (weak, nonatomic) id <DelegateManageOrdersPage> delegate;
@property(nonatomic)NSMutableDictionary *dataInfo;
@end
