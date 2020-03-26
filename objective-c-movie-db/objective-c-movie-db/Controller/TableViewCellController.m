//
//  ViewController.m
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 16/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

#import "TableViewCellController.h"
#import "Services.h"

@interface TableViewCellController () {
    Services *service;
}

@end

@implementation TableViewCellController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.imagePoster.clipsToBounds = YES;
    
    self.imagePoster.layer.cornerRadius = 12;
    
    self.movieTitleLabel.text = _movie.movieTitle;
    self.descriptionLabel.text = _movie.movieDescription;
    self.ratingLabel.text = _movie.movieRating.stringValue;
}



@end

