//
//  HomeCell.h
//  Instagram
//
//  Created by Ogo-Oluwasobomi Popoola on 7/6/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UITableViewCell

@property (nonatomic, strong) Post *post;
@property (strong, nonatomic) IBOutlet PFImageView *postedImage;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
-(void)setPost:(Post *)post;

@end

NS_ASSUME_NONNULL_END
