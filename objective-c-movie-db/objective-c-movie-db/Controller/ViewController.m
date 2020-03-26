//
//  ViewController.m
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 16/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "Services.h"
#import "TableViewCellController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    Services *service;
    SectionName secName;
}

@end

@implementation ViewController

#pragma mark - Initializers

- (void)viewDidLoad {
    [super viewDidLoad];
    service = [[Services alloc] init];
    
    
    self.moviesTableView.separatorColor = [UIColor clearColor];
    
    [self getMovies];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    // Do any additional setup after loading the view.
}

#pragma mark - Functions

// Fetch data to present in tabvle view
- (void)getMovies {
    
    [self->service getPopularMovies:^(NSMutableArray<Movie*> *array) {
        self.popularMovies = array;
    }];
    
    [self->service getNowPlaying:^(NSMutableArray<Movie*> *array) {
        self.nowPlaying = array;
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        

        [self.moviesTableView reloadData];
        
    });
}

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == POPULAR_MOVIES) {
        return @"Popular Movies";
    } else {
        return @"Now Playing";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == POPULAR_MOVIES) {
        return 3;
    } else {
        return [self.nowPlaying count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell1";
    TableViewCellController *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    Movie *movie = Movie.new;
    
    if (indexPath.section == POPULAR_MOVIES){
        movie = self.popularMovies[indexPath.row];
    } else {
        movie = self.nowPlaying[indexPath.row];
    }
    
    if (movie != nil) {
        
        cell.movie = movie;
        cell.movieTitleLabel.text = movie.movieTitle;
        cell.descriptionLabel.text = movie.movieDescription;
        cell.ratingLabel.text = movie.movieRating.stringValue;
        
        [service getImage:movie.movieImage completion:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imagePoster.image = image;
            });
        }];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Movie* movie;
    if (indexPath.section == POPULAR_MOVIES) {
        movie = self.popularMovies[indexPath.row];
    } else {
        movie = self.nowPlaying[indexPath.row];
    }
    
    DetailViewController *cell = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    cell.selectedMovie = movie;
    
    [self.navigationController pushViewController:cell animated:YES];
}


@end
