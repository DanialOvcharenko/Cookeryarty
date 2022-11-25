//
//  IngridientsListView.swift
//  Cookeryarty
//
//  Created by Mac on 23.11.2022.
//

import SwiftUI

struct IngridientsListView: View {
    
    @EnvironmentObject private var vm: DishesViewModel
    
    @State private var showAlert: Bool = false
    @State private var showSheet: Bool = false
    
    let gradient = LinearGradient(colors: [.orange, .green],
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing)
    
    var body: some View {
        NavigationView {
            ZStack {
                gradient
                    .opacity(0.25)
                    .ignoresSafeArea()
                
                ZStack {
                    if vm.ingridients.isEmpty {
                        VStack {
                            Text(vm.typeOfSorting)
                            NoIngridientsView()
                        }
                    } else if vm.ingridients.isEmpty == false && vm.ResultArr.isEmpty {
                        VStack {
                            Text(vm.typeOfSorting)
                            NoIngridientsView()
                        }
                    } else {
                        VStack {
                            Text(vm.typeOfSorting)
                            List {
                                ForEach(vm.ResultArr) { item in
                                    ListRowView(item: item)
                                        .onTapGesture {
                                            withAnimation(.linear) {
                                                vm.updateItem(item: item)
                                            }
                                        }
                                }
                                .onDelete(perform: vm.deleteItem)
                                .onMove(perform: vm.moveItem)
                                .listRowBackground(Color.clear)
                            }
                        }
                    }
                }
                
                .listStyle(PlainListStyle())
                .navigationTitle("Ingridients 📝")
                .navigationBarItems(
                    leading: EditButton(),
                        //.foregroundColor(Color("listRowBackground"))
                    trailing: NavigationLink("Add", destination: AddIngridientsView())
                        //.foregroundColor(Color("listRowBackground"))
                )
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAlert.toggle()
                        } label: {
                            Label("Delete All", systemImage: "x.square")
                                .foregroundColor(Color("AccentColor"))
                        }
                        .alert(isPresented: $showAlert, content: {
                            Alert(
                                title: Text("Shure?"),
                                message: Text("Do you definitely decided to delete all ingridients from the list?"),
                                primaryButton: .default(Text("Clear all")) {
                                    vm.deleteAll()
                                },
                                secondaryButton: .cancel(Text("No, thanks")))
                        })
                    }
                }
                
                toolButton
            }
        }
    }
}

struct IngridientsListView_Previews: PreviewProvider {
    static var previews: some View {
        IngridientsListView()
            .environmentObject(DishesViewModel())
    }
}



extension IngridientsListView {
    
    private var toolButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Button {
                        vm.showIngridientsSheet = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .padding(16)
                            .foregroundColor(.primary)
                            .background(Color("listRowBackground"))
                            .cornerRadius(10)
                            .shadow(radius: 4)
                            .padding()
                    }

                    Menu {
                        Button {
                            vm.updateResultArray()
                            vm.typeOfSorting = "Show all"
                        } label: {
                            Label("Show all", systemImage: "arrow.uturn.backward.circle.badge.ellipsis")
                        }
                        
                        // Filtering by state
                        Menu {
                            Button {
                                vm.filterIsNotCompleted()
                                vm.typeOfSorting = "By state: Is not completed"
                            } label: {
                                Label("Is not completed", systemImage: "circle")
                            }
                            Button {
                                vm.filterIsCompleted()
                                vm.typeOfSorting = "By state: Is completed"
                            } label: {
                                Label("Is completed", systemImage: "checkmark.circle.fill")
                            }
                        } label: {
                            Label("By state", systemImage: "app.badge.checkmark.fill")
                        }
                        
                        // Sorting by title
                        Menu {
                            Button {
                                vm.sortZA()
                                vm.typeOfSorting = "By name: From Z-A"
                            } label: {
                                Label("From Z-A", systemImage: "arrow.up")
                            }
                            Button {
                                vm.sortAZ()
                                vm.typeOfSorting = "By name: From A-Z"
                            } label: {
                                Label("From A-Z", systemImage: "arrow.down")
                            }
                        } label: {
                            Label("By name", systemImage: "abc")
                        }
                        
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .frame(width: 37, height: 32)
                            .foregroundColor(Color("AccentColor"))
                        
                    }
                }

            }
            Spacer()
                .frame(height: 30)
        }
    }
    
}
