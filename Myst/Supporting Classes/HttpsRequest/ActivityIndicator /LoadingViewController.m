//
//  LoadingViewController.m
//  Editure
//
//  Created by nilesh on 06/02/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoadingViewController.h"

@implementation LoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        CGPoint point = [KAppDelegate window].center;
        self.view.frame=CGRectMake(point.x-57, point.y-50, 120, 120);
        [[KAppDelegate window] addSubview:self.view];
        
        img.layer.masksToBounds = YES;
        img.layer.cornerRadius = 5.0;
        img.layer.borderWidth = 2.0;
        img.layer.borderColor = [[UIColor redColor] CGColor];
        
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 5.0;
        back.layer.borderWidth = 1.0;
        back.layer.borderColor = [[obNet colorWithHexString:@"FFFFFF"] CGColor];
    }
    
    return self;
}

+(LoadingViewController *) instance
{
	static LoadingViewController *instance;
	@synchronized (self)
	{
		if( !instance){
			instance = [[ LoadingViewController alloc] initWithNibName:@"LoadingViewController" bundle:nil];          
		}
	}
	return instance;
}

-(void)stopRotation
{
    //[self performSelectorInBackground:@selector(stopRotationThread) withObject:self];
    [self performSelectorOnMainThread:@selector(stopRotationThread) withObject:self waitUntilDone:NO];
    /*[[KAppDelegate window] setUserInteractionEnabled:YES];
	[self.view setHidden:YES];
    [[KAppDelegate window] sendSubviewToBack:self.view];*/
}

-(void) stopRotationThread
{
    @try {
        [self performSelectorOnMainThread:@selector(stopRotationMainThread) withObject:self waitUntilDone:NO];
        [self.view setHidden:YES];
    } @catch (NSException *exception) { }
}

-(void) stopRotationMainThread
{
    @try {
        [[KAppDelegate window] setUserInteractionEnabled:YES];
        [[KAppDelegate window] sendSubviewToBack:self.view];
    } @catch (NSException *exception) { }
}

-(void) stopRotationMainThreadB
{
    [[KAppDelegate window] sendSubviewToBack:self.view];
}

-(IBAction)startRotation:(NSString *)text
{
    lblMsg.text = text;
    //[self performSelectorInBackground:@selector(startRotationThread) withObject:self];
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        [self startRotationThread];
       // [self performSelectorOnMainThread:@selector(startRotationThread) withObject:self waitUntilDone:NO];
    });
    
    /*[[KAppDelegate window] setUserInteractionEnabled:NO];
	[[KAppDelegate window] bringSubviewToFront:self.view];
    [self.view setHidden:NO];*/
}

- (void) startRotationThread
{
    @try {
        [self performSelectorOnMainThread:@selector(startRotationMainThread) withObject:self waitUntilDone:NO];
        [[KAppDelegate window] bringSubviewToFront:self.view];
        [self.view setHidden:NO];
    } @catch (NSException *exception) { }
}

- (void) startRotationMainThread
{
   // [[KAppDelegate window] setUserInteractionEnabled:NO];
}

- (void) startRotationMainThreadB
{
	[[KAppDelegate window] bringSubviewToFront:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
