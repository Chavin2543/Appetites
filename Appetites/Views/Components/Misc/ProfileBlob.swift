//
//  ProfileBlob.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct ProfileBlob: View {
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                ProfileBlobShape()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height*0.334,
                        alignment: .center)
                    .foregroundColor(Color("NoirGreen"))
            }
        })
    }
}

struct ProfileBlob_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBlob()
    }
}

struct ProfileBlobShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: -0.03493*width, y: 0.8333*height))
        path.addLine(to: CGPoint(x: -0.02321*width, y: 0.16082*height))
        path.addCurve(to: CGPoint(x: 0.08342*width, y: 0), control1: CGPoint(x: -0.02165*width, y: 0.07131*height), control2: CGPoint(x: 0.02563*width, y: 0))
        path.addLine(to: CGPoint(x: 0.89672*width, y: 0))
        path.addCurve(to: CGPoint(x: 1.00328*width, y: 0.15789*height), control1: CGPoint(x: 0.95377*width, y: 0), control2: CGPoint(x: 1.00072*width, y: 0.06957*height))
        path.addLine(to: CGPoint(x: 1.02243*width, y: 0.82012*height))
        path.addCurve(to: CGPoint(x: 0.90044*width, y: 0.92752*height), control1: CGPoint(x: 1.0253*width, y: 0.91966*height), control2: CGPoint(x: 0.95415*width, y: 0.98231*height))
        path.addCurve(to: CGPoint(x: 0.80144*width, y: 0.94318*height), control1: CGPoint(x: 0.86922*width, y: 0.89568*height), control2: CGPoint(x: 0.82786*width, y: 0.90222*height))
        path.addLine(to: CGPoint(x: 0.79397*width, y: 0.95476*height))
        path.addCurve(to: CGPoint(x: 0.70467*width, y: 0.99126*height), control1: CGPoint(x: 0.77062*width, y: 0.99095*height), control2: CGPoint(x: 0.7365*width, y: 1.0049*height))
        path.addLine(to: CGPoint(x: 0.4351*width, y: 0.87582*height))
        path.addCurve(to: CGPoint(x: 0.3355*width, y: 0.91203*height), control1: CGPoint(x: 0.40009*width, y: 0.86082*height), control2: CGPoint(x: 0.36255*width, y: 0.87447*height))
        path.addLine(to: CGPoint(x: 0.30853*width, y: 0.94948*height))
        path.addCurve(to: CGPoint(x: 0.21693*width, y: 0.94885*height), control1: CGPoint(x: 0.28242*width, y: 0.98574*height), control2: CGPoint(x: 0.24283*width, y: 0.98546*height))
        path.addCurve(to: CGPoint(x: 0.13211*width, y: 0.93994*height), control1: CGPoint(x: 0.19344*width, y: 0.91566*height), control2: CGPoint(x: 0.15828*width, y: 0.91196*height))
        path.addLine(to: CGPoint(x: 0.11445*width, y: 0.95883*height))
        path.addCurve(to: CGPoint(x: -0.03493*width, y: 0.8333*height), control1: CGPoint(x: 0.05027*width, y: 1.02745*height), control2: CGPoint(x: -0.03704*width, y: 0.95409*height))
        path.closeSubpath()
        return path
    }
}
