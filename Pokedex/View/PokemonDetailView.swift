//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Eliude Vemba on 30/05/22.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    let species: PokemonSpecies
    
    @State var index: Int = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.title2)
                Spacer()
                Text(formattedId)
                    .bold()
                    .font(.title2)
                Spacer()
                Image(systemName: "heart.fill")
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 30)
            
            AsyncImage(url: pokemon.url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 300, maxHeight: 300)
                case .empty:
                    ProgressView()
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(spacing: 10) {
                Text("\(pokemon.name.capitalized)")
                    .bold()
                    .font(.title)
                
                Text(firstGenera.genus)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 30) {
                    ForEach(pokemon.types, id: \.self) { type in
                        Text(type.type.name.capitalized)
                            .foregroundStyle(type.type.typeColor())
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(type.type.typeColor(), lineWidth: 3)
                            )
                            
                    }
                }
            }
            
            HStack(spacing: 0) {
                TabBarItemView(title: "About", color: firstTypeColor, isSelected: index == 0)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            index = 0
                        }
                    }
                
                Spacer(minLength: 0)
                
                TabBarItemView(title: "Stats", color: firstTypeColor, isSelected: index == 1)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            index = 1
                        }
                    }
                
                Spacer(minLength: 0)
                
                TabBarItemView(title: "Specie", color: firstTypeColor, isSelected: index == 2)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            index = 2
                        }
                    }
            }
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.top, 25)
            
            VStack {
                TabView(selection: $index) {
                    VStack(spacing: 35) {
                        Text("\(firstFlavorText.flavor_text)")
                            .foregroundStyle(.secondary)
                        
                        HStack {
                            VStack(alignment: .center, spacing: 10) {
                                HStack(alignment: .center) {
                                    Image(systemName: "scalemass")
                                    Text("(\((pokemon.weight / 10).toFormattedString()) kg)")
                                        .fontWeight(.bold)
                                }
                                Text("Weight")
                                    .foregroundStyle(.secondary)
                            }
                            
                            Divider()
                                .padding(.horizontal)
                            
                            VStack(alignment: .center, spacing: 10) {
                                HStack(alignment: .center) {
                                    Image(systemName: "ruler")
                                    Text("(\((pokemon.height / 10).toFormattedString()) m)")
                                        .fontWeight(.bold)
                                }
                                Text("Height")
                                    .foregroundStyle(.secondary)
                            }
                            
                        }
                        .frame(height: 80)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 12))
                        
                        Text("Gender")
                            .font(.title)
                            .bold()
                        
                        VStack {
                            HStack {
                                Text("⚦")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundStyle(.blue)

                                ProgressView(value: 12.5 * (8 - species.gender_rate), total: 100)
                                    .accentColor(Color.blue)
                                
                                Text("\(Double(12.5 * (8 - species.gender_rate)).formatted())%")
                                    .fontWeight(.bold)
                            }

                            HStack {
                                Text("♀")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundStyle(.pink)

                                ProgressView(value: 12.5 * species.gender_rate, total: 100)
                                    .accentColor(Color.pink)
                                
                                Text("\(Double(12.5 * species.gender_rate).formatted())%")
                                    .fontWeight(.bold)
                            }
                        }
                        .padding()
                    }
                    .tag(0)
                    
                    VStack {
                        ForEach(pokemon.stats, id: \.self) { stat in
                            HStack {
                                Text("\(stat.stat.displayName.capitalized)")
                                    .fontWeight(.bold)
                                    .frame(width: 100, alignment: .leading)
                                
                                Text("\(stat.base_stat)")
                                    .fontWeight(.bold)
                                
                                ProgressView(value: Double(stat.base_stat), total: 100)
                                    .accentColor(firstTypeColor)
                            }
                            .padding()
                        }
                    }
                    .tag(1)
                    
                    VStack {
                        Text("Tab 3")
                        Spacer()
                    }
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(minHeight: 0, maxHeight: 450)
                .padding()
            }
            .frame(height: 500)
            
            Spacer()
        }
    }
    
    var firstTypeColor: Color {
        pokemon.types.first!.type.typeColor()
    }
    
    var firstFlavorText: FlavorText {
        species.flavor_text_entries.first(where: { $0.language.name == "en" })!
    }
    
    var firstGenera: Genera {
        species.genera.first(where: { $0.language.name == "en" })!
    }
    
    var formattedId: String {
        String(format: "#%03d", pokemon.id)
    }
}

#Preview {
    PokemonDetailView(pokemon: PokemonViewModel.MOCK_POKEMON, species: PokemonViewModel.MOCK_SPECIES)
}
