

#include "test.hpp"
#include <Eigen/Core>
#include <Eigen/Dense>
#include <cstdio>
#include <iostream>

using Eigen::MatrixXd;
namespace test{
	void foo()
	{
        MatrixXd m(2,2);
          m(0,0) = 3;
          m(1,0) = 2.5;
          m(0,1) = -1;
          m(1,1) = m(1,0) + m(0,1);
          std::cout << m << std::endl;
        
		printf("hello from Test!\n");
	}
}
