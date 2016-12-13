//
//  UIImageViewCustom.m
//  myFotocloset
//
//  Created by Ideal IT Techno on 19/05/14.
//  Copyright (c) 2014 Ideal It Technology. All rights reserved.
//

#import "UIImageView+Custom.h"

@interface UIImage (fixorientation)
- (UIImage *) fixOrientation;
@end

@implementation UIImage (fixorientation)
- (UIImage *) fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end

@interface NSString (GetName)
- (NSString *) imageNameFromUrl;
@end

@implementation NSString (GetName)

- (NSString *) imageNameFromUrl
{
    @try {
        NSString * name = [self stringByReplacingOccurrencesOfString:@"." withString:@"_"];
        name = [name stringByReplacingOccurrencesOfString:@"?" withString:@"_"];
        name = [name stringByReplacingOccurrencesOfString:@":" withString:@"_"];
        name = [name stringByReplacingOccurrencesOfString:@"//" withString:@"_"];
        name = [name stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
        name = [name stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
        name = [NSString stringWithFormat:@"%@.jpg", name];
        
        NSArray * arr = [name componentsSeparatedByString:@"_"];
        
        @try {
            if (arr) {
                long divide = arr.count / 2;
                if (divide <= 0) {
                    return name;
                } else {
                    NSString * newName = @"";
                    
                    for (long i = divide; i < arr.count; i++)
                        newName = [NSString stringWithFormat:@"%@%@", newName, arr[i]];
                    
                    return newName;
                }
            }
        } @catch (NSException *exception) { }
        
        return name;
    } @catch (NSException *exception) { }
    /*
     NSArray * arr = [self componentsSeparatedByString:@"/"];
     
     @try {
     if (arr) {
     if (arr.count > 1) {
     NSString * name= arr[arr.count-1];
     
     if ([name rangeOfString:@"?"].location != NSNotFound) {
     
     name = [name stringByReplacingOccurrencesOfString:@"." withString:@"_"];
     
     name = [NSString stringWithFormat:@"%@.jpg", name];
     }
     
     return name;
     }
     }
     } @catch (NSException *exception) { }
     */
    return @"";
}

@end

@implementation UIImageView (custom)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) GetNSetUIImage:(NSString *) url DefaultImage:(NSString *) defaultImage CustomScale:(BOOL) boolScale AI:(UIActivityIndicatorView *) ai
{
    if ([ai isKindOfClass:[UIActivityIndicatorView class]]) {
        [ai setHidden:NO];
        [ai startAnimating];
    }
    
    if (defaultImage == nil)
        defaultImage = @"placeholder.jpg";
    else if (defaultImage.length == 0)
        defaultImage = @"placeholder.jpg";
    
    if (url.length != 0 && ![url isEqualToString:@""] && url != (NSString *)[NSNull null]) {
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary * dict = [NSMutableDictionary new];
        dict[@"url"] = url;
        dict[@"scale"] = [NSNumber numberWithBool:boolScale];
        
        if ([ai isKindOfClass:[UIActivityIndicatorView class]])
            dict[@"ai"] = ai;
        
        if (defaultImage) {
            dict[@"dimage"] = defaultImage;
            [self performSelectorInBackground:@selector(GetNSetUIImage:) withObject:dict];
        } else {
            dict[@"dimage"] = @"";
            [self performSelectorInBackground:@selector(GetNSetUIImage:) withObject:dict];
        }
    } else {
        [self setImage:[UIImage imageNamed:defaultImage]];
        
        if ([ai isKindOfClass:[UIActivityIndicatorView class]]) {
            [ai setHidden:YES];
            [ai stopAnimating];
        }
    }
}

- (void) getSavedPicture:(NSString *) pictureName Block:(void (^)(UIImage * image)) block
{
    NSString * imgFileName = [NSString stringWithFormat:@"%@", pictureName];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirec = [paths objectAtIndex:0];
    NSString * savedPath = [documentsDirec stringByAppendingPathComponent:imgFileName];
    
    UIImage * img = [UIImage imageWithContentsOfFile:savedPath];
    
    block(img);
}

- (void) savePicture:(NSString *) pictureName Image:(UIImage *) img
{
    NSData * data = UIImagePNGRepresentation(img);
    
    if (data) {
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        
        NSString * filePath = [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", pictureName]];
        
        [data writeToFile:filePath atomically:YES];
    }
}

- (void) GetUIImage:(NSString *) url Block:(void (^)(UIImage * image)) block
{
    @try {
        if (url.length != 0 && ![url isEqualToString:@""] && url != (NSString *)[NSNull null]) {
            url = [NSString stringWithFormat:@"%@", url];
            
            NSString * imgFileName = [NSString stringWithFormat:@"%@", [url imageNameFromUrl]];
            NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString * documentsDirec = [paths objectAtIndex:0];
            NSString * savedPath = [documentsDirec stringByAppendingPathComponent:imgFileName];
            
            ///Users/animesh/Library/Developer/CoreSimulator/Devices/EC9A80F0-7D97-49B7-A731-EF879A3AD0EC/data/Containers/Data/Application/92A4F0D1-8D8F-43E1-9EB3-3E847DF662FD/Documents/googlekjdhfpng.jpg
            
            UIImage * img = [UIImage imageWithContentsOfFile:savedPath];
            
            if (img) {
                block(img);
            } else {
                NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse * response, NSData * data, NSError * error)
                 {
                     UIImage * image = nil;
                     
                     if (data != nil) {
                         image = [UIImage imageWithData:data];
                         
                         if (!image) {
                             image = nil;
                         } else {
                             NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                             NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
                             
                             NSString * filePath = [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", [url imageNameFromUrl]]];
                             [data writeToFile:filePath atomically:YES];
                         }
                     } else {
                         image = nil;
                         
                         if ([url imageNameFromUrl].length > 0) {
                             NSArray *directoryContents =  [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] error:NULL];
                             
                             if([directoryContents count] > 0) {
                                 for (NSString *path in directoryContents) {
                                     NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:path];
                                     
                                     NSString * fn = [url imageNameFromUrl];
                                     
                                     NSRange r = [fullPath rangeOfString:fn];
                                     if (r.location != NSNotFound || r.length == [fn length]) {
                                         [[NSFileManager defaultManager] removeItemAtPath:fullPath error:nil];
                                     }
                                 }
                             }
                         }
                     }
                     
                     block(image);
                 }];
            }
        }
    } @catch (NSException *exception) { }
}

