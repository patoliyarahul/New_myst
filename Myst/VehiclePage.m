//
//  VehiclePage.m
//  Myst
//
//  Created by Vipul Jikadra on 15/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "VehiclePage.h"
#import "VehicleType.h"
#import "VehicleData.h"
@interface VehiclePage ()
{
    VehicleType *vob;
}
@end

@implementation VehiclePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self HighLite];
    

    keyboardFrameBeginRect = CGRectMake(0.0, 0.0, 320.0, 253.0);
   

    tfYear.delegate = self;
    tfMake.delegate = self;
    tfModel.delegate = self;
    tfColor.delegate = self;
    tfLicenceNo.delegate = self;


    
    [tfYear setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfMake setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfModel setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfColor setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfLicenceNo setCustomDoneTarget:self action:@selector(doneAction:)];
    [tfVehicleType setCustomDoneTarget:self action:@selector(doneAction:)];
    
    
    
}
-(void)doneAction:(UITextField*)textField
{
    [self HighLite];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    lblHeader.text = _dataInfo[@"title"];
    
    btnDelete.hidden = YES;
    if ([lblHeader.text isEqualToString:@"Edit Vehicle"])
    {
        btnDelete.hidden = NO;
    }
 
    
     [self borderWork];
    
    [obNet JSONFromWebServices:WS_getVehicleType Parameter:nil Method:@"GET" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
    
         if (IsObNotNil(json))
         {
             
             if ([json[@"success"] integerValue] == 1)
             {
                 
                 NSError* err = nil;
                 
                vob = [[VehicleType alloc]initWithDictionary:json error:&err];
                 
                 [tfVehicleType setItemList:[vob.data valueForKey:@"name"]];
                 
                 if (![[[_dataInfo valueForKey:@"data"] valueForKey:@"make"] isEqualToString:@""])
                 {
                      [self updateTextFeild];
                 }
                
             }
             else
             {
                 ToastMSG(json[@"message"][@"title"]);
             }
             
         }
         else
         {
             ToastMSG(json[@"message"][@"title"]);
         }
     }];

    NSLog(@"datainfo == %@",_dataInfo);
}
-(void)updateTextFeild
{
    tfYear.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"model_year"];
    tfMake.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"make"];
    tfModel.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"model"];
    tfColor.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"color"];
    tfLicenceNo.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"license_plate_no"];
    tfVehicleType.text = [[_dataInfo valueForKey:@"data"] valueForKey:@"type"];
     [self HighLite];
}
- (void) borderWork
{
    
    [self SetTextFieldBorder:tfVehicleType];
    [self SetTextFieldBorder:tfYear];
    [self SetTextFieldBorder:tfMake];
    [self SetTextFieldBorder:tfModel];
    [self SetTextFieldBorder:tfColor];
    [self SetTextFieldBorder:tfLicenceNo];
    
    [obNet startSpaceTo:tfVehicleType Space:SpaceForTextField];
    [obNet startSpaceTo:tfYear Space:SpaceForTextField];
    [obNet startSpaceTo:tfMake Space:SpaceForTextField];
    [obNet startSpaceTo:tfModel Space:SpaceForTextField];
    [obNet startSpaceTo:tfColor Space:SpaceForTextField];
    [obNet startSpaceTo:tfLicenceNo Space:SpaceForTextField];
    
    [tfVehicleType setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfYear setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfMake setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfModel setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfColor setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfLicenceNo setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    

}
-(void)HighLite
{
  
    btnSave.hidden = NO;
    [btnSave setTitleColor:[obNet colorWithHexString:@"0AE587"] forState:UIControlStateNormal];
    btnSave.userInteractionEnabled = NO;
    btnSave.titleLabel.alpha = 0.5;

    if (tfVehicleType.text.length != 0 && tfYear.text.length != 0 && tfMake.text.length != 0 && tfModel.text.length != 0 && tfColor.text.length != 0 && tfLicenceNo.text.length != 0)
    {
        btnSave.hidden = NO;
        [btnSave setTitleColor:[obNet colorWithHexString:@"0AE587"] forState:UIControlStateNormal];
        btnSave.userInteractionEnabled = YES;
        btnSave.titleLabel.alpha = 1.0;
        
    }
    
}
- (void)viewDidLayoutSubviews
{
    [vehicleScrl setContentSize:CGSizeMake([obNet deviceFrame].size.width, [obNet deviceFrame].size.height)];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == tfMake && tfMake.text.length !=0)
    {
        CALayer *border1 = [CALayer layer];
        CGFloat borderWidth = 1;
        border1.borderColor = [obNet colorWithHexString:@"9B9B9B"].CGColor;
        border1.frame = CGRectMake(0, tfMake.frame.size.height - borderWidth, tfMake.frame.size.width, tfMake.frame.size.height);
        border1.borderWidth = borderWidth;
        border1.opacity = 1.0;
        [tfMake.layer addSublayer:border1];
        tfMake.layer.masksToBounds = YES;
    }
    
    if (textField == tfYear)
    {
        NSString *currentString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        int length = [currentString length];
        if (length > 4)
        {
            return NO;
        }
        return YES;
    }
    
    if (textField == tfMake || textField == tfModel || textField == tfColor)
    {
       return  [obNet onlyChar:string];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [tfLicenceNo resignFirstResponder];
    [vehicleScrl setContentOffset:CGPointZero];
    
    [self HighLite];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}
-(void)done:(id)sender
{
    [self.view endEditing:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelFire:(id)sender
{
     [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)SaveFire:(id)sender
{
    NSString * msg = nil;
    
    if (tfVehicleType.text.length == 0)
    {
        msg = @"VehicleType is empty";
    }
    else if (tfYear.text.length == 0)
    {
        msg = @"VehicleYear is empty";
    }
    else if (tfMake.text.length == 0)
    {
        msg = @"VehicleMake is empty";
    }
    else if (tfModel.text.length == 0)
    {
        msg = @"VehicleModel is empty";
    }
    else if (tfColor.text.length == 0)
    {
        msg = @"VehicleColor is empty";
    }
    else if (tfLicenceNo.text.length == 0)
    {
        msg = @"VehicleLicience PLate Number is empty";
    }
    
    if (msg)
    {
        ToastMSG(msg);
    }
    else
    {
        NSMutableDictionary * mD = [NSMutableDictionary new];
        
        UserInfo *ob = [obNet getUserInfoObject];
        
        mD[@"cust_id"] = ob.data.cust_id;
        mD[@"type"] = tfVehicleType.text;
        mD[@"model_year"] = tfYear.text;
        mD[@"make"] = tfMake.text;
        mD[@"model"] = tfModel.text;
        mD[@"color"] = tfColor.text;
        mD[@"license_plate_no"] = tfLicenceNo.text;

         if ([lblHeader.text isEqualToString:@"Edit Vehicle"])
         {
             mD[@"veh_id"] = [[_dataInfo valueForKey:@"data"] valueForKey:@"veh_id"];
             
             [obNet JSONFromWebServices:WS_editVehicle Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
              {
                  if (IsObNotNil(json))
                  {
                      
                      if ([json[@"success"] integerValue] == 1)
                      {
                          
                          ToastMSG(json[@"message"][@"title"]);
                          [self dismissViewControllerAnimated:YES completion:NULL];
                          
                      }
                      else
                      {
                          ToastMSG(json[@"message"][@"title"]);
                      }
                      
                  }
                  else
                  {
                      ToastMSG(json[@"message"][@"title"]);
                  }
                  
              }];

         }
        else
        {
            [obNet JSONFromWebServices:WS_addVehicle Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
             {
                 if (IsObNotNil(json))
                 {
                     
                     if ([json[@"success"] integerValue] == 1)
                     {
                         
                         ToastMSG(json[@"message"][@"title"]);
                         [self dismissViewControllerAnimated:YES completion:NULL];
                         
                     }
                     else
                     {
                         ToastMSG(json[@"message"][@"title"]);
                     }
                     
                 }
                 else
                 {
                     ToastMSG(json[@"message"][@"title"]);
                 }
                 
             }];

        }
        
        
    }

}

- (IBAction)deleteFire:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Are You Sure Want To Delete This Vehicle.", nil];
    
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSMutableDictionary * mD = [NSMutableDictionary new];
        
        UserInfo *ob = [obNet getUserInfoObject];
        
        mD[@"cust_id"] = ob.data.cust_id;
        mD[@"veh_id"] =  [[_dataInfo valueForKey:@"data"] valueForKey:@"veh_id"];
        
        [obNet JSONFromWebServices:WS_deleteVehicle Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
         {
             if (IsObNotNil(json))
             {
                 
                 if ([json[@"success"] integerValue] == 1)
                 {
                     
                     ToastMSG(json[@"message"][@"title"]);
                     [self dismissViewControllerAnimated:YES completion:NULL];
                     
                 }
                 else
                 {
                     ToastMSG(json[@"message"][@"title"]);
                 }
                 
             }
             else
             {
                 ToastMSG(json[@"message"][@"title"]);
             }
             
         }];

    }
}
-(void)SetTextFieldBorder :(UITextField *)textField
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [obNet colorWithHexString:@"9B9B9B"].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    border.opacity = 0.5;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;

}
@end
