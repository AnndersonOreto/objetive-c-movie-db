//
//  ViewController.h
//  objective-c-movie-db
//
//  Created by Annderson Packeiser Oreto on 16/03/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *moviesTableView;

@property (nonatomic, strong) NSMutableArray<Movie*> *popularMovies;
@property (nonatomic, strong) NSMutableArray<Movie*> *nowPlaying;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)NSIndexPath;

@end

NS_ASSUME_NONNULL_END

