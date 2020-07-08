//
//  HomeCell.m
//  Instagram
//
//  Created by Ogo-Oluwasobomi Popoola on 7/6/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import "HomeCell.h"
#import "Post.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPost:(Post *) post{
    _post = post;
    self.postedImage.file = post.image;
    PFUser *user = self.post[@"author"];
    if (user != nil) {
        self.usernameLabel.text = user.username;
        self.lowerUsernameLabel.text = user.username;
    } else {
        self.usernameLabel.text = @"🤖";
        self.lowerUsernameLabel.text = @"🤖";
    }
    [self.postedImage loadInBackground];
    self.synopsisLabel.text = post.caption;
    self.numLikes.text = [NSString stringWithFormat: @"%@", post.likeCount];
    self.profilePicture.layer.cornerRadius = 25;
    self.profilePicture.layer.masksToBounds = YES;
}
@end
