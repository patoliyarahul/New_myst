//
//  EncodedString.m
//  SaveLife
//
//  Created by animesh on 20/11/14.
//  Copyright (c) 2014 vsure. All rights reserved.
//

#import "NSString+EncodeString.h"

@implementation NSString (EncodeString)
+ (NSString *) encodeString:(NSString *)string {
    NSString *newString = NSMakeCollectable([(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) autorelease]);
    
    return newString;
}

- (NSString *) capitalizedFirstLetter {
    NSString *retVal = self;
    if (self.length <= 1) {
        retVal = self.capitalizedString;
    } else {
        retVal = [NSString stringWithFormat:@"%@%@",[[self substringToIndex:1] uppercaseString],[self substringFromIndex:1]];
        //retVal = string(@"%@%@",[[self substringToIndex:1] uppercaseString],[self substringFromIndex:1]);
    }
    
    return retVal;
}

@end
