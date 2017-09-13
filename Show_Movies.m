//
//  Show_Movies.m
//  MoviesAFn
//
//  Created by Mahmoud Ismaeil Atito on 9/11/17.
//  Copyright © 2017 Mahmoud Ismaeil Atito. All rights reserved.
//

#import "Show_Movies.h"
#import "UIImageView+WebCache.h"
#import "login.h"

@interface Show_Movies ()

@end

@implementation Show_Movies
{
    NSMutableString *genr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [_jetsmovie photo]]];
    [_imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"video-128.png"]];
    [_Movie_Title setText:[_jetsmovie name]];
    [_year setText:[NSString stringWithFormat:@"%d",[_jetsmovie year]] ];
    [_label_rating setText:[NSString stringWithFormat:@"%d",[_jetsmovie rate]] ];
    [_Genre setText:[_jetsmovie details]];
    
    
    [_imageback sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"video-128.png"]];
    _imageback.layer.zPosition = -1;
    
    // Do any additional setup after loading the view.
}
- (IBAction)logout:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    login *vc = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self presentViewController:vc animated:YES completion:nil];}

-(void)viewWillAppear:(BOOL)animated{
    int ratiing =[_jetsmovie rate];
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(35, 506,233, 21)];
    starRatingView.maximumValue = 10;
    starRatingView.minimumValue = 0;
    starRatingView.value = ratiing;
    starRatingView.tintColor = [UIColor blueColor];
     starRatingView.allowsHalfStars = YES;
    
    [starRatingView setEnabled:NO];
    [self.view addSubview:starRatingView];
    
    // passing data to label rating
    
    NSString *str=[NSString stringWithFormat:@"%d",ratiing];
    
    [_label_rating setText:str ];
    
    

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)star_action:(UIButton *)sender {

  /*  NSInteger store=sender.tag;
    for (UIButton *btn in _Star_outlet) {
        
        if (btn.tag<=store ){
            [btn setTitle:@"★" forState:UIControlStateNormal];
            self.label_rating.text=[NSString stringWithFormat:@"%ld / 10",store];
        }
        
        else{
            [btn setTitle:@"☆" forState:UIControlStateNormal];
            
        }
        
    }*/

}
- (IBAction)back_btn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
