//
//  Show_Movies.h
//  MoviesAFn
//
//  Created by Mahmoud Ismaeil Atito on 9/11/17.
//  Copyright © 2017 Mahmoud Ismaeil Atito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "JETSMovie.h"
//IB_DESIGNABLE and IBInspectable
@interface Show_Movies : UIViewController

@property JETSMovie *jetsmovie;

@property (strong, nonatomic) IBOutlet UILabel *Movie_Title;

@property (strong, nonatomic) IBOutlet UILabel *Genre;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *out1;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *imageback;

@property (strong, nonatomic) IBOutlet UILabel *label_rating;


@property (strong, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) IBOutlet UILabel *year;



- (IBAction)back_btn:(id)sender;


@end
