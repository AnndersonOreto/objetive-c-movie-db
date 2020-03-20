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
}

@end

@implementation ViewController
NSCache<NSString*, UIImage *> *cache;

- (void)viewDidLoad {
    [super viewDidLoad];
    service = [[Services alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        [self->service getPopularMovies];
        
        sleep(5);
        
        self.popularMovies = self->service.popularMovies;
        
        [self.moviesTableView reloadData];
        
    });
    
    self.moviesTableView.separatorColor = [UIColor clearColor];
    
    
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Popular Movies";
    } else {
        return @"Now Playing";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return [self.nowPlaying count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell1";
    TableViewCellController *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    if (indexPath.section == 0){
        
        Movie *movie = self.popularMovies[indexPath.row];
        
        if (movie != nil) {
            cell.movieTitleLabel.text = movie.movieTitle;
            cell.descriptionLabel.text = movie.movieDescription;
            cell.ratingLabel.text = movie.movieRating.stringValue;
            
            NSString *base_url = @"https://image.tmdb.org/t/p/w500";
            NSString *imagePath = [NSString stringWithFormat: @"%@%@", base_url, movie.movieImage];
            cache = [NSCache<NSString*, UIImage *> new];
            NSURL *url = [NSURL URLWithString:imagePath];
            UIImage *image = [cache objectForKey:imagePath];
            
            if (image == nil) {
                
                [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    
                    if (error) {
                        return;
                    }
                    
                    UIImage *image = [UIImage imageWithData:data];
                    [cache setObject: image forKey:imagePath];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.imagePoster.image = [cache objectForKey:imagePath];
                    });
                    
                }] resume];
                
            } else {
                
                cell.imagePoster.image = [cache objectForKey:imagePath];
            }
        }
    } else {
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Movie* movie;
    if (indexPath.section == 0) {
        movie = self.popularMovies[indexPath.row];
    } else {
        movie = self.nowPlaying[indexPath.row];
    }
    
    DetailViewController *cell = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    cell.selectedMovie = movie;
    
    [self.navigationController pushViewController:cell animated:YES];
}

- (void)passData {
}


@end
