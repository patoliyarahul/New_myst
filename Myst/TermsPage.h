//
//  TermsPage.h
//  DiamondTrade
//
//  Created by Vipul Jikadra on 18/10/16.
//  Copyright © 2016 Vipul Jikadra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsPage : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
}
@end
