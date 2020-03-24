
//
//  ViewController.h
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 16/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface DetailViewController : UIViewController

#pragma mark - Variables

@property (nonatomic, strong) Movie* selectedMovie;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLaabel;
@property (weak, nonatomic) IBOutlet UILabel *movieGenderLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRatingLabel;
@property (weak, nonatomic) IBOutlet UITextView *movieDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImageView;


@end


