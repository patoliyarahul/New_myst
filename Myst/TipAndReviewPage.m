//
//  TipAndReviewPage.m
//  Myst
//
//  Created by Vipul Jikadra on 03/01/17.
//  Copyright © 2017 Vipul Jikadra. All rights reserved.
//

#import "TipAndReviewPage.h"

@interface TipAndReviewPage ()

@end

@implementation TipAndReviewPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [btnSecond.layer addSublayer:[obNet prefix_addUpperBorder:UIRectEdgeRight color:[obNet colorWithHexString:@"D4D4D4"] thickness:1.0 frame:btnOne.frame]];
    [btnOne.layer addSublayer:[obNet prefix_addUpperBorder:UIRectEdgeRight color:[obNet colorWithHexString:@"D4D4D4"] thickness:1.0 frame:btnOne.frame]];
    [btnThird.layer addSublayer:[obNet prefix_addUpperBorder:UIRectEdgeRight color:[obNet colorWithHexString:@"D4D4D4"] thickness:1.0 frame:btnOne.frame]];
    [btnFourth.layer addSublayer:[obNet prefix_addUpperBorder:UIRectEdgeRight color:[obNet colorWithHexString:@"D4D4D4"] thickness:1.0 frame:btnOne.frame]];
    
    originalXOfCardImg = viewFooter.frame.origin.x;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self NotipFire:btnOne];
    viewReview.hidden = YES;
    
    [obNet setBorder:commnets Color:[obNet colorWithHexString:@"EBECFE"] CornerRadious:0 BorderWidth:1.0];
    
    rateingValue = 0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews
{
     [backScrl setContentSize:CGSizeMake([obNet deviceFrame].size.width, imgTip.frame.size.height  + imgDriver.frame.size.height + viewFooter.frame.size.height+btnNext.frame.size.height-20)];
}

- (IBAction)NotipFire:(id)sender
{
    [btnOther setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnOne setBackgroundColor:[obNet colorWithHexString:@"0AE587"]];
    [btnSecond setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnThird setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnFourth setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    
    lblTotal.text = @"$0.00";
}

- (IBAction)TenPercentageFire:(id)sender
{
    [btnOther setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnOne setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnSecond setBackgroundColor:[obNet colorWithHexString:@"0AE587"]];
    [btnThird setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnFourth setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    
    int t = [[[_dataInfo valueForKey:@"order_detail"] valueForKey:@"order_total"] integerValue];
    amount = (t *10.00/100.00);
    
    lblTotal.text = [NSString stringWithFormat:@"$%.2f",amount];
}

- (IBAction)FifteenPercentageFire:(id)sender
{
    [btnOther setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnOne setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnSecond setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnThird setBackgroundColor:[obNet colorWithHexString:@"0AE587"]];
    [btnFourth setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    
    int t = [[[_dataInfo valueForKey:@"order_detail"] valueForKey:@"order_total"] integerValue];
    amount = (t *15.00/100.00);
    
    lblTotal.text = [NSString stringWithFormat:@"$%.2f",amount];
}
- (IBAction)TwentyPercentageFire:(id)sender
{
    [btnOther setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnOne setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnSecond setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnThird setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnFourth setBackgroundColor:[obNet colorWithHexString:@"0AE587"]];
    
    
    int t = [[[_dataInfo valueForKey:@"order_detail"] valueForKey:@"order_total"] integerValue];
    amount = (t *20.00/100.00);
    
    lblTotal.text = [NSString stringWithFormat:@"$%.2f",amount];
}
- (IBAction)OtherFire:(id)sender
{
    [btnOther setBackgroundColor:[obNet colorWithHexString:@"0AE587"]];
    [btnOne setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnSecond setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnThird setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    [btnFourth setBackgroundColor:[obNet colorWithHexString:@"EBECFE"]];
    
    
    int t = [[[_dataInfo valueForKey:@"order_detail"] valueForKey:@"order_total"] integerValue];
    amount = (t *100.00/100.00);
    
    lblTotal.text = [NSString stringWithFormat:@"$%.2f",amount];
}

- (IBAction)nextFire:(id)sender
{
    viewFooter.hidden = YES;
    
    viewReview.hidden = NO;
    
}
- (IBAction)submitFire:(id)sender
{
    NSMutableDictionary * mD = [NSMutableDictionary new];
    
    UserInfo *ob = [obNet getUserInfoObject];
    mD[@"cust_id"] = ob.data.cust_id;

    mD[@"order_id"] = [[_dataInfo valueForKey:@"order_detail"] valueForKey:@"order_id"];
    mD[@"del_id"] = [[_dataInfo valueForKey:@"order_detail"] valueForKey:@"order_id"];;
    mD[@"tip_amount"] = [NSString stringWithFormat:@"%.2f",amount];;
    mD[@"rating"] = [NSString stringWithFormat:@"%f",rateingValue];
    mD[@"comments"] = commnets.text;
    
    [obNet JSONFromWebServices:WS_add_review Parameter:mD Method:@"POST" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         if (IsObNotNil(json))
         {
             if ([json[@"success"] integerValue] == 1)
             {
                 ToastMSG(json[@"message"][@"title"]);
                 
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
     [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)RatingFire:(HCSStarRatingView *)sender
{
    rateingValue = sender.value;
}
@end
