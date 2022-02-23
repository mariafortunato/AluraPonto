//
//  Perfil.swift
//  Alura Ponto
//
//  Created by Maria Alice Rodrigues Fortunato on 23/02/22.
//

import UIKit


class Perfil {
    private let nomeFoto = "perfil.png"
                        // receber a imagem no parametro
    func salvarImagem(_ imagem: UIImage) {
                                                    // tipo da paste        tipo de permissao  primeiro dessa lista
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let urlArquivo = diretorio.appendingPathComponent(nomeFoto) // url completa diretorio\perfil.... juntar os dois
                        // saber se ja existe uma foto com esse nome
        if FileManager.default.fileExists(atPath: urlArquivo.path) {
            // remover a foto
            removerImagemAntiga(urlArquivo.path)
        }
        
        // salvar a imagem em binario
                                // converter foto          qualidade da imagem
        guard let imagemData = imagem.jpegData(compressionQuality: 1) else { return }
        
        do {
            try imagemData.write(to: urlArquivo) // tentar salvar foto
        } catch let error{
            print(error)
        }
    }
    private func removerImagemAntiga(_ url: String) {
        // verificação
        do {
            try FileManager.default.removeItem(atPath: url)
        } catch let error{
            print(error)
        }
    }
    func carregarImagem() -> UIImage? {
        let diretorio = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        
        let urlArquivo = NSSearchPathForDirectoriesInDomains(diretorio, userDomainMask, true) // url da imagem, local
        
        if let caminho = urlArquivo.first {
            let urlImagem = URL(fileURLWithPath: caminho).appendingPathComponent(nomeFoto) // juntar caminho com nome da foto
            
            // transformar para uiimage ( verificar conteudo do arquivo e passar para uiimage.converter para string). converter para string
            let imagem = UIImage(contentsOfFile: urlImagem.path)
            return imagem
        }
        
        return nil
    }
}
