//
//  ContentView.swift
//  MetalDemo
//
//  Created by Itsuki on 2025/08/16.
//

import SwiftUI

struct ContentView: View {
    
    private let checkerSize: CGFloat = 10
    private let checkerOpacity: CGFloat = 0.1

    @State private var enableShader = false
    @State private var enableTimeline = true
    @State private var animatableCheckerSize: CGFloat = 5
    
    var body: some View {
        // equivalent to ShaderLibrary.checkerboard(.float(10), .float(0.1))
        let colorShader: Shader = Shader(
            function: ShaderFunction(library: .default, name: "checkerboard"),
            arguments: [.float(checkerSize), .float(checkerOpacity)]
        )

        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    VStack {
                        Text("ColorEffect")
                            .font(.headline)
                        
                        Circle()
                            .fill(.green)
                            .frame(width: 120)
                            .colorEffect(colorShader)

                    }
                    
                    VStack {
                        Text("Distortion")
                            .font(.headline)
                         
                        
                        Text("⭐ Distorted ⭐")
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.3)))
                            .visualEffect({ content, proxy in
                                let maxHeightOffset: CGFloat = proxy.size.width / 1.5
                                
                                let distortionShader: Shader = Shader(
                                    function: ShaderFunction(library: .default, name: "rainbow"),
                                    arguments: [.float(proxy.size.width), .float(maxHeightOffset)]
                                )

                                return content
                                    .distortionEffect(distortionShader, maxSampleOffset: .init(width: .zero, height: maxHeightOffset))
                                    .offset(y: maxHeightOffset)
                                
                            })
                    }
                    .padding(.bottom, 48)
                    
                    VStack(spacing: 16) {
                        Text("Color +  Distortion")
                            .font(.headline)
    
                        HStack(spacing: 48) {
                            VStack {
                                Text("Color First")
                                    .font(.subheadline)
    
    
                                Text("⭐ Itsuki ⭐")
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.3)))
                                    .visualEffect({ content, proxy in
                                        let maxHeightOffset: CGFloat = proxy.size.width / 1.5
    
                                        let distortionShader: Shader = Shader(
                                            function: ShaderFunction(library: .default, name: "rainbow"),
                                            arguments: [.float(proxy.size.width), .float(maxHeightOffset)]
                                        )
    
                                        return content
                                            .colorEffect(colorShader)
                                            .distortionEffect(distortionShader, maxSampleOffset: .init(width: .zero, height: maxHeightOffset))
                                            .offset(y: maxHeightOffset)
    
                                    })
                            }
    
                            VStack {
                                Text("Distortion First")
                                    .font(.subheadline)
    
    
                                Text("⭐ Itsuki ⭐")
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.3)))
                                    .visualEffect({ content, proxy in
                                        let maxHeightOffset: CGFloat = proxy.size.width / 1.5
    
                                        let distortionShader: Shader = Shader(
                                            function: ShaderFunction(library: .default, name: "rainbow"),
                                            arguments: [.float(proxy.size.width), .float(maxHeightOffset)]
                                        )
    
                                        return content
                                            .distortionEffect(distortionShader, maxSampleOffset: .init(width: .zero, height: maxHeightOffset))
                                            .colorEffect(colorShader)
                                            .offset(y: maxHeightOffset)
    
                                    })
                            }
    
                        }
    
                    }
                    .padding(.bottom, 48)
    
                    VStack(spacing: 16) {
                        Text("LayerEffect")
                            .font(.headline)
                        
                        Text("Can be seen as a combination of colorEffect and distortionEffect at a high level.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 16)
    
                        HStack(spacing: 48) {
    
                            VStack {
    
                                Text("Color First")
                                    .font(.subheadline)
    
                                Text("⭐ Itsuki ⭐")
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.3)))
                                    .visualEffect({ content, proxy in
                                        let maxHeightOffset: CGFloat = proxy.size.width / 1.5
    
                                        let layerShader: Shader = Shader(
                                            function: ShaderFunction(library: .default, name: "checkerboardRainbow"),
                                            arguments: [.float(proxy.size.width), .float(maxHeightOffset), .float(checkerSize), .float(checkerOpacity)]
                                        )
    
                                        return content
                                            .layerEffect(layerShader, maxSampleOffset: .init(width: .zero, height: maxHeightOffset))
                                            .offset(y: maxHeightOffset)
    
                                    })
                            }
    
                            VStack {
    
                                Text("Distortion First")
                                    .font(.subheadline)
    
                                Text("⭐ Itsuki ⭐")
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.3)))
                                    .visualEffect({ content, proxy in
                                        let maxHeightOffset: CGFloat = proxy.size.width / 1.5
    
                                        let layerShader: Shader = Shader(
                                            function: ShaderFunction(library: .default, name: "rainbowCheckerboard"),
                                            arguments: [.float(proxy.size.width), .float(maxHeightOffset), .float(checkerSize), .float(checkerOpacity)]
                                        )
    
                                        return content
                                            .layerEffect(layerShader, maxSampleOffset: .init(width: .zero, height: maxHeightOffset))
                                            .offset(y: maxHeightOffset)
    
                                    })
                            }
                        }
                    }
                    .padding(.bottom, 48)
                    

                    
                    
                    VStack(spacing: 24) {
                        Text("Animation")
                            .font(.headline)
    
                        VStack {
                            Text("With `State`")
                                .font(.subheadline)
                                .fontWeight(.medium)
    
    
                            HStack {
                                VStack {
                                    Text("On `isEnable`")
                                        .font(.subheadline)
    
                                    Text("⭐ Animation ⭐")
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.3)))
                                        .colorEffect(colorShader, isEnabled: self.enableShader)
                                        .onAppear {
                                            withAnimation(.linear(duration: 5)) {
                                                self.enableShader = true
                                            }
                                        }
    
                                }
    
                                VStack {
                                    Text("On Argument")
                                        .font(.subheadline)
    
                                    Text("⭐ Animation ⭐")
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.3)))
                                        .colorEffect(Shader(
                                            function: ShaderFunction(library: .default, name: "checkerboard"),
                                            arguments: [.float(animatableCheckerSize), .float(checkerOpacity)]
                                        ))
                                        .onAppear {
                                            withAnimation(.linear(duration: 5)) {
                                                self.animatableCheckerSize = 15
                                            }
                                        }
                                }
    
                            }
    
    
                        }
                        
                        VStack {
                            Text("With Timeline")
                                .font(.subheadline)
                                .fontWeight(.medium)
    
                            Text("Required when using layer Effect modifiers within visualEffect because *Main actor-isolated property 'animationEnabled' can not be referenced from a Sendable closure; this is an error in the Swift 6 language mode*.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
    
                            HStack {
                                VStack {
                                    Text("Pause-able")
                                        .font(.subheadline)
    
                                    let start = Date().timeIntervalSince1970
                                    if self.enableTimeline {
                                        TimelineView(.animation(minimumInterval: nil, paused: !self.enableTimeline)) { context in
                                            let timestamp = context.date.timeIntervalSince1970 - start
                                            let factor = timestamp / 2
                                            if factor > 1 {
                                                DispatchQueue.main.async {
                                                    self.enableTimeline = false
                                                }
                                            }
    
    
                                            return Text("⭐ Animation ⭐")
                                                .padding()
                                                .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.3)))
                                                .visualEffect({ content, proxy in
                                                    let maxHeightOffset: CGFloat = min(proxy.size.width / 1.5, proxy.size.width / 1.5 * factor)
    
                                                    let distortionShader: Shader = Shader(
                                                        function: ShaderFunction(library: .default, name: "rainbow"),
                                                        arguments: [.float(proxy.size.width), .float(maxHeightOffset)]
                                                    )
    
                                                    return content
                                                        .distortionEffect(distortionShader, maxSampleOffset: .init(width: .zero, height: maxHeightOffset))
                                                        .offset(y: maxHeightOffset)
    
                                                })
                                        }
                                    } else {
                                        Text("⭐ Animation ⭐")
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.3)))
                                            .visualEffect({ content, proxy in
                                                let maxHeightOffset: CGFloat = proxy.size.width / 1.5
    
                                                let distortionShader: Shader = Shader(
                                                    function: ShaderFunction(library: .default, name: "rainbow"),
                                                    arguments: [.float(proxy.size.width), .float(maxHeightOffset)]
                                                )
    
                                                return content
                                                    .distortionEffect(distortionShader, maxSampleOffset: .init(width: .zero, height: maxHeightOffset))
                                                    .offset(y: maxHeightOffset)
    
                                            })
    
                                    }
    
                                }
    
                                VStack {
                                    Text("Indefinte")
                                        .font(.subheadline)
    
                                    let start = Date().timeIntervalSince1970
                                    TimelineView(.animation) { context in
                                        let timestamp = context.date.timeIntervalSince1970 - start
    
                                        return Text("⭐ Animation ⭐")
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.3)))
                                            .visualEffect({ content, proxy in
                                                var factor = timestamp / 2
                                                if factor >= 1 {
                                                    factor = factor.truncatingRemainder(dividingBy: 1)
                                                }
    
                                                let maxHeightOffset: CGFloat = min(proxy.size.width / 1.5, proxy.size.width / 1.5 * factor)
    
                                                let distortionShader: Shader = Shader(
                                                    function: ShaderFunction(library: .default, name: "rainbow"),
                                                    arguments: [.float(proxy.size.width), .float(maxHeightOffset)]
                                                )
    
                                                return content
                                                    .distortionEffect(distortionShader, maxSampleOffset: .init(width: .zero, height: maxHeightOffset))
                                                    .offset(y: maxHeightOffset)
    
                                            })
                                    }
    
                                }
                            }
//    
                        }

                    }
                    .padding(.bottom, 48)

                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

                    
            }
            .background(.yellow.opacity(0.1))
            .navigationTitle("Metal Shaders")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

//#Preview {
//    ContentView()
//}
