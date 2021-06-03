//
//  DocumentViewController.swift
//  FileManage
//
//  Created by Кирилл Тила on 01.06.2021.
//

import UIKit


class Image {
    
    let defaults = UserDefaults.standard
    let keyImage = "imageName"
    static let shared = Image()
    
    struct FileImage: Codable {
        let fileName: String
        let path: String
    }
    
    var pictures: [FileImage] {
        get {
            if let data = defaults.value(forKey: keyImage) as? Data {
                let image = try! PropertyListDecoder().decode([FileImage].self, from: data)
                if defaults.bool(forKey: "sort") == true {
                    let sort = image.sorted{$0.fileName > $1.fileName}
                    return sort
                } else {
                    let sort = image.sorted{$0.fileName < $1.fileName}
                    return sort
                }
                
            } else {
                return [FileImage]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: keyImage)
            }
        }
    }
    
    func saveImage(fileName: String, path: String){
        let image = FileImage(fileName: fileName, path: path)
        pictures.insert(image, at: 0)
    }
    
}

class DocumentViewController: UIViewController {
    
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
    
    @IBAction private func addPhoto(_ sender: Any) {
        present(picker, animated: true, completion: nil)
    }
    
}

extension DocumentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Image.shared.pictures.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! TableViewCell
        
        cell.pictureFromData.image = UIImage(contentsOfFile: Image.shared.pictures[indexPath.row].path)
        return cell
    }
    
}

extension DocumentViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerdImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageName = UUID().uuidString + ".jpg"
            let imagePath = getDocumetnDirectory().appendingPathComponent(imageName)
            if let jpgData = pickerdImage.jpegData(compressionQuality: 0.1) {
                try? jpgData.write(to: imagePath)
                Image.shared.saveImage(fileName: imageName, path: imagePath.path)
                }
                print("Image Save to path \(imagePath)")
            
        }

        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func getDocumetnDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}

