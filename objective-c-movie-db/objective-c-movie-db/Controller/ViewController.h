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

#pragma mark - Variables

@interface ViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *moviesTableView;

@property (nonatomic, strong) NSMutableArray<Movie*> *popularMovies;
@property (nonatomic, strong) NSMutableArray<Movie*> *nowPlaying;

typedef NS_ENUM(NSInteger, SectionName) {
    NOW_PLAYING         = 1,
    POPULAR_MOVIES      = 0
};

@end

NS_ASSUME_NONNULL_END

