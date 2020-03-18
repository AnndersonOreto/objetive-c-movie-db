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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *movieTitle;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Services *service = [[Services alloc] init];
    [service getPopularMovies];
    
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
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
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
