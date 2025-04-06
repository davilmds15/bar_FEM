% ................................................................
 % MATLAB codesfor FiniteElement Analysis
 % problem1.m
 % A.J.M. Ferreira,N. Fantuzzi2019
 %%
 
 % clear memory
 clear
 % elementNodes:connectionsat elements
 elementNodes= [1 2;2 3;2 4];
 % numberElements:numberof Elements
 numberElements= size(elementNodes,1);
 % numberNodes:number ofnodes
 numberNodes= 4;
 % for structure:
 % displacements:displacementvector
 % force: forcevector
 % stiffness:stiffnessmatrix
 displacements= zeros(numberNodes,1);
 force = zeros(numberNodes,1);
 stiffness =zeros(numberNodes);
 % applied loadat node 2
 force(2) = 10.0;
 
 % computation of the system stiffness matrix
 for e = 1:numberElements
 % elementDof: element degrees of freedom (Dof)
 elementDof = elementNodes(e,:);
 stiffness(elementDof,elementDof) = ...
 stiffness(elementDof,elementDof) + [1 -1;-1 1];
 end
 stiffness
 % boundary conditions and solution
 % prescribed dofs
 prescribedDof = [1;3;4];
 % free Dof: activeDof
 activeDof = setdiff((1:numberNodes)',prescribedDof);
 % solution
 displacements(activeDof) = ...
 stiffness(activeDof,activeDof)\force(activeDof);
 % output displacements/reactions
 outputDisplacementsReactions(displacements,stiffness,...
 numberNodes,prescribedDof)

function outputDisplacementsReactions...
 (displacements,stiffness,GDof,prescribedDof)
 % output of displacements and reactions in tabular form
 % GDof: total number of degrees of freedom of the problem
 % displacements
 disp('Displacements')
 jj = 1:GDof; format
 [jj' displacements]
 % reactions
 F = stiffness*displacements;
 reactions = F(prescribedDof);
 disp('reactions')
 [prescribedDof reactions]
 end