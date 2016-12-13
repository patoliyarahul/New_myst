//
//  EncodedString.h
//  SaveLife
//
//  Created by animesh on 20/11/14.
//  Copyright (c) 2014 vsure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EncodeString)
+ (NSString *)encodeString:(NSString *)string;
- (NSString *) capitalizedFirstLetter;

@end
