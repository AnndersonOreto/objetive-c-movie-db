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
    
    self.movieTitleLaabel.text = self.selectedMovie.movieTitle;
    self.movieRatingLabel.text = self.selectedMovie.movieRating.stringValue;
    self.movieDescriptionTextView.text = self.selectedMovie.movieDescription;
    // Do any additional setup after loading the view.
}


@end

