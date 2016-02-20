//
//  TableViewController.m
//  TesteObjectiveC
//
//  Created by Tamyres Freitas on 2/2/16.
//  Copyright © 2016 Tamyres Freitas. All rights reserved.
//

#import "TableViewController.h"
#import "CheckoutViewController.h"
#import <Firebase/Firebase.h>

@interface TableViewController ()

{

NSArray *compras;
NSArray *soproImages;
NSArray *preco;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    // itens
    compras = @[@"Bateria",@"Conga",@"Bongo",@"Pandeirola"];
    preco = @[@"R$ 1,500", @"R$ 80,00", @"R$ 150,00", @"R$ 28,00"];
    soproImages = @[@"bateria.png", @"conga.png", @"bongo.png", @"pandeirola.png"];
    
    NSLog(@"%@", [compras description]);
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // bar button item
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Detalhes"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(flipView:)];
    self.navigationItem.rightBarButtonItem = flipButton;
    
}

-(IBAction)flipView:(id)sender {
    
    UIInputViewController *histOutViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HistoricoViewController"];
    [self.navigationController pushViewController:histOutViewController animated:YES];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [compras count];
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *tableIdentifier = @"tableIdentifier";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: tableIdentifier];
    
    if (cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableIdentifier];
        
    }
        cell.textLabel.text = [compras objectAtIndex: indexPath.row];
        cell.detailTextLabel.text = [preco objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed: soproImages[indexPath.row]];
    
        return cell;
    }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"buy"]) {
        CGPoint touchPoint = [sender convertPoint:CGPointZero toView: self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
        CheckoutViewController *destViewController = segue.destinationViewController;
        destViewController.precoName = [preco objectAtIndex:indexPath.row];
        destViewController.productName = [compras objectAtIndex:indexPath.row];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }



@end
