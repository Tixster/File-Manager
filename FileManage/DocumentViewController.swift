//
//  DocumentViewController.swift
//  FileManage
//
//  Created by Кирилл Тила on 01.06.2021.
//

import UIKit

class DocumentViewController: UIViewController {
    
    var pictures = [Data]()
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.mediaTypes = ["public.image"]
        picker.sourceType = .photoLibrary
        return picker
    }()
    
    private var saveImage = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "CellId")
        
    }
    
    private func loaddImage(){
        let directory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let directoryContent = try! FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
        
        let imageFiles = directoryContent.filter{$0.pathExtension == "png"}
        
        pictures.removeAll()
        imageFiles.forEach({image in
            let data = try! Data.init(contentsOf: image)
            pictures.insert(data, at: 0)
        })
    }
    
    
    @IBAction private func addPhoto(_ sender: Any) {
        present(picker, animated: true, completion: nil)
    }
    
    
}

extension DocumentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        loaddImage()
        
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! TableViewCell
        
        cell.pictureFromData.image = UIImage(data: pictures[indexPath.row])
        return cell
    }
    
}


extension DocumentViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerdImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageName = UUID().uuidString + ".png"
            let imagePath = getDocumetnDirectory().appendingPathComponent(imageName)
            if let pngData = pickerdImage.pngData() {
                try? pngData.write(to: imagePath)
                print("Image Save to path \(imagePath)")
            }
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func getDocumetnDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
