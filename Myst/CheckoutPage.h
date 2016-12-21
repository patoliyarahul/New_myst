//
//  CheckoutPage.h
//  Myst
//
//  Created by Vipul Jikadra on 20/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateCheckoutPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowLocationView;
@end
@interface CheckoutPage : UIViewController<UIScrollViewDelegate , UITableViewDelegate , UITableViewDataSource >
{
    
    IBOutlet UIScrollView *scrlContainer;
    IBOutlet UIScrollView *scrlBack;
    
    IBOutlet UIView *viewPayment;
    IBOutlet UIView *viewTime;
    IBOutlet UIView *viewVehicle;
    IBOutlet UIView *viewLocation;
    IBOutlet UIView *viewTotal;
    IBOutlet UIView *viewOndemand;
    IBOutlet UIView *viewSchedule;
    
    IBOutlet UIView *viewAddPaymetmethod;
    IBOutlet UIView *viewPicker;
    
    IBOutlet UIButton *btnRequest;
    
    
    IBOutlet UIImageView *imgCard;
    IBOutlet UILabel *lblAddPayment;
    
    
    IBOutlet UIImageView *imgDemand;
    IBOutlet UILabel *lblDemand;
    IBOutlet UILabel *lblETA;
    
    
    IBOutlet UIImageView *imgSchedule;
    IBOutlet UILabel *lblSchedule;
    IBOutlet UILabel *lblDateTime;
    
    IBOutlet UIDatePicker *pickerDate;
    
    
    IBOutlet UITableView *tblVehicle;
    
    IBOutlet UILabel *lblLoctaion;
    
    IBOutlet UIButton *btnLocedit;
    
    IBOutlet UILabel *lblTotal;
    
    IBOutlet UIButton *btnTimeSelect;
    
    IBOutlet NSLayoutConstraint *tblVehilceConstraint;

    IBOutlet NSLayoutConstraint *vehicleViewConstraint;
    
    IBOutlet NSLayoutConstraint *pickerViewConstraint;
    IBOutlet NSLayoutConstraint *datePickerConstraint;
    
    IBOutlet NSLayoutConstraint *timeViewConstraint;
    
    int pickerHeight;
    int pickerViewheight;
    
    NSMutableArray *vehicles;
}
@property (weak, nonatomic) id <DelegateCheckoutPage> delegate;
- (IBAction)requestFire:(id)sender;
- (IBAction)loceditFire:(id)sender;
- (IBAction)timeSelectFire:(id)sender;
@property (nonatomic) NSMutableDictionary *dataInfo;
@end
