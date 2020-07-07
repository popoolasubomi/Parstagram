//
//  DetailsViewController.m
//  Instagram
//
//  Created by Ogo-Oluwasobomi Popoola on 7/7/20.
//  Copyright © 2020 Ogo-Oluwasobomi Popoola. All rights reserved.
//

#import "DetailsViewController.h"
#import "Post.h"
@import Parse;

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *postedImageView;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLikes;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self populateView];
}

- (void)populateView{
    PFUser *user = self.post[@"author"];
    if (user != nil) {
        self.usernameLabel.text = user.username;
    } else {
        self.usernameLabel.text = @"🤖";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *createdAt = [self.post createdAt];
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    [formatter setDateFormat:@"h:mm a"];
    self.createdAtLabel.text = [formatter stringFromDate: createdAt];
    self.numLikes.text = [NSString stringWithFormat: @"%@", self.post.likeCount];
    self.captionLabel.text = self.post.caption;
    self.postedImageView.file = self.post.image;
    [self.postedImageView loadInBackground];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
