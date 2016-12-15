//
//  HomePage.h
//  Myst
//
//  Created by Vipul Jikadra on 14/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DelegateHomePage <NSObject>

- (void) Push:(int)vc Data:(id)dataInfo;
- (void) PopViewController;
- (void) addCustomPopup:(NSString *) msg;
@end
@interface HomePage : UIViewController
{
    
    IBOutlet UIButton *btnRequest;
    IBOutlet UITextField *tfName;
    
    IBOutlet UIButton *btnTrack;
    
    IBOutlet UIButton *btnPackges;
    
    IBOutlet UIButton *btnSendrequest;
    
}
- (IBAction)requestFire:(id)sender;
- (IBAction)TrackFire:(id)sender;
- (IBAction)packagesFire:(id)sender;
- (IBAction)sendRequestFire:(id)sender;
@property (weak, nonatomic) id <DelegateHomePage> delegate;
@end
