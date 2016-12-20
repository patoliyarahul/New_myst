//
//  LocationPage.m
//  Myst
//
//  Created by Vipul Jikadra on 19/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "LocationPage.h"

@interface LocationPage ()

@end

@implementation LocationPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tfLocationType.delegate = self;
    tfName.delegate = self;
    tfStreet.delegate = self;
    tfSuite.delegate = self;
    tfCity.delegate = self;
    tfState.delegate = self;
    tfZipCode.delegate = self;
    tfInstructions.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myNotificationMethod:) name:UIKeyboardDidShowNotification object:nil];

    
    [self HighLite];
    [self borderWork];
    
    locationType = [[NSMutableArray alloc] initWithObjects:@"Type1",@"Type2", nil];
    States = [[NSMutableArray alloc] initWithObjects:@"CA",@"NewYork",@"New Mexico",@"Chicago",@"San Franscio", nil];
}
- (void)myNotificationMethod:(NSNotification *)notification
{
    NSDictionary* keyboardInfo  = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardFrameBeginRect      = [keyboardFrameBegin CGRectValue];
}
- (void) borderWork
{
    
    [self SetTextFieldBorder:tfLocationType];
    [self SetTextFieldBorder:tfName];
    [self SetTextFieldBorder:tfStreet];
    [self SetTextFieldBorder:tfSuite];
    [self SetTextFieldBorder:tfCity];
    [self SetTextFieldBorder:tfState];
    [self SetTextFieldBorder:tfZipCode];
    [self SetTextFieldBorder:tfInstructions];
    
    [obNet startSpaceTo:tfLocationType Space:SpaceForTextField];
    [obNet startSpaceTo:tfName Space:SpaceForTextField];
    [obNet startSpaceTo:tfStreet Space:SpaceForTextField];
    [obNet startSpaceTo:tfSuite Space:SpaceForTextField];
    [obNet startSpaceTo:tfCity Space:SpaceForTextField];
    [obNet startSpaceTo:tfState Space:SpaceForTextField];
    [obNet startSpaceTo:tfZipCode Space:SpaceForTextField];
    [obNet startSpaceTo:tfInstructions Space:SpaceForTextField];
    
    [tfLocationType setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfName setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfStreet setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfSuite setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfCity setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfState setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfZipCode setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    [tfInstructions setValue:colorTextHintSecond forKeyPath:@"_placeholderLabel.textColor"];
    
}
-(void)HighLite
{
    if (tfLocationType.text.length != 0 && tfName.text.length != 0 && tfStreet.text.length != 0)
    {
        
        btnSave.hidden = NO;
        [btnSave setTitleColor:[obNet colorWithHexString:@"0AE587"] forState:UIControlStateNormal];
        btnSave.userInteractionEnabled = NO;
        btnSave.titleLabel.alpha = 0.5;
    
    }
    else
    {
        btnSave.hidden = YES;
    }
    
    if (tfLocationType.text.length != 0 && tfName.text.length != 0 && tfStreet.text.length != 0 && tfSuite.text.length != 0 && tfCity.text.length != 0 && tfState.text.length != 0 && tfZipCode.text.length != 0 && tfInstructions.text.length != 0)
    {
        btnSave.hidden = NO;
        [btnSave setTitleColor:[obNet colorWithHexString:@"0AE587"] forState:UIControlStateNormal];
        btnSave.userInteractionEnabled = YES;
        btnSave.titleLabel.alpha = 1.0;
        
    }
    
}
- (void)viewDidLayoutSubviews
{
    [backScrl setContentSize:CGSizeMake([obNet deviceFrame].size.width, [obNet deviceFrame].size.height)];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    if (textField == tfName)
//    {
//        [tfStreet becomeFirstResponder];
//    }
//    else  if (textField == tfStreet)
//    {
//        [tfSuite becomeFirstResponder];
//    }
//    else  if (textField == tfSuite)
//    {
//        [tfCity becomeFirstResponder];
//    }
//    else  if (textField == tfCity)
//    {
//        [tfZipCode becomeFirstResponder];
//    }
//    else  if (textField == tfZipCode)
//    {
//         [tfInstructions becomeFirstResponder];
//        
//    }
//    else  if (textField == tfInstructions)
//    {
//        [tfInstructions resignFirstResponder];
//        [backScrl setContentOffset:CGPointZero];
//        
//    }
    
    [textField resignFirstResponder];
    [backScrl setContentOffset:CGPointZero];
    [backScrl setContentSize:CGSizeZero];
    [self HighLite];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if  (textField == tfLocationType)
    {
        myPickerView = [[UIPickerView alloc]init];
        myPickerView.dataSource = self;
        myPickerView.delegate = self;
        myPickerView.tag = 50;
        myPickerView.showsSelectionIndicator = YES;
        myPickerView.backgroundColor = [obNet colorWithHexString:@"575CFF"];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                       target:self action:@selector(done:)];
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                              CGRectMake(0, self.view.frame.size.height-
                                         myPickerView.frame.size.height-50, 320, 50)];
        [toolBar setBarStyle:UIBarStyleBlackOpaque];
        NSArray *toolbarItems = [NSArray arrayWithObjects:
                                 doneButton, nil];
        [toolBar setItems:toolbarItems];
        tfLocationType.inputView = myPickerView;
        
        tfLocationType.inputAccessoryView = toolBar;
        
    }
   else if  (textField == tfState)
    {
        myPickerView = [[UIPickerView alloc]init];
        myPickerView.dataSource = self;
        myPickerView.delegate = self;
        myPickerView.tag = 51;
        myPickerView.showsSelectionIndicator = YES;
        myPickerView.backgroundColor = [obNet colorWithHexString:@"575CFF"];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                       target:self action:@selector(done:)];
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                              CGRectMake(0, self.view.frame.size.height-
                                         myPickerView.frame.size.height-50, 320, 50)];
        [toolBar setBarStyle:UIBarStyleBlackOpaque];
        NSArray *toolbarItems = [NSArray arrayWithObjects:
                                 doneButton, nil];
        [toolBar setItems:toolbarItems];
        tfState.inputView = myPickerView;
        
        tfState.inputAccessoryView = toolBar;
        
        float newY = self.view.frame.size.height - keyboardFrameBeginRect.size.height - textField.frame.size.height * 3;
        
        if (newY > 0)
        {
            [backScrl setContentOffset:CGPointMake(0, newY)];
        }
        else
        {
            [backScrl setContentOffset:CGPointZero];
        }
        
        
    }
    else if  (textField == tfName || textField == tfStreet)
    {
        
    }
    else
    {
        float newY = self.view.frame.size.height - keyboardFrameBeginRect.size.height - textField.frame.size.height * 3;
        
        if (newY > 0)
        {
            [backScrl setContentOffset:CGPointMake(0, newY)];
        }
        else
        {
            [backScrl setContentOffset:CGPointZero];
        }
        
    }
}
-(void)done:(id)sender
{
    [self.view endEditing:YES];
    [backScrl setContentOffset:CGPointZero];
    [backScrl setContentSize:CGSizeZero];
    
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
#pragma mark - Picker View Data source


- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView.tag == 50)
    {
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[locationType objectAtIndex:row]  attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    }
    else
    {
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[States objectAtIndex:row]  attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    }
   
    
    
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    
    if (pickerView.tag == 50)
    {
         return [locationType count];
    }
    else
    {
         return [States count];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 50)
    {
        return [locationType objectAtIndex:row];
    }
    else
    {
       return [States objectAtIndex:row];
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 50)
    {
        tfLocationType.text = [locationType objectAtIndex:row];
    }
    else
    {
        tfState.text = [States objectAtIndex:row];
    }

    
    
}
- (IBAction)SaveFire:(id)sender
{
    NSString * msg = nil;
    
    if (tfLocationType.text.length == 0)
    {
        msg = @"LocationType is empty";
    }
    else if (tfName.text.length == 0)
    {
        msg = @"LocationName is empty";
    }
    else if (tfSuite.text.length == 0)
    {
        msg = @"Suite is empty";
    }
    else if (tfCity.text.length == 0)
    {
        msg = @"City Name is empty";
    }
    else if (tfState.text.length == 0)
    {
        msg = @"State is empty";
    }
    else if (tfZipCode.text.length == 0)
    {
        msg = @"Zipcode is empty";
    }
    else if (tfInstructions.text.length == 0)
    {
        msg = @"Instructions is empty";
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
        mD[@"type"] = tfLocationType.text;
        mD[@"name"] = tfName.text;
        mD[@"street"] = tfState.text;
        mD[@"unit"] = tfSuite.text;
        mD[@"city"] = tfCity.text;
        mD[@"state"] = tfState.text;
        mD[@"zipcode"] = tfZipCode.text;
        mD[@"instruction"] = tfInstructions.text;
        mD[@"latitude"] = @"";
        mD[@"longitude"] = @"";
        [obNet JSONFromWebServices:WS_addLocation Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
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
@end
