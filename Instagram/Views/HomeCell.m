//
//  HomeCell.m
//  Instagram
//
//  Created by Ogo-Oluwasobomi Popoola on 7/6/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import "HomeCell.h"
#import "UIImageView+AFNetworking.h"
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
        self.username = user.username;
    } else {
        self.usernameLabel.text = @"🤖";
        self.lowerUsernameLabel.text = @"🤖";
        self.username = user.username;
    }
    [self.postedImage loadInBackground];
    self.synopsisLabel.text = post.caption;
    self.numLikes.text = [NSString stringWithFormat: @"%@", post.likeCount];
    self.profilePicture.layer.cornerRadius = 25;
    self.profilePicture.layer.masksToBounds = YES;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *createdAt = [self.post createdAt];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    [formatter setDateFormat:@"h:mm a"];
    self.createdAtLabel.text = [formatter stringFromDate: createdAt];
    [self fetchProfileData];
}

-(void) fetchProfileData{
    if (self.username != @"🤖"){
        PFQuery *query = [PFQuery queryWithClassName: self.username];
        [query includeKey: @"author"];
        [query orderByDescending: @"createdAt"];
        query.limit = 20;
        [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
            if (posts != nil) {
                if (posts.count > 0){
                    NSDictionary *post = [posts objectAtIndex: 0];
                    PFFileObject *imageData = post[@"image"];
                    NSString *imageUrlString = imageData.url;
                    NSURL *imageUrl = [NSURL URLWithString: imageUrlString];
                    [self.profilePicture setImageWithURL: imageUrl];
                }
            } else {
                NSLog(@"%@", error.localizedDescription);
            }
        }];
    }
}
@end
