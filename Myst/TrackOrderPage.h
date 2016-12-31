//
//  TrackOrderPage.h
//  Myst
//
//  Created by Vipul Jikadra on 31/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleListCell.h"
#import "VehicleObData.h"
@protocol DelegateTrackOrderPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowLocationView;
@end
@interface TrackOrderPage : UIViewController<UIScrollViewDelegate , UITableViewDelegate , UITableViewDataSource , VehicleListCellDelegate , UIActionSheetDelegate>
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
    
   
    IBOutlet UIView *viewPicker;
    
    IBOutlet UIButton *btnRequest;
    

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
    
    IBOutlet UIImageView *imgProgress;
    
}
- (IBAction)requestFire:(id)sender;
- (IBAction)loceditFire:(id)sender;
- (IBAction)timeSelectFire:(id)sender;
@property (nonatomic) NSMutableDictionary *dataInfo;
@property (weak, nonatomic) id <DelegateTrackOrderPage> delegate;
@end
