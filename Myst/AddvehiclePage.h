//
//  AddvehiclePage.h
//  Myst
//
//  Created by Vipul Jikadra on 15/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateAddvehiclePage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowVehicleView;
@end
@interface AddvehiclePage : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UIImageView *carImage;
    IBOutlet UIButton *btnNext;
    IBOutlet UIButton *btnAddvehicle;
    IBOutlet UITableView *tblVehicle;
    IBOutlet UIView *carview;
    
    NSMutableArray *packages;
    
}
- (IBAction)addVehicleFire:(id)sender;
- (IBAction)nextFire:(id)sender;

@property (weak, nonatomic) id <DelegateAddvehiclePage> delegate;
@end
