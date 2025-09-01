//
//  ViewController.swift
//  ListaInteligente
//
//  Created by Paulo Roberto on 14/08/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tabela: UITableView!
    @IBOutlet weak var campoTexto: UITextField!
    @IBOutlet weak var rotuloResultado: UILabel!
    
    @IBAction func botaoClicado(_ sender: UIButton) {
        if let texto = campoTexto.text, !texto.isEmpty {
            itens.append(texto) // adiciona no array
            tabela.reloadData() // recarrega a lista
            salvarItens()
            campoTexto.text = "" // limpa o campo
        }
    }
    var itens : [String] = []
    
    // Quantas linhas terá a tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    // O que aparece em cada linha
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: "celula")
        celula.textLabel?.text = itens[indexPath.row]
        return celula
    }
    
    //Remover linha
    func tableView(_ tableView: UITableView, commit editStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editStyle == .delete {
            itens.remove(at: indexPath.row) // remove do array
            tabela.deleteRows(at: [indexPath], with: .fade) // remove da tabela com animação
            salvarItens() // Salvar após remover
        }
    }
    
    // Salva os itens no UserDefaults
    func salvarItens () {
        UserDefaults.standard.set(itens, forKey: "minhaLista")
    }
    
    // Carrega os itens ao abrir o app
    func carregarItens() {
        if let listaSalva = UserDefaults.standard.array(forKey: "minhaLista") as? [String] {
            itens = listaSalva
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carregarItens()
        tabela.dataSource = self
        tabela.delegate=self
    }


}

