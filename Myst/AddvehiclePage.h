//
//  AddvehiclePage.h
//  Myst
//
//  Created by Vipul Jikadra on 15/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleListCell.h"
@protocol DelegateAddvehiclePage <NSObject>
- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowVehicleView:(NSMutableDictionary *)data;
@end

@interface AddvehiclePage : UIViewController<UITableViewDelegate,UITableViewDataSource,VehicleListCellDelegate>
{
    IBOutlet UIImageView *carImage;
    
    IBOutlet UIButton *btnAddvehicle;
    IBOutlet UITableView *tblVehicle;
    IBOutlet UIView *carview;
    NSMutableArray *packages;
    IBOutlet UILabel *lblTotal;
    IBOutlet UIView *viewFooter;
    
    IBOutlet NSLayoutConstraint *footerHeight;
    
    IBOutlet UIButton *btnAdd;
}

- (IBAction)addVehicleFire:(id)sender;
- (IBAction)nextFire:(id)sender;

- (IBAction)addFire:(id)sender;

@property (weak, nonatomic) id <DelegateAddvehiclePage> delegate;
- (IBAction)setNext:(id)sender;
@end
