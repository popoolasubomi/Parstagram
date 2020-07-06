//
//  CameraViewController.h
//  Instagram
//
//  Created by Ogo-Oluwasobomi Popoola on 7/5/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSString *cameraType;

@end

NS_ASSUME_NONNULL_END
