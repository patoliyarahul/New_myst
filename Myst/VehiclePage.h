//
//  VehiclePage.h
//  Myst
//
//  Created by Vipul Jikadra on 15/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehiclePage : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    ///////////////////////////////////////////////    ADD Vehicle Page /////////////////////////////////////////
    
    IBOutlet UIView *addVehicleView;
    IBOutlet UIScrollView *vehicleScrl;
    
    IBOutlet UITextField *tfVehicleType;
    
    IBOutlet UITextField *tfYear;
    
    IBOutlet UITextField *tfMake;
    
    IBOutlet UITextField *tfModel;
    
    IBOutlet UITextField *tfColor;
    
    IBOutlet UITextField *tfLicenceNo;
    
    IBOutlet UIButton *btnCancel;
    
    IBOutlet UIButton *btnSave;
    
    CGRect keyboardFrameBeginRect;
    
     UIPickerView *myPickerView;

}
///////////////////////////////////////////////    ADD Vehicle Page /////////////////////////////////////////
- (IBAction)cancelFire:(id)sender;

- (IBAction)SaveFire:(id)sender;

@end
