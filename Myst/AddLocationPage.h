//
//  AddLocationPage.h
//  Myst
//
//  Created by Vipul Jikadra on 19/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateAddLocationPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowLocationView;
@end
@interface AddLocationPage : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblLocation;
    
    IBOutlet UIView *viewFotter;
    IBOutlet UIButton *btnNext;
    IBOutlet UIView *viewPopup;
    
    IBOutlet UIButton *btnPlus;
    IBOutlet UILabel *lblTotal;
    
    IBOutlet UIButton *btnAddLocation;
    
}
- (IBAction)nextFire:(id)sender;
- (IBAction)plusFire:(id)sender;
- (IBAction)AddLocationFire:(id)sender;
@property (weak, nonatomic) id <DelegateAddLocationPage> delegate;
@end
