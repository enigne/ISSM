%Test Name: SquareSheetShelfStressMHOPenalties
md=triangle(model(),'../Exp/Square.exp',180000.);
md=setmask(md,'../Exp/SquareShelf.exp','');
md=parameterize(md,'../Par/SquareSheetShelf.par');
md=extrude(md,5,1.);
md=setflowequation(md,'SSA','../Exp/SquareHalfRight.exp','fill','HO','coupling','penalties');
md.settings.solver_residue_threshold = 1.e-4;
md.cluster=generic('name',oshostname(),'np',3);
md=solve(md,'Stressbalance');

%Fields and tolerances to track changes
field_names     ={'Vx','Vy','Vz','Vel','Pressure'};
field_tolerances={5e-05,5e-05,5e-05,5e-05,1e-05};
field_values={...
	(md.results.StressbalanceSolution.Vx),...
	(md.results.StressbalanceSolution.Vy),...
	(md.results.StressbalanceSolution.Vz),...
	(md.results.StressbalanceSolution.Vel),...
	(md.results.StressbalanceSolution.Pressure),...
	};
