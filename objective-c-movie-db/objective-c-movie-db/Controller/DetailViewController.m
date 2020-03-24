//
//  ViewController.m
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 16/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    [self setLabelText];
    
    [self setImagePoster];
}

#pragma mark - Functions

- (void) setupLayout {
    
    self.moviePosterImageView.layer.cornerRadius = 12;
    self.title = @"Movie Details";
    self.navigationController.navigationBar.prefersLargeTitles = NO;
}

- (void) setLabelText {
    
    self.movieTitleLaabel.text = self.selectedMovie.movieTitle;
    self.movieRatingLabel.text = self.selectedMovie.movieRating.stringValue;
    self.movieDescriptionTextView.text = self.selectedMovie.movieDescription;
}

- (void) setImagePoster {
    
    NSMutableString *baseImageUrl = [NSMutableString stringWithString:@"https://image.tmdb.org/t/p/w500"];
    NSString *imageURL = [baseImageUrl stringByAppendingString:self.selectedMovie.movieImage];
    
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageURL]];
        
        if ( data == nil ) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *image = [UIImage imageWithData:data];
            self.moviePosterImageView.image = image;
            
        });
    });
}


@end

