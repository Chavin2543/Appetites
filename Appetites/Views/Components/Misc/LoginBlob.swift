//
//  LoginBlob.swift
//  Appetites
//
//  Created by chavin Panicharoen on 31/1/2565 BE.
//

import SwiftUI

struct LoginBlob: View {
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                LoginBlobShape()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height*0.461,
                        alignment: .center)
                    .foregroundColor(Color("NoirGreen"))
            }
        })
    }
}

struct LoginBlob_Previews: PreviewProvider {
    static var previews: some View {
        LoginBlob()
    }
}

struct LoginBlobShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.89314*height))
        path.addLine(to: CGPoint(x: 0, y: 0.11834*height))
        path.addCurve(to: CGPoint(x: 0.10667*width, y: 0), control1: CGPoint(x: 0, y: 0.05298*height), control2: CGPoint(x: 0.04776*width, y: 0))
        path.addLine(to: CGPoint(x: 0.9089*width, y: 0))
        path.addCurve(to: CGPoint(x: 1.01553*width, y: 0.12173*height), control1: CGPoint(x: 0.96901*width, y: 0), control2: CGPoint(x: 1.01725*width, y: 0.05507*height))
        path.addLine(to: CGPoint(x: 0.99465*width, y: 0.93047*height))
        path.addCurve(to: CGPoint(x: 0.88505*width, y: 0.97448*height), control1: CGPoint(x: 0.99302*width, y: 0.9935*height), control2: CGPoint(x: 0.92267*width, y: 1.02176*height))
        path.addCurve(to: CGPoint(x: 0.83808*width, y: 0.95098*height), control1: CGPoint(x: 0.87315*width, y: 0.95954*height), control2: CGPoint(x: 0.85605*width, y: 0.95098*height))
        path.addLine(to: CGPoint(x: 0.72262*width, y: 0.95098*height))
        path.addCurve(to: CGPoint(x: 0.6547*width, y: 0.92389*height), control1: CGPoint(x: 0.69783*width, y: 0.95098*height), control2: CGPoint(x: 0.67381*width, y: 0.9414*height))
        path.addLine(to: CGPoint(x: 0.60759*width, y: 0.88073*height))
        path.addCurve(to: CGPoint(x: 0.46705*width, y: 0.88531*height), control1: CGPoint(x: 0.56634*width, y: 0.84294*height), control2: CGPoint(x: 0.50623*width, y: 0.8449*height))
        path.addLine(to: CGPoint(x: 0.41362*width, y: 0.94041*height))
        path.addCurve(to: CGPoint(x: 0.31042*width, y: 0.96711*height), control1: CGPoint(x: 0.38592*width, y: 0.96898*height), control2: CGPoint(x: 0.34666*width, y: 0.97914*height))
        path.addLine(to: CGPoint(x: 0.2183*width, y: 0.93653*height))
        path.addCurve(to: CGPoint(x: 0.13823*width, y: 0.95818*height), control1: CGPoint(x: 0.19005*width, y: 0.92716*height), control2: CGPoint(x: 0.15943*width, y: 0.93543*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.89314*height), control1: CGPoint(x: 0.08648*width, y: 1.01371*height), control2: CGPoint(x: 0, y: 0.97302*height))
        path.closeSubpath()
        return path
    }
}
