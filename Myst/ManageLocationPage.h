//
//  ManageLocationPage.h
//  Myst
//
//  Created by Vipul Jikadra on 28/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateManageLocationPage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
-(void)ShowLocationView:(NSMutableDictionary *)data;
@end
@interface ManageLocationPage : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UITableView *tblLocation;
    IBOutlet UIView *viewPopup;
    IBOutlet UIButton *btnAddLocation;
}
@property (weak, nonatomic) id <DelegateManageLocationPage> delegate;
- (IBAction)AddLocationFire:(id)sender;
@end
