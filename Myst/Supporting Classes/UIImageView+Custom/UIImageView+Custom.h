//
//  UIImageViewCustom.h
//  myFotocloset
//
//  Created by Ideal IT Techno on 19/05/14.
//  Copyright (c) 2014 Ideal It Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define obImV ([UIImageView new])

@interface UIImageView (custom)
{
    
}

- (void) GetNSetUIImage:(NSString *) url DefaultImage:(NSString *) defaultImage CustomScale:(BOOL) boolScale AI:(UIActivityIndicatorView *) ai;

- (void) GetUIImage:(NSString *) url Block:(void (^)(UIImage * image)) block;

- (void) getSavedPicture:(NSString *) pictureName Block:(void (^)(UIImage * image)) block;
- (void) savePicture:(NSString *) pictureName Image:(UIImage *) img;

@end



