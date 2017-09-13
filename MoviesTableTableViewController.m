//
//  MoviesTableTableViewController.m
//  MoviesAFn
//
//  Created by Mahmoud Ismaeil Atito on 9/10/17.
//  Copyright © 2017 Mahmoud Ismaeil Atito. All rights reserved.
//

#import "MoviesTableTableViewController.h"
#import "JETSMovie.h"
#import "JETSDBConnection.h"
#import "UIImageView+WebCache.h"
#import "AFURLSessionManager.h"
#import "Show_Movies.h"




@interface MoviesTableTableViewController ()


@property JETSMovie *myMovie;
@property JETSDBConnection *DBMangement;
@property NSMutableArray *allData;
@property JETSMovie *returnedMovie;


@end

@implementation MoviesTableTableViewController
{
    NSMutableArray *M;
    AFHTTPSessionManager *manager;
    AFURLSessionManager *session;
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor =[UIColor clearColor];
    
    
    
   _DBMangement = [JETSDBConnection new];
   _allData = [NSMutableArray new];
    
    //- nsuserdefalut -//
    NSUserDefaults *myDef = [NSUserDefaults standardUserDefaults];
//    [myDef setBool:YES forKey:@"loadOnline"];

    printf("######### %i\n", [myDef boolForKey:@"loadOnline"]);
    
    if ([myDef boolForKey:@"loadOnline"]) {
        NSURL *URL = [NSURL URLWithString:@"https://api.androidhive.info/json/movies.json"];
        // Data Task
        AFURLSessionManager *manage=[[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLRequest *request=[NSURLRequest requestWithURL:URL];
        NSURLSessionDataTask *datatask=[manage dataTaskWithRequest:request completionHandler:^(NSURLResponse *response,id responseObject,NSError *error){
            if (error) {
                printf("Error Connection\n");
            }
            else{
                //NSLog(@"%@ ------- %@",response,responseObject);
                for (int j = 0; j < [responseObject count]; j++) {
                    
                    _myMovie= [JETSMovie new];
                    NSString *tit = [NSString new];
                    tit = [[responseObject objectAtIndex:j] objectForKey:@"title"];
                    
                    
                    NSString *imgPath = [[responseObject objectAtIndex:j] objectForKey:@"image"];
                    [_myMovie setPhoto:imgPath];
                    //NSLog(@"%@", imgPath);
                    NSString *releaseYear = [NSString stringWithFormat:@"%@", [[responseObject objectAtIndex:j] objectForKey:@"releaseYear"]];
                    int yearR = [releaseYear intValue];
                    NSArray *gener = [[responseObject objectAtIndex:j] objectForKey:@"genre"];
                    NSString *rateStr = [NSString stringWithFormat:@"%@", [[responseObject objectAtIndex:j] objectForKey:@"rating"]];
                    int rate = [rateStr intValue];
                    
                    // to parse the array to nsstring
                    NSMutableString *generStr = [NSMutableString new];
                    for (int i = 0; i < [gener count]; i++) {
                        if (i != ([gener count] - 1)) {
                            [generStr appendFormat:@"%@, ", [gener objectAtIndex:i]];
                        } else {
                            [generStr appendFormat:@"%@ ", [gener objectAtIndex:i]];
                        }
                    }
                    
                    [_myMovie setRate:rate];
                    [_myMovie setName:tit];
                    [_myMovie setYear:yearR];
                    [_myMovie setDetails:generStr];
                    //[M addObject:_myMovie];
                    [_DBMangement addRow:_myMovie];
    
                }
                
            }
        }];
        [datatask resume];
        
        // to not come here again
        [myDef setBool:NO forKey:@"loadOnline"];
        [myDef synchronize];
        
    }
    
    _allData = [_DBMangement retriveRows];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_allData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifer=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
   if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }

    _returnedMovie = [JETSMovie new];
    _returnedMovie = [_allData objectAtIndex:indexPath.row];
    
    
    
    //printf("%s",[[[M objectAtIndex:0] photo] UTF8String]);
    cell.textLabel.text = [_returnedMovie name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", [_returnedMovie year]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [_returnedMovie photo]]];
    
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"video-128.png"]];

    return cell;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Show_Movies *showmovies=[storyboard instantiateViewControllerWithIdentifier:@"fromtabletodetail"];
    
    JETSMovie *duck = [JETSMovie new];
    printf("%ld", indexPath.row);
    duck = [_allData objectAtIndex:indexPath.row];
    
    [showmovies setJetsmovie:duck];
    
    [self presentViewController:showmovies animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
          @end

