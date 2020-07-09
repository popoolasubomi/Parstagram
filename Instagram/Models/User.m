//
//  User.m
//  Instagram
//
//  Created by Ogo-Oluwasobomi Popoola on 7/8/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import "User.h"
#import <Parse/Parse.h>

@implementation User

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    return [PFFileObject fileObjectWithName: @"image.png" data: imageData];
}

@end
