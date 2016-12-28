//
//  AddvehiclePage.m
//  Myst
//
//  Created by Vipul Jikadra on 15/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "AddvehiclePage.h"
#import "HomePage.h"
#import "VehicleOb.h"
#import "VehicleListCell.h"
@interface AddvehiclePage ()
{
    VehicleOb *vOB;
    VehicleObData *obDatas;
}
@end

@implementation AddvehiclePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tblVehicle.delegate = self;
    tblVehicle.dataSource = self;
    
    tblVehicle.hidden = YES;
    btnNext.hidden = YES;
    [carview bringSubviewToFront:carImage];
    
    carview.hidden = YES;
    
    [tblVehicle registerNib:[UINib nibWithNibName:@"VehicleListCell" bundle:nil] forCellReuseIdentifier:@"VehicleList"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSMutableDictionary * mD = [NSMutableDictionary new];
    
    UserInfo *ob = [obNet getUserInfoObject];
    
    packages = [NSMutableArray new];

    
    mD[@"cust_id"] = ob.data.cust_id;
    [obNet JSONFromWebServices:WS_getVehicle Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         if (IsObNotNil(json))
         {
             
             if ([json[@"success"] integerValue] == 1)
             {
                 NSError* err = nil;
                 vOB = [[VehicleOb alloc]initWithDictionary:json error:&err];
                 
                 if (vOB.data.count > 0)
                 {
                     carview.hidden = YES;
                     [tblVehicle reloadData];
                     tblVehicle.hidden = NO;
                     btnNext.hidden = NO;
                    
                 }
                 else
                 {
                     carview.hidden = NO;
                     btnNext.hidden = YES;

                 }
             }
             else
             {
                 ToastMSG(json[@"message"][@"title"]);
                 carview.hidden = NO;
                 btnNext.hidden = YES;
             }
             
         }
         else
         {
             ToastMSG(json[@"message"][@"title"]);
         }
         
     }];

    [self PriceCalculation];
    
}
-(void)PriceCalculation
{
    if (KAppDelegate.packages.count != 0)
    {
        [btnNext setTitleColor:[obNet colorWithHexString:@"0AE587"] forState:UIControlStateNormal];
        [btnNext setImage:[UIImage imageNamed:@"angle-double-right - FontAwesome"] forState:UIControlStateNormal];
        btnNext.userInteractionEnabled = YES;
        viewFooter.hidden = NO;
        int a = 0;
        for (NSString* key in [KAppDelegate.PackagePrice allKeys])
        {
            NSLog(@"key ==== %@",key);
            
            a = a + [[KAppDelegate.PackagePrice objectForKey:key]integerValue];
        }
        
        lblTotal.text = [NSString stringWithFormat:@"$%i",a];
        footerHeight.constant = 54;
    }
    else
    {
        [btnNext setTitleColor:[obNet colorWithHexString:@"D8D8D8"] forState:UIControlStateNormal];
        [btnNext setImage:[UIImage imageNamed:@"angle-double-right unselected- FontAwesome"] forState:UIControlStateNormal];
        btnNext.userInteractionEnabled = NO;
        viewFooter.hidden = YES;
        footerHeight.constant = 0;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView Delegate methods For Menu

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //minimum size of your cell, it should be single line of label if you are not clear min. then return UITableViewAutomaticDimension;
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return vOB.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"VehicleList";
    VehicleListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[VehicleListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    
    VehicleObData *obData = vOB.data[indexPath.row];
    
    cell.lblYear.text = [NSString stringWithFormat:@"%@ %@ %@",[obData valueForKey:@"model_year"] , [obData valueForKey:@"make"] , [obData valueForKey:@"model"]];
    cell.lblType.text = [obData valueForKey:@"type"];
    
    cell.lblPackage.text = @"";
    
    cell.imgCheck.hidden = YES;
    cell.btnMsg.hidden = YES;
    
    [cell.btnSelect addTarget:self action:@selector(SelectFire:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnMsg addTarget:self action:@selector(MsgFire:event:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([KAppDelegate.packages objectForKey:[[vOB.data valueForKey:@"veh_id"] objectAtIndex:indexPath.row]])
    {
        NSMutableAttributedString *attributedStringsecond = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Package: %@$%.f",[[KAppDelegate.packages objectForKey:[[vOB.data valueForKey:@"veh_id"] objectAtIndex:indexPath.row]]valueForKey:@"title"],[[KAppDelegate.PackagePrice objectForKey:[[vOB.data valueForKey:@"veh_id"] objectAtIndex:indexPath.row]] floatValue]]];
        [attributedStringsecond addAttribute:NSForegroundColorAttributeName
                                       value:[UIColor colorWithRed:94/255 green:94/255 blue:94/255 alpha:1]
                                       range:NSMakeRange(0, 8)];
        [attributedStringsecond addAttribute:NSUnderlineStyleAttributeName
                                       value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                       range:NSMakeRange(0, attributedStringsecond.length)];
        cell.lblPackage.attributedText = attributedStringsecond;
        cell.btnSelect.hidden = YES;
        cell.imgCheck.hidden = NO;
        
    }
    else
    {
        cell.btnSelect.hidden = NO;
        cell.imgCheck.hidden = YES;
    }
 
    if ([KAppDelegate.intructions objectForKey:[[vOB.data valueForKey:@"veh_id"] objectAtIndex:indexPath.row]])
    {
        cell.btnMsg.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(IBAction)MsgFire:(id)sender event:(id)event
{
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tblVehicle];
    NSIndexPath *indexPath = [tblVehicle indexPathForRowAtPoint:currentTouchPosition];
    
    VehicleObData *obData = vOB.data[indexPath.row];
    
    NSMutableDictionary *sendDict = [[NSMutableDictionary alloc] init];
    [sendDict setObject:[NSString stringWithFormat:@"%@ %@ %@",[obData valueForKey:@"model_year"] , [obData valueForKey:@"make"] , [obData valueForKey:@"model"]] forKey:@"model"];
    [sendDict setObject:obData forKey:@"VehicleObData"];
    [_delegate Push:VC_SelectPackage Data:sendDict];
    
}

-(IBAction)SelectFire:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tblVehicle];
    NSIndexPath *indexPath = [tblVehicle indexPathForRowAtPoint:currentTouchPosition];
    
    VehicleObData *obData = vOB.data[indexPath.row];
    
    NSMutableDictionary *sendDict = [[NSMutableDictionary alloc] init];
    [sendDict setObject:[NSString stringWithFormat:@"%@ %@ %@",[obData valueForKey:@"model_year"] , [obData valueForKey:@"make"] , [obData valueForKey:@"model"]] forKey:@"model"];
    [sendDict setObject:obData forKey:@"VehicleObData"];
    [_delegate Push:VC_SelectPackage Data:sendDict];

}
- (IBAction)addVehicleFire:(id)sender
{
    VehicleObData *obData = [VehicleObData new];
    NSMutableDictionary *sendDict = [NSMutableDictionary new];
    [sendDict setObject:@"Add a Vehicle" forKey:@"title"];
    [sendDict setObject:obData forKey:@"data"];
    [self.delegate ShowVehicleView:sendDict];
}

- (IBAction)nextFire:(id)sender
{
    
}

- (IBAction)addFire:(id)sender
{
    VehicleObData *obData = [VehicleObData new];
    NSMutableDictionary *sendDict = [NSMutableDictionary new];
    [sendDict setObject:@"Add a Vehicle" forKey:@"title"];
    [sendDict setObject:obData forKey:@"data"];
    [self.delegate ShowVehicleView:sendDict];
}
-(void) myCellDelegateDidCheck:(UITableViewCell*)checkedCell
{
    NSIndexPath *indexPath = [tblVehicle indexPathForCell:checkedCell];
    
    VehicleObData *obData = vOB.data[indexPath.row];
    
    NSMutableDictionary *sendDict = [[NSMutableDictionary alloc] init];
    [sendDict setObject:[NSString stringWithFormat:@"%@ %@ %@",[obData valueForKey:@"model_year"] , [obData valueForKey:@"make"] , [obData valueForKey:@"model"]] forKey:@"model"];
    [sendDict setObject:obData forKey:@"VehicleObData"];
    [_delegate Push:VC_SelectPackage Data:sendDict];
}
-(void) ImageTapped:(UITableViewCell*)checkedCell
{
    NSIndexPath *indexPath = [tblVehicle indexPathForCell:checkedCell];
    
    VehicleObData *obData = vOB.data[indexPath.row];
    [KAppDelegate.packages removeObjectForKey:[obData valueForKey:@"veh_id"]];
    [KAppDelegate.PackagePrice removeObjectForKey:[obData valueForKey:@"veh_id"]];
    [KAppDelegate.intructions removeObjectForKey:[obData valueForKey:@"veh_id"]];
    
    [self PriceCalculation];
    
    [tblVehicle reloadData];
}
- (IBAction)setNext:(id)sender
{
    if (KAppDelegate.packages.count != 0)
    {
    NSMutableDictionary *senddict = [[NSMutableDictionary alloc] init];
    [senddict setObject:vOB.data forKey:@"Vehicle"];
    [senddict setObject:@"" forKey:@"From"];
    [_delegate Push:VC_AddLocationPage Data:senddict];
    }
    else
    {
        [obNet Toast:@"Please Select Atleast One Package For Moving Ahead :)"];
    }
}
@end
