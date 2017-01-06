//
//  ManageOrdersPage.m
//  Myst
//
//  Created by Vipul Jikadra on 31/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "ManageOrdersPage.h"
#import "ManageOrderCell.h"
#import "OrderOb.h"
#import "OrderData.h"
#import "OrderdetailOb.h"
#import "OrderpackagesOb.h"
#import "LocationObData.h"
#import "VehicleObData.h"
#import "PackageObData.h"
@interface ManageOrdersPage ()
{
    OrderOb *orderOb;
    PackageObData *obDataIndex;
}
@end

@implementation ManageOrdersPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tblOrder.delegate = self;
    tblOrder.dataSource = self;
    [tblOrder registerNib:[UINib nibWithNibName:@"ManageOrderCell" bundle:nil] forCellReuseIdentifier:@"ManageOrderCell"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     tblOrder.hidden = YES;
    
    NSMutableDictionary * mD = [NSMutableDictionary new];
    
    UserInfo *ob = [obNet getUserInfoObject];
    carview.hidden = YES;
    mD[@"cust_id"] = ob.data.cust_id;
    mD[@"status"] = @"1";
    [obNet JSONFromWebServices:WS_getorder Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         if (IsObNotNil(json))
         {
             
             if ([json[@"success"] integerValue] == 1)
             {
                 NSError* err = nil;
                 orderOb = [[OrderOb alloc]initWithDictionary:json error:&err];
                 
                 if (orderOb.data.count > 0)
                 {
                     carview.hidden = YES;
                     [tblOrder reloadData];
                     tblOrder.hidden = NO;
                     
                 }
                 else
                 {
                     carview.hidden = NO;
                     tblOrder.hidden = YES;
                     
                 }
             }
             else
             {
                 ToastMSG(json[@"message"][@"title"]);
                 carview.hidden = NO;
                 tblOrder.hidden = YES;
             }
             
         }
         else
         {
             ToastMSG(json[@"message"][@"title"]);
         }
     }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView Delegate methods For Menu


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return orderOb.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"ManageOrderCell";
    ManageOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ManageOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    
    OrderdetailOb *obData = [orderOb.data[indexPath.row] valueForKey:@"order_detail"];
    cell.lblOrderName.text = [obNet ConvertDate:[obData valueForKey:@"created_on"] FromFormate:@"yyyy-MM-dd HH:mm:ss" ToFormate:DATEFORMATE];;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[_dataInfo valueForKey:@"From"] isEqualToString:@"HomePage"])
    {
        NSMutableDictionary *sendDict = [NSMutableDictionary new];
        [sendDict setObject:[orderOb.data[indexPath.row] valueForKey:@"order_detail"] forKey:@"order_detail"];
        if ([[orderOb.data[indexPath.row] valueForKey:@"order_packages"] count] > 0)
        {
            OrderdetailOb *obData = [orderOb.data[indexPath.row] valueForKey:@"order_detail"];
            OrderpackagesOb *obPackageData = [orderOb.data[indexPath.row] valueForKey:@"order_packages"];
            
            /// Set Location
            LocationObData *locOb = [LocationObData new];
            [locOb setCity:[obData valueForKey:@"city"]];
            [locOb setLoc_type:[obData valueForKey:@"loc_type"]];
            [locOb setFullname:[obData valueForKey:@"fullname"]];
            [locOb setStreet:[obData valueForKey:@"street"]];
            [locOb setUnit:[obData valueForKey:@"unit"]];
            [locOb setState:[obData valueForKey:@"state"]];
            [locOb setZipcode:[obData valueForKey:@"zipcode"]];
            [KAppDelegate.locationDict setObject:locOb forKey:@"FinalLocation"];
            
            
            for (int i = 0; i< [[orderOb.data[indexPath.row] valueForKey:@"order_packages"] count]; i++)
            {
                /// Set Vehicle
                VehicleObData *vehOb = [VehicleObData new];
                [vehOb setMake:[[obPackageData valueForKey:@"make"] objectAtIndex:i]];
                [vehOb setModel:[[obPackageData valueForKey:@"model"] objectAtIndex:i]];
                [vehOb setVeh_id:[[obPackageData valueForKey:@"veh_id"] objectAtIndex:i]];
                [vehOb setColor:[[obPackageData valueForKey:@"color"] objectAtIndex:i]];
                [vehOb setModel_year:[[obPackageData valueForKey:@"model_year"] objectAtIndex:i]];
                [vehOb setLicense_plate_no:[[obPackageData valueForKey:@"license_plate_no"] objectAtIndex:i]];
                [vehOb setType:[[obPackageData valueForKey:@"type"] objectAtIndex:i]];
                
                [sendDict setObject:vehOb forKey:@"Vehicle"];
                
                /// Set Package
                
                obDataIndex = [PackageObData new];
                [obDataIndex setTitle:[[obPackageData valueForKey:@"title"] objectAtIndex:i]];
                [obDataIndex setPrice:[[obPackageData valueForKey:@"price"] objectAtIndex:i]];
                //  [obDataIndex setDescription:[[obData valueForKey:@"description"] objectAtIndex:i]];
                [obDataIndex setPkg_id:[[obPackageData valueForKey:@"pkg_id"] objectAtIndex:i]];
                [obDataIndex setImage:[[obPackageData valueForKey:@"image"] objectAtIndex:i]];
                
                if (IsObNotNil(obDataIndex))
                {
                    [KAppDelegate.packages setObject:obDataIndex forKey:vehOb.veh_id];
                }
                
                if (IsObNotNil([[orderOb.data[indexPath.row] valueForKey:@"order_packages"] valueForKey:@"instructions"]))
                {
                    [KAppDelegate.intructions setObject:[[orderOb.data[indexPath.row] valueForKey:@"order_packages"] valueForKey:@"instructions"] forKey:[obPackageData valueForKey:@"veh_id"]];
                }
                else
                {
                    [KAppDelegate.intructions setObject:@"" forKey:[obPackageData valueForKey:@"veh_id"]];
                }
                
               
                    
                [KAppDelegate.PackagePrice setObject:[obDataIndex valueForKey:@"price"] forKey:[vehOb valueForKey:@"veh_id"]];
  
                [KAppDelegate.locationDict setObject:[obData valueForKey:@"loc_id"] forKey:[obData valueForKey:@"loc_id"]];
                
                NSLog(@"Vehicles = %@ , KAppDelegate.packages = %@ , KAppDelegate.intructions = %@ , KAppDelegate.PackagePrice = %@ KAppDelegate.locationDict = %@",sendDict , KAppDelegate.packages , KAppDelegate.intructions , KAppDelegate.PackagePrice ,KAppDelegate.locationDict);
                
            }
            
        }
        
        [_delegate Push:VC_TrackOrderPage Data:sendDict];
    }
    else
    {
         NSMutableDictionary *sendDict = [NSMutableDictionary new];
         [sendDict setObject:[orderOb.data[indexPath.row] valueForKey:@"order_detail"] forKey:@"order_detail"];
         [_delegate ShowTipView:sendDict];
        //[_delegate Push:VC_TrackOrderPage Data:nil];
    }
    
   
}
@end
