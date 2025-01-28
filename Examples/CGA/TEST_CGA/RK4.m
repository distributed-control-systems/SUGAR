function final_state=RK4(func,state,delta,steps)
  for i=1:steps
        k1 = func(state);
        k2 = func(state+0.5*delta*k1);
        k3 = func(state+0.5*delta*k2);
        k4 = func(state+delta*k3);
     state = state+delta/6*(2*(k2+k3)+k1+k4)
  end
  final_state=state;
end