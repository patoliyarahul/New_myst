//
//  CheckoutPage.h
//  Myst
//
//  Created by Vipul Jikadra on 20/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleListCell.h"
#import "VehicleObData.h"
#define Visa 1// = Pattern.compile("^4[0-9]{12}(?:[0-9]{3})?$");
#define Master 2//= Pattern.compile("^5[1-5][0-9]{14}$");
#define Express 3//= Pattern.compile("^3[47][0-9]{13}$");
#define Diners 4//= Pattern.compile("^3(?:0[0-5]|[68][0-9])[0-9]{11}$");
#define Discover 5//= Pattern.compile("^6(?:011|5[0-9]{2})[0-9]{12}$");
#define JSB 6//
#define NoONe 7//
@protocol DelegateCheckoutPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowLocationView;
@end
@interface CheckoutPage : UIViewController<UIScrollViewDelegate , UITableViewDelegate , UITableViewDataSource , VehicleListCellDelegate , UIActionSheetDelegate>
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
    
    IBOutlet NSLayoutConstraint *pickerHeightConstarint;
  
    IBOutlet NSLayoutConstraint *pickerViewHeightConstraint;
    
    IBOutlet NSLayoutConstraint *tableviewHeightConstraint;
    
    
    CGFloat pickerHeight;
    CGFloat pickerViewheight;
    
    NSMutableArray *vehicles;
    
    BOOL Checked;
    int noOfCharacterInCardNumber;;
    
    BOOL scheduleChecked;
    BOOL ondemandChecked;
    
    int total;
}
@property (weak, nonatomic) id <DelegateCheckoutPage> delegate;
- (IBAction)requestFire:(id)sender;
- (IBAction)loceditFire:(id)sender;
- (IBAction)timeSelectFire:(id)sender;
@property (nonatomic) NSMutableDictionary *dataInfo;
@end
