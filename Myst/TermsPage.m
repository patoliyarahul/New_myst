//
//  TermsPage.m
//  DiamondTrade
//
//  Created by Vipul Jikadra on 18/10/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import "TermsPage.h"

@interface TermsPage ()

@end

@implementation TermsPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [obNet JSONFromWebServices:Get_Content Parameter:nil Method:@"GET" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
//     {
//         if (IsObNotNil(json))
//         {
//             NSString *myHTML = json[@"terms"];
//             
//             webView.delegate = self;
//             [webView loadHTMLString:myHTML baseURL:nil];
//         }
//     }];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    activityIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
