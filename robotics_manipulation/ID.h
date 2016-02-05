List(List(Rule(tau1,g*l1*m1*Sin(theta1(t)) + g*l1*m2*Sin(theta1(t)) + 
      g*l2*m2*Sin(theta1(t) + theta2(t)) - 
      2*l1*l2*m2*Sin(theta2(t))*Derivative(1)(theta1)(t)*
       Derivative(1)(theta2)(t) - 
      l1*l2*m2*Sin(theta2(t))*Power(Derivative(1)(theta2)(t),2) + 
      Power(l1,2)*m1*Derivative(2)(theta1)(t) + 
      Power(l1,2)*m2*Derivative(2)(theta1)(t) + 
      Power(l2,2)*m2*Derivative(2)(theta1)(t) + 
      2*l1*l2*m2*Cos(theta2(t))*Derivative(2)(theta1)(t) + 
      Power(l2,2)*m2*Derivative(2)(theta2)(t) + 
      l1*l2*m2*Cos(theta2(t))*Derivative(2)(theta2)(t)),
    Rule(tau2,l2*m2*(g*Sin(theta1(t) + theta2(t)) + 
        l1*Sin(theta2(t))*Power(Derivative(1)(theta1)(t),2) + 
        (l2 + l1*Cos(theta2(t)))*Derivative(2)(theta1)(t) + 
        l2*Derivative(2)(theta2)(t)))))
		
		
tau1 = g*l1*m1*sin(theta1) + g*l1*m2*sin(theta1) + g*l2*m2*sin(theta1s + theta2s) - 
      2*l1*l2*m2*sin(theta2)*(dtheta1)*(dtheta2)- 
	  l1*l2*m2*sin(theta2)*pow(dtheta2),2) + pow(l1,2)*m1*(ddtheta1)+ 
      pow(l1,2)*m2*(ddtheta1) + pow(l2,2)*m2*(ddtheta1) + 2*l1*l2*m2*cos(theta2)*(ddtheta1) + 
      pow(l2,2)*m2*(ddtheta2) + 
      l1*l2*m2*cos(theta2)*(ddtheta2));
	  
tau2 = l2*m2*(g*sin(theta1 + theta2) +l1*sin(theta2)*pow((ddtheta1),2) + 
        (l2 + l1*Cos(theta2(t)))*Derivative(2)(theta1)(t) + 
        l2*(ddtheta2));