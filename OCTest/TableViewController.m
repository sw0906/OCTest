//
//  TableViewController.m
//  OCTest
//
//  Created by shou wei on 25/11/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"




@interface TableViewController ()
@property (nonatomic, strong) NSCache *imageCache;
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queue = [NSOperationQueue new];
    self.imageCache = [NSCache new];
    self.imageCache.countLimit = 100;

    
//    self.users = [self getUsers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"hallo";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //    NSMutableArray *marr = [hallo objectAtIndex:indexPath.section];
    NSDictionary *dict = [NSDictionary new];//[marr objectAtIndex:indexPath.row];
    
    NSString* imageName = [dict objectForKey:@"Image"];
    //NSLog(@"url: %@", imageURL);
    
    UIImage *image = [_imageCache objectForKey:imageName];
    
    //test
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    NSInteger imgCost = [imgData length];
    self.imageCache.totalCostLimit = imgCost*100;
    
    if(image)
    {
        cell.imageView.image = image;
    }
    else
    {
        //download
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString* imageURLString = [NSString stringWithFormat:@"example.com/%@", imageName];
            NSURL *imageURL = [NSURL URLWithString:imageURLString];
            UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:imageURL]];
            
            if(image)
            {
                //update - 一般用dispatch_sync，不用dispatch_async
                dispatch_sync(dispatch_get_main_queue(), ^{
                    CustomCell *cell =(CustomCell*)[self.tableView cellForRowAtIndexPath:indexPath];
                    if(cell)
                    {
                        cell.imageView.image = image;
                    }
                });
                
                [_imageCache setObject:image forKey:imageName];
            }
        });
    }
    
    cell.textLabel.text = [dict objectForKey:@"Name"];
//    [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"iden"];
    
    return cell;
}


- (UITableViewCell *)tableView2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ilvcCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    NSString *imagename = @"";
    
    //read -- cache --  类似 dictionry - plist
    UIImage *image = [_imageCache objectForKey:imagename];
    
    if (image)
    {
        cell.imageView.image = image;
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"blank_cell_image.png"];
        
        
        //add download image block
        [self.queue addOperationWithBlock:^{
            UIImage *image = [UIImage new];// get data from imag url --- [self getImage:imagename];
            
            if (image)
            {
                //add update view  - main Queue
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                    if (cell)
                        cell.imageView.image = image;
                }];
                
                //write -- cache
                [_imageCache setObject:image forKey:imagename];
            }
        }];
    }
    
    return cell;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
