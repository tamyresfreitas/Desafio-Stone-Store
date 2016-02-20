//
//  HistoricoViewController.m
//  TesteObjectiveC
//
//  Created by Tamyres Freitas on 2/18/16.
//  Copyright © 2016 Tamyres Freitas. All rights reserved.
//

#import "HistoricoViewController.h"
#import "CheckoutViewController.h"
#import <Firebase/Firebase.h>

@interface HistoricoViewController ()
{
    NSMutableArray *products;
    NSDictionary *transferencias;
    NSString *key;
    NSArray *values;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HistoricoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.automaticallyAdjustsScrollViewInsets = NO;
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    
    // pegando a ultima transferencia no Firebase
    Firebase *ref = [[Firebase alloc] initWithUrl: @"https://desafiostonetamyres.firebaseio.com"];
    
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        
        transferencias = snapshot.value;
        key = snapshot.key;
        [self.tableView reloadData];
     
        
    }
        withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return 10;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *tableIdentifier = @"tableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: tableIdentifier];
    
    if (cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        
        }
    if (indexPath.row == 0){
        
        cell.backgroundColor = [UIColor colorWithRed:(42/255.0) green:(45/255.0) blue:(124/255.0) alpha:1];
        cell.textLabel.text = @"Detalhes da última transação";
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"Geeza Pro" size:20];
       
        cell.textLabel.textAlignment = NSTextAlignmentCenter;


        }
    if (indexPath.row == 1) {
        
           cell.textLabel.text =  [NSString stringWithFormat:@"Produto: %@",[transferencias objectForKey:@"productName"] ];
    
    }
    
    if (indexPath.row == 2) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"Valor: %@",[transferencias objectForKey:@"preco"] ];
    
    }
    
    if (indexPath.row ==3) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"Nome do titular: %@",[transferencias objectForKey:@"nome"] ];
    
    }
    
    if (indexPath.row ==4) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"Número do cartão: %@",[transferencias objectForKey:@"cardNumber"] ];
        
    }
    
    if (indexPath.row == 5) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"CVV: %@",[transferencias objectForKey:@"cvv"] ];
        
    }
    
    if (indexPath.row == 6) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"Mês/Ano de validade: %@/%@",[transferencias objectForKey:@"mes"],[transferencias objectForKey:@"ano"] ];
        
    }
    
    if (indexPath.row == 7) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"Forma de Pagamento: %@",[transferencias objectForKey:@"tipo"] ];
        
    }
    
    if (indexPath.row == 8) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"Bandeira: %@",[transferencias objectForKey:@"bandeira"] ];
        
    }

    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        return 100;
        
    }
    else {
        return 45;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
