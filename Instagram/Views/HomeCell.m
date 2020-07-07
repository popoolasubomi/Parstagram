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
    [self.postedImage loadInBackground];
    self.synopsisLabel.text = post.caption;
}
@end
