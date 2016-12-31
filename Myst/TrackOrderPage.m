//
//  TrackOrderPage.m
//  Myst
//
//  Created by Vipul Jikadra on 31/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "TrackOrderPage.h"

@interface TrackOrderPage ()
{
    UITapGestureRecognizer *Paymetmethod;
    UITapGestureRecognizer *onDemandGesture;
    UITapGestureRecognizer *sheduleGesture;
    UserInfo *ob;
}
@end

@implementation TrackOrderPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ob = [obNet getUserInfoObject];
    pickerHeight = pickerHeightConstarint.constant;
    pickerViewheight = pickerViewHeightConstraint.constant;
    
    tblVehicle.delegate = self;
    tblVehicle.dataSource = self;
    [tblVehicle registerNib:[UINib nibWithNibName:@"VehicleListCell" bundle:nil] forCellReuseIdentifier:@"VehicleList"];
    
    scrlContainer.delegate = self;
    scrlBack.delegate = self;
    
    NSLog(@"dataInfo = %@",_dataInfo);
    
    scrlContainer.frame = CGRectMake(0 , 0,  [UIScreen mainScreen].bounds.size.width, scrlContainer.frame.size.height);
    [scrlBack addSubview:scrlContainer];
    
    //???????????????????????????????????????    Shedule Wash ????????????????????////////////////////////////////
    
    onDemandGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewOndemandTapped:)];
    viewOndemand.userInteractionEnabled = YES;
    [viewOndemand addGestureRecognizer:onDemandGesture];
    imgDemand.hidden = YES;
    
    [self viewOndemandTapped:onDemandGesture];
    
    sheduleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewScheduleTapped:)];
    viewSchedule.userInteractionEnabled = YES;
    [viewSchedule addGestureRecognizer:sheduleGesture];
    imgSchedule.hidden = YES;
    btnTimeSelect.hidden = YES;
    
    CGRect frame = viewPicker.frame;
    frame.size.height = pickerViewHeightConstraint.constant;//rect.size.width;
    [viewPicker setFrame:frame];
    
    pickerHeightConstarint.constant = 0;
    pickerViewHeightConstraint.constant = 0;
    
    
    [tblVehicle setNeedsLayout];
    [tblVehicle setNeedsDisplay];
    [tblVehicle reloadData];
    
    [self.view setNeedsUpdateConstraints];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //???????????????????????????????????????    Payment Part ????????????????????////////////////////////////////
    
    Paymetmethod = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewAddPaymetmethodTapped:)];
    
    
    NSDate *currentDate = [NSDate date];
    pickerDate.minimumDate = currentDate;
    [pickerDate addTarget:self action:@selector(dateChanged:)
         forControlEvents:UIControlEventValueChanged];
    [self dateChanged:pickerDate];
    
    lblLoctaion.text = [NSString stringWithFormat:@"%@ %@ \n%@ %@ %@",[[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"street"], [[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"unit"], [[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"city"],[[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"state"] ,[[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"zipcode"]];
    
    [self findVehicleFromPackages];
    
    [self priceCalculation];
    
    [self HighLite];
    
}


-(void)priceCalculation
{
    if (KAppDelegate.packages.count != 0)
    {
        
        total = 0;
        for (NSString* key in [KAppDelegate.PackagePrice allKeys])
        {
            NSLog(@"key ==== %@",key);
            
            total = total + [[KAppDelegate.PackagePrice objectForKey:key]integerValue];
        }
        
        lblTotal.text = [NSString stringWithFormat:@"$%i",total];
    }
    else
    {
        
    }
}
#define Find Vehicle For load vehicle on tblVehicle JD

-(void)findVehicleFromPackages
{
    
    vehicles = [NSMutableArray new];
    for (int i = 0; i< [[_dataInfo valueForKey:@"Vehicle"]count]; i++)
    {
        if ([KAppDelegate.packages objectForKey:[[[_dataInfo valueForKey:@"Vehicle"] valueForKey:@"veh_id"] objectAtIndex:i]])
        {
            
            [vehicles addObject:[[_dataInfo valueForKey:@"Vehicle"] objectAtIndex:i]];
            
            NSLog(@"found at %@",vehicles);
        }
        else
        {
            NSLog(@"not found");
        }
    }
    
    
    CGRect frame2 = btnRequest.frame;
    frame2.size.height = 60;//rect.size.width;
    [btnRequest setFrame:frame2];
    
    CGFloat height = tblVehicle.rowHeight;
    height *= vehicles.count;
    tableviewHeightConstraint.constant = height+50;
    
    CGRect frame1 = tblVehicle.frame;
    frame1.size.height = tableviewHeightConstraint.constant;//rect.size.width;
    [tblVehicle setFrame:frame1];
    
    [tblVehicle setNeedsLayout];
    [tblVehicle setNeedsDisplay];
    [tblVehicle reloadData];
    
    [self.view setNeedsUpdateConstraints];
}
-(void)HighLite
{
    if (Checked && IsObNotNil([[KAppDelegate.CardDetail valueForKey:ob.data.cust_id] valueForKey:@"card_no"]))
    {
        [btnRequest setBackgroundColor:[UIColor colorWithRed:10/255.0f green:228/255.0f blue:135/255.0f alpha:1.0]];
    }
}
-(void)viewOndemandTapped:(UIGestureRecognizer *)recognizer
{
    NSLog(@"tapped");
    Checked = true;
    btnTimeSelect.hidden = YES;
    imgDemand.hidden = NO;
    lblETA.textColor = [obNet colorWithHexString:@"FF000000"];
    
    imgSchedule.hidden = YES;
    lblDateTime.textColor = [obNet colorWithHexString:@"D2D2D2"];
    
    pickerHeightConstarint.constant = 0;
    pickerViewHeightConstraint.constant = 0;
    
    CGRect frame = viewPicker.frame;
    frame.size.height = pickerViewHeightConstraint.constant;//rect.size.width;
    [viewPicker setFrame:frame];
    
    [viewPicker setNeedsUpdateConstraints];
    [pickerDate setNeedsUpdateConstraints];
    [pickerDate setNeedsLayout];
    [self.view needsUpdateConstraints];
    
    [self HighLite];
    
    scheduleChecked = NO;
    ondemandChecked = YES;
    
}
-(void)viewScheduleTapped:(UIGestureRecognizer *)recognizer
{
    NSLog(@"tapped");
    Checked = true;
    btnTimeSelect.hidden = NO;
    imgSchedule.hidden = NO;
    lblDateTime.textColor = [obNet colorWithHexString:@"FF000000"];
    
    imgDemand.hidden = YES;
    lblETA.textColor = [obNet colorWithHexString:@"D2D2D2"];
    
    pickerHeightConstarint.constant = pickerHeight;
    pickerViewHeightConstraint.constant = pickerViewheight;
    
    CGRect frame = viewPicker.frame;
    frame.size.height = pickerViewheight;//rect.size.width;
    [viewPicker setFrame:frame];
    
    CGRect frame1 = btnRequest.frame;
    frame1.size.height = 60;//rect.size.width;
    [btnRequest setFrame:frame1];
    
    
    [viewPicker setNeedsUpdateConstraints];
    [self.view needsUpdateConstraints];
    [pickerDate setNeedsUpdateConstraints];
    [pickerDate setNeedsLayout];
    
    [self HighLite];
    
    
    scheduleChecked = YES;
    ondemandChecked = NO;
    
}
-(void)viewAddPaymetmethodTapped:(UIGestureRecognizer *)recognizer
{
    NSLog(@"tapped");
    NSMutableDictionary *senddict = [[NSMutableDictionary alloc] init];
    [senddict setObject:@"CheckoutPage" forKey:@"From"];
    [_delegate Push:VC_PaymentMethodPage Data:senddict];
    
}
- (void)viewDidLayoutSubviews
{
    CGRect frame1 = btnRequest.frame;
    frame1.size.height = 60;//rect.size.width;
    [btnRequest setFrame:frame1];
    
    [scrlBack setContentSize:CGSizeMake([obNet deviceFrame].size.width, viewPayment.frame.size.height + viewSchedule.frame.size.height + viewTime.frame.size.height + viewPicker.frame.size.height + tblVehicle.frame.size.height + viewVehicle.frame.size.height + viewLocation.frame.size.height + viewTotal.frame.size.height + btnRequest.frame.size.height+50)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loceditFire:(id)sender
{
    NSMutableDictionary *senddict = [[NSMutableDictionary alloc] init];
    [senddict setObject:[_dataInfo valueForKey:@"Vehicle"] forKey:@"Vehicle"];
    [senddict setObject:@"checkout" forKey:@"From"];
    [_delegate Push:VC_AddLocationPage Data:senddict];
}
- (void) dateChanged:(id)sender
{
    // handle date changes
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:DATEFORMATE];
    lblDateTime.text =  [dateFormat stringFromDate:[self nextHourDate:[pickerDate date]]];
    
}
/// Round Date To Next Hour
- (NSDate*) nextHourDate:(NSDate*)inDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components: NSEraCalendarUnit|NSYearCalendarUnit| NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit fromDate: inDate];
    [comps setHour: [comps hour]+1]; // Here you may also need to check if it's the last hour of the day
    return [calendar dateFromComponents:comps];
}
- (IBAction)timeSelectFire:(id)sender
{
    btnTimeSelect.hidden = YES;
    pickerHeightConstarint.constant = 0;
    pickerViewHeightConstraint.constant = 0;
    
    CGRect frame = viewPicker.frame;
    frame.size.height = pickerViewHeightConstraint.constant;//rect.size.width;
    [viewPicker setFrame:frame];
    
    [viewPicker setNeedsUpdateConstraints];
    [pickerDate setNeedsUpdateConstraints];
    [pickerDate setNeedsLayout];
    [self.view needsUpdateConstraints];
    
}


////////////////////////////////////////////////////   TableView Dele and Source Method  /////////////////////////////////////////////////////////////

#pragma mark TableView Delegate methods For Menu

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return vehicles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"VehicleList";
    
    VehicleListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[VehicleListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    
    VehicleObData *obData = vehicles[indexPath.row];
    
    cell.lblYear.text = [NSString stringWithFormat:@"%@ %@ %@",[obData valueForKey:@"model_year"] , [obData valueForKey:@"make"] , [obData valueForKey:@"model"]];
    cell.lblType.text = [obData valueForKey:@"type"];
    
    cell.lblPackage.text = @"";
    cell.imgCheck.hidden = YES;
    cell.btnMsg.hidden = YES;
    [cell.btnSelect setImage:[UIImage imageNamed:@"Minus Circle - FontAwesome"] forState:UIControlStateNormal];
    [cell.btnSelect setTitle:@"" forState:UIControlStateNormal];
    
    [cell.btnSelect addTarget:self action:@selector(RemoveFire:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSMutableAttributedString *attributedStringsecond = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Package: %@$%.f",[[KAppDelegate.packages objectForKey:[obData valueForKey:@"veh_id"]] valueForKey:@"title"],[[KAppDelegate.PackagePrice objectForKey:[obData valueForKey:@"veh_id"]] floatValue]]];
    [attributedStringsecond addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor colorWithRed:94/255 green:94/255 blue:94/255 alpha:1]
                                   range:NSMakeRange(0, 8)];
    [attributedStringsecond addAttribute:NSUnderlineStyleAttributeName
                                   value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                   range:NSMakeRange(0, attributedStringsecond.length)];
    cell.lblPackage.attributedText = attributedStringsecond;
    cell.btnSelect.hidden = NO;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void) myCellDelegateDidCheck:(UITableViewCell*)checkedCell
{
    NSIndexPath *indexPath = [tblVehicle indexPathForCell:checkedCell];
    
    VehicleObData *obData = vehicles[indexPath.row];
    
    NSMutableDictionary *sendDict = [[NSMutableDictionary alloc] init];
    [sendDict setObject:[NSString stringWithFormat:@"%@ %@ %@",[obData valueForKey:@"model_year"] , [obData valueForKey:@"make"] , [obData valueForKey:@"model"]] forKey:@"model"];
    [sendDict setObject:obData forKey:@"VehicleObData"];
    [_delegate Push:VC_SelectPackage Data:sendDict];
}
-(IBAction)RemoveFire:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tblVehicle];
    NSIndexPath *indexPath = [tblVehicle indexPathForRowAtPoint:currentTouchPosition];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Are You Sure Want To Delete This Vehicle.", nil];
    actionSheet.tag = indexPath.row;
    [actionSheet showInView:self.view];
    
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        NSString *ids = [[vehicles valueForKey:@"veh_id"] objectAtIndex:actionSheet.tag];
        
        if ([KAppDelegate.packages objectForKey:ids])
        {
            [KAppDelegate.packages removeObjectForKey:ids];
            [KAppDelegate.intructions removeObjectForKey:ids];
            [KAppDelegate.PackagePrice removeObjectForKey:ids];
        }
        else
        {
            NSLog(@"not found");
        }
        
        if (KAppDelegate.packages.count > 0)
        {
            [self findVehicleFromPackages];
            [self priceCalculation];
        }
        else
        {
            [_delegate Push:VC_HomePage Data:nil];
        }
        NSLog(@"Delete Now");
    }
    
}

#define  request Fire Here


- (IBAction)requestFire:(id)sender
{
    NSString * msg = nil;
    if (Checked == false)
    {
        msg = @"Please Select Schedule Wash";
    }
    if (msg)
    {
        ToastMSG(msg);
    }
    else
    {
        
        NSMutableString *veh_ids = [[NSMutableString alloc] init];
        NSMutableString *pkg_ids = [[NSMutableString alloc] init];
        NSMutableString *inst_ids = [[NSMutableString alloc] init];
        
        for (int i = 0; i <vehicles.count; i++)
        {
            
            [veh_ids appendString:[NSString stringWithFormat:@"%@,",[vehicles objectAtIndex:i][@"veh_id"]]];
            [pkg_ids appendString:[NSString stringWithFormat:@"%@,",[[KAppDelegate.packages objectForKey:[[vehicles valueForKey:@"veh_id"] objectAtIndex:i]]valueForKey:@"pkg_id"]]];
            [inst_ids appendString: [NSString stringWithFormat:@"%@,",[KAppDelegate.intructions valueForKey:[[vehicles valueForKey:@"veh_id"] objectAtIndex:i]]]];
            
        }
        veh_ids = (NSMutableString*)[veh_ids substringToIndex:[veh_ids length]-1];
        pkg_ids = (NSMutableString*)[pkg_ids substringToIndex:[pkg_ids length]-1];
        inst_ids = (NSMutableString*)[inst_ids substringToIndex:[inst_ids length]-1];
        
        
        
        NSMutableDictionary * mD = [NSMutableDictionary new];
        
        mD[@"cust_id"] = ob.data.cust_id;
        mD[@"veh_ids"] = veh_ids;
        mD[@"pkg_ids"] = pkg_ids;
        mD[@"inst_ids"] = inst_ids;
        mD[@"loc_id"] = [[KAppDelegate.locationDict valueForKey:@"FinalLocation"] valueForKey:@"loc_id"];
        mD[@"pay_id"] = [[KAppDelegate.CardDetail valueForKey:ob.data.cust_id] valueForKey:@"pay_id"];
        mD[@"order_total"] = [NSString stringWithFormat:@"%i",total];
        if (ondemandChecked)
        {
            mD[@"ondemand"] = @"35 min";
        }
        else
        {
            mD[@"ondemand"] = @"";
        }
        
        mD[@"message"] = @"First Order";
        if (scheduleChecked)
        {
            mD[@"schedule"] = lblDateTime.text;
        }
        else
        {
            mD[@"schedule"] = @"";
        }
        
        
        [obNet JSONFromWebServices:WS_washcart Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
         {
             if (IsObNotNil(json))
             {
                 if ([json[@"success"] integerValue] == 1)
                 {
                     ToastMSG(json[@"message"][@"title"]);
                     
                     KAppDelegate.packages = [NSMutableDictionary new];
                     KAppDelegate.intructions = [NSMutableDictionary new];
                     KAppDelegate.PackagePrice = [NSMutableDictionary new];
                     
                     [_delegate Push:VC_HomePage Data:nil];
                     
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
