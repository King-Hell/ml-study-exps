classdef svm
    properties
        omega;
        b;
        pos;
        neg;
    end
    methods
        function obj=svm(omega,b,pos,neg)
            obj.omega=omega;
            obj.b=b;
            obj.pos=pos;
            obj.neg=neg;
        end
    end
end
