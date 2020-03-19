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

- (void)viewDidLoad {
    [super viewDidLoad];
    service = [[Services alloc] init];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        [self->service getPopularMovies];
        
        sleep(5);
        
        self.popularMovies = self->service.popularMovies;
        
        [self.moviesTableView reloadData];
        
    });
    
    
    
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
        return [self.popularMovies count];
    } else {
        return 20;
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
        }
    } else {
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self passData];
}

- (void)passData {
    DetailViewController *cell = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    [self.navigationController pushViewController:cell animated:YES];
}


@end
