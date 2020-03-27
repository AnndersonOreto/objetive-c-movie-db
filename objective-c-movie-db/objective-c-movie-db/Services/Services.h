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

#pragma mark - Variables

@property (nonatomic, strong) NSString *popularMoviesURL;
@property (nonatomic, strong) NSString *nowPlayingURL;

#pragma mark - Functions

- (void)getPopularMovies:(void (^)(NSMutableArray *)) completionHandler;
- (void)getNowPlaying:(void (^)(NSMutableArray *)) completionHandler;
- (void) getImage:(NSString *)imageName completion:(void (^)(UIImage *))completionHandler;
- (void)loadImage:(NSString *)imageName completion:(void (^)(UIImage *))completionHandler;
- (void)getGenre:(NSString *)movieId completion:(void (^)(NSArray *))completionHandler;

@end

NS_ASSUME_NONNULL_END



