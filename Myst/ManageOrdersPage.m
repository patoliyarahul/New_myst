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
@interface ManageOrdersPage ()
{
    OrderOb *orderOb;
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

@end