- (void) GetNSetUIImage:(NSDictionary *) dict
{
    @try {
        NSString * url = [NSString stringWithFormat:@"%@", dict[@"url"]];
        NSString * defaultImage = dict[@"dimage"];
        NSNumber * boolCustomScale = dict[@"scale"];
        UIActivityIndicatorView * ai  = dict[@"ai"];
        
        [self GetUIImage:url Block:^(UIImage *image) {
            NSMutableDictionary * dict = [NSMutableDictionary new];
            
            dict[@"scale"] = boolCustomScale;
            
            if ([ai isKindOfClass:[UIActivityIndicatorView class]])
                dict[@"ai"] = ai;
            
            if (image) {
                dict[@"image"] = image;
                [self performSelectorInBackground:@selector(setImageMy:) withObject:dict];
            } else {
                dict[@"dimage"] = defaultImage;
                [self performSelectorInBackground:@selector(setImageMy:) withObject:dict];
            }
        }];
    } @catch (NSException *exception) { }
}

- (void) setImageMy:(NSDictionary *) dict
{
    @try {
        NSNumber * boolCustomScale = dict[@"scale"];
        UIActivityIndicatorView * ai  = dict[@"ai"];
        UIImage * image = dict[@"image"];
        NSString * dimage = dict[@"dimage"];
        
        if (boolCustomScale.boolValue) {
            self.clipsToBounds = YES;
            self.contentMode = UIViewContentModeScaleAspectFill;
        }
        
        if ([image isKindOfClass:[UIImage class]])
            [self setImage:image];
        else if ([dimage isKindOfClass:[NSString class]])
            [self setImage:[UIImage imageNamed:dimage]];
        
        
        if ([ai isKindOfClass:[UIActivityIndicatorView class]]) {
            [ai setHidden:YES];
            [ai stopAnimating];
        }
    } @catch (NSException *exception) { }
}

@end










