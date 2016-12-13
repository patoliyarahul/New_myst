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
    
    [obNet JSONFromWebServices:WS_getContent Parameter:nil Method:@"GET" AI:YES PopUP:YES Caller:CALLER WithBlock:^(id json)
     {
         if (IsObNotNil(json))
         {
            
             if ([json[@"success"] integerValue] == 1)
             {
                 
                 NSString *myHTML = json[@"data"][@"terms"];
                 webView.delegate = self;
                 [webView loadHTMLString:myHTML baseURL:nil];
                 
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
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    activityIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
