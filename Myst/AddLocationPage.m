//
//  AddLocationPage.m
//  Myst
//
//  Created by Vipul Jikadra on 19/12/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "AddLocationPage.h"
#import "LocationOb.h"
#import "LocationObData.h"
#import "LocationCell.h"
@interface AddLocationPage ()
{
    LocationOb *lOB;
    LocationObData *obDatas;
    UserInfo *ob;
}
@end

@implementation AddLocationPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tblLocation.delegate = self;
    tblLocation.dataSource = self;
    
    tblLocation.hidden = YES;
   
    btnPlus.hidden = YES;
    [tblLocation registerNib:[UINib nibWithNibName:@"LocationCell" bundle:nil] forCellReuseIdentifier:@"LocationCell"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    tblLocation.hidden = YES;
    
    NSMutableDictionary * mD = [NSMutableDictionary new];
    
    ob = [obNet getUserInfoObject];
    mD[@"cust_id"] = ob.data.cust_id;
    [obNet JSONFromWebServices:WS_getLocation Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         if (IsObNotNil(json))
         {
             
             if ([json[@"success"] integerValue] == 1)
             {
                 NSError* err = nil;
                 lOB = [[LocationOb alloc]initWithDictionary:json error:&err];
                 
                 if (lOB.data.count > 0)
                 {
                     viewPopup.hidden = YES;
                     [tblLocation reloadData];
                     tblLocation.hidden = NO;
                     
                     btnPlus.hidden = NO;
                 }
                 else
                 {
                     viewPopup.hidden = NO;
                     tblLocation.hidden = YES;
                     
                 }
             }
             else
             {
                 ToastMSG(json[@"message"][@"title"]);
                 viewPopup.hidden = NO;
                 tblLocation.hidden = YES;
             }
             
         }
         else
         {
             ToastMSG(json[@"message"][@"title"]);
         }
         
     }];
    
    if (KAppDelegate.packages.count != 0)
    {
        viewFotter.hidden = NO;
        int a = 0;
        for (NSString* key in [KAppDelegate.PackagePrice allKeys])
        {
            NSLog(@"key ==== %@",key);
            
            a = a + [[KAppDelegate.PackagePrice objectForKey:key]integerValue];
        }
        
        lblTotal.text = [NSString stringWithFormat:@"$%i",a];
    }
    else
    {
        viewFotter.hidden = YES;
    }
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark TableView Delegate methods For Menu


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lOB.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"LocationCell";
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.backgroundColor = [UIColor clearColor];
    
    
    LocationObData *obData = lOB.data[indexPath.row];
    
    cell.lblName.text = [NSString stringWithFormat:@"%@ %@ \n%@ %@ %@",[obData valueForKey:@"street"] , [obData valueForKey:@"unit"] , [obData valueForKey:@"city"],[obData valueForKey:@"state"] ,[obData valueForKey:@"zipcode"]];

    [cell.btnSelect addTarget:self action:@selector(SelectFire:event:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[KAppDelegate.locationDict valueForKey:[obData valueForKey:@"loc_id"]] isEqualToString:[obData valueForKey:@"loc_id"]])
    {
         cell.imgCheck.hidden = NO;
         cell.btnSelect.hidden = YES;
         
         NSIndexPath* selectedCellIndexPath= [NSIndexPath indexPathForRow:indexPath.row inSection:0];
         [self tableView:tblLocation didSelectRowAtIndexPath:selectedCellIndexPath];
         [tblLocation selectRowAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
     }
    else
     {
         cell.imgCheck.hidden = YES;
         cell.btnSelect.hidden = NO;
     }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KAppDelegate.locationDict = [NSMutableDictionary new];
    
    LocationObData *obData = lOB.data[indexPath.row];
    [KAppDelegate.locationDict setObject:[obData valueForKey:@"loc_id"] forKey:[obData valueForKey:@"loc_id"]];
    [KAppDelegate.locationDict setObject:obData forKey:@"FinalLocation"];
    
}

-(IBAction)SelectFire:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tblLocation];
    NSIndexPath *indexPath = [tblLocation indexPathForRowAtPoint:currentTouchPosition];
    
    KAppDelegate.locationDict = [NSMutableDictionary new];
    
    LocationObData *obData = lOB.data[indexPath.row];
    [KAppDelegate.locationDict setObject:[obData valueForKey:@"loc_id"] forKey:[obData valueForKey:@"loc_id"]];
    [KAppDelegate.locationDict setObject:obData forKey:@"FinalLocation"];
    NSLog(@"KAppDelegate.locationDict = %@",KAppDelegate.locationDict);
    [tblLocation reloadData];
    
}

- (IBAction)nextFire:(id)sender
{
    if (KAppDelegate.locationDict.count != 0)
    {
        if ([[_dataInfo valueForKey:@"From"] isEqualToString:@"checkout"])
        {
            [_delegate PopViewController];
        }
        else
        {
            NSMutableDictionary *senddict = [[NSMutableDictionary alloc] init];
            [senddict setObject:[_dataInfo valueForKey:@"Vehicle"] forKey:@"Vehicle"];
            [_delegate Push:VC_CheckoutPage Data:senddict];
        }
    }
    else
    {
        [obNet Toast:@"Please Select Atleast One Location For Moving Ahead :)"];
    }
}
- (IBAction)plusFire:(id)sender
{
    LocationObData *obData = [LocationObData new];
    NSMutableDictionary *sendDict = [NSMutableDictionary new];
    [sendDict setObject:@"Add a Location" forKey:@"title"];
    [sendDict setObject:obData forKey:@"data"];
    
    [_delegate ShowLocationView:sendDict];
}

- (IBAction)AddLocationFire:(id)sender
{
    LocationObData *obData = [LocationObData new];
    NSMutableDictionary *sendDict = [NSMutableDictionary new];
    [sendDict setObject:@"Add a Location" forKey:@"title"];
    [sendDict setObject:obData forKey:@"data"];
    
    [_delegate ShowLocationView:sendDict];
}
@end
