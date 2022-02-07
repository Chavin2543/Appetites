//
//  OnboardingBlob.swift
//  Appetites
//
//  Created by chavin Panicharoen on 30/1/2565 BE.
//

import SwiftUI

struct OnboardingBlob: View {
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                OnboardingBlobShape()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height*0.667,
                        alignment: .center)
                    .foregroundColor(Color("NoirBG"))
            }
        })
    }
}

struct OnboardingBlob_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingBlob()
    }
}

struct OnboardingBlobShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99067*width, y: -0.00398*height))
        path.addLine(to: CGPoint(x: -0.04533*width, y: -0.00398*height))
        path.addCurve(to: CGPoint(x: -0.06267*width, y: 0.00895*height), control1: CGPoint(x: -0.05491*width, y: -0.00398*height), control2: CGPoint(x: -0.06267*width, y: 0.00181*height))
        path.addLine(to: CGPoint(x: -0.08692*width, y: 0.78855*height))
        path.addCurve(to: CGPoint(x: 0.10113*width, y: 0.82815*height), control1: CGPoint(x: -0.08934*width, y: 0.86626*height), control2: CGPoint(x: 0.04866*width, y: 0.89532*height))
        path.addCurve(to: CGPoint(x: 0.26064*width, y: 0.81356*height), control1: CGPoint(x: 0.13473*width, y: 0.78514*height), control2: CGPoint(x: 0.21409*width, y: 0.77788*height))
        path.addLine(to: CGPoint(x: 0.44959*width, y: 0.95839*height))
        path.addCurve(to: CGPoint(x: 0.61777*width, y: 0.94355*height), control1: CGPoint(x: 0.49854*width, y: 0.99591*height), control2: CGPoint(x: 0.58192*width, y: 0.98855*height))
        path.addLine(to: CGPoint(x: 0.66646*width, y: 0.88243*height))
        path.addCurve(to: CGPoint(x: 0.82338*width, y: 0.86011*height), control1: CGPoint(x: 0.69916*width, y: 0.84137*height), control2: CGPoint(x: 0.77269*width, y: 0.83091*height))
        path.addLine(to: CGPoint(x: 0.92545*width, y: 0.9189*height))
        path.addCurve(to: CGPoint(x: 1.09733*width, y: 0.85597*height), control1: CGPoint(x: 0.99557*width, y: 0.95928*height), control2: CGPoint(x: 1.09733*width, y: 0.92202*height))
        path.addLine(to: CGPoint(x: 1.09733*width, y: 0.07555*height))
        path.addCurve(to: CGPoint(x: 0.99067*width, y: -0.00398*height), control1: CGPoint(x: 1.09733*width, y: 0.03163*height), control2: CGPoint(x: 1.04958*width, y: -0.00398*height))
        path.closeSubpath()
        return path
    }
}
