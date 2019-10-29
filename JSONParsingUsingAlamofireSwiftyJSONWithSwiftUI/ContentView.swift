//
//  ContentView.swift
//  JSONParsingUsingAlamofireSwiftyJSONWithSwiftUI
//
//  Created by ramil on 29.10.2019.
//  Copyright © 2019 com.ri. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    
    @ObservedObject var obs = observer()
    
    var body: some View {
        
        NavigationView {
            List(obs.datas) { i in
                card(name: i.name, url: i.url)
            }.navigationBarTitle("JSON Parse")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class observer: ObservableObject {
    
    @Published var datas = [datatype]()
    
    init() {
        Alamofire.request("https://api.github.com/users/hadley/orgs").responseData { (data) in
            
            let json = try! JSON(data: data.data!)
            
            for i in json {
                // print(i.1)
                self.datas.append(datatype(id: i.1["id"].intValue, name: i.1["login"].stringValue, url: i.1["avatar_url"].stringValue))
            
                
                // e.g.
                print(i.1["node_id"].stringValue)
            }
        }
    }
}

// here 0 represents the number of indexes in json
// 1 represents the json data of each index...
// in this json data im going to extract only three attributes
// you can extract any attributes u want...
// u can see that we parsed json simply using these dependencies...
// u can retrieve any json attribute by simply changing this...


struct datatype: Identifiable {
    
    var id: Int
    var name: String
    var url: String
}

struct card: View {
    
    var name = ""
    var url = ""
    
    var body: some View {
        HStack {
            AnimatedImage(url: URL(string: url)!)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .shadow(radius: 20)
            
            Text(name)
                .fontWeight(.heavy)
        }
    }
}
