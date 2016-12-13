
//
//  LoadingViewController.h
//  Editure
//
//  Created by nilesh on 06/02/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

/**
 *	@Class: LoadingViewController
 *	@Description: LoadingViewController class use for implement loading indicator on request start and stop.
 */

@interface LoadingViewController : UIViewController {
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UILabel *lblMsg;
    
    IBOutlet UIImageView *img;
    IBOutlet UILabel *back;
    
    NSString *msgString;
}

+(LoadingViewController *) instance;

/**
 * use for start rotaing activity indicator
 * @param: nil
 * @return: IBAction
 */
-(IBAction)startRotation:(NSString *)text;

/**
 * use for start rotaing activity indicator
 * @param: nil
 * @return: void
 */
-(void)stopRotation;
@end
