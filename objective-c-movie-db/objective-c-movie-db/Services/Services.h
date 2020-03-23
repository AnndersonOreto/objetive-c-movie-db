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

@interface Services : NSObject

@property (strong, nonatomic) NSMutableArray<Movie*> *popularMovies;
@property (strong, nonatomic) NSMutableArray<Movie*> *nowPlayingMovies;

- (void)getPopularMovies:(void (^)(NSMutableArray *)) completionHandler;
- (void)getNowPlaying:(void (^)(NSMutableArray *)) completionHandler;

@end

NS_ASSUME_NONNULL_END



