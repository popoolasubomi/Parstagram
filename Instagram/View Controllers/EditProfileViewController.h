//
//  EditProfileViewController.h
//  Instagram
//
//  Created by Ogo-Oluwasobomi Popoola on 7/8/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UITextField *displayName;
@property (weak, nonatomic) IBOutlet UITextField *descriptionLabel;

@end

NS_ASSUME_NONNULL_END
