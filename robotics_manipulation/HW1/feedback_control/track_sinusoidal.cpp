#include <boost/bind.hpp>
#include <gazebo/gazebo.hh>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <gazebo/transport/transport.hh>
#include <gazebo/msgs/msgs.hh>
#include <gazebo/sensors/SensorManager.hh>
#include <gazebo/sensors/RaySensor.hh>
#include <stdio.h>
#include <fstream>

enum { RIGHT, LEFT };

namespace gazebo
{
  class PDController : public ModelPlugin
  {
    private: physics::WorldPtr _world;
    private: physics::ModelPtr _model;
    private: physics::JointPtr _j1, _j2;
    private: std::ofstream _output_des, _output_current;

    public: PDController()
    {
    }

    public: ~PDController()
    {
      _output_current.close();
      _output_des.close();
    }

    public: void Load(physics::ModelPtr _parent, sdf::ElementPtr _sdf)
    {
      // Store the pointer to the model
      _model = _parent;

      // store the pointer to the world
      _world = _model->GetWorld();

     // Listen to the update event. This event is broadcast every
      // simulation iteration.
      this->updateConnection = event::Events::ConnectWorldUpdateBegin(
          boost::bind(&PDController::OnUpdate, this, _1));

      // get the joints
      this->_j1 = _model->GetJoint("upper_joint");
      this->_j2 = _model->GetJoint("lower_joint");
    }

    // open up files for writing 
    public: void Init()
    {
      _output_current.open("track_sinusoidal.state");
      _output_des.open("track_sinusoidal.desired");
    }

    // Called by the world update start event
    public: void OnUpdate(const common::UpdateInfo & /*_info*/)
    {
      static double sum_p1_err = 0.0;
      static double sum_p2_err = 0.0;

      // get the current time
      double t = _world->GetSimTime().Double();

      // set the desired positions and TODO: velocities
      const double J1_DES = std::sin(t), J2_DES = std::sin(t);
      const double vJ1_DES = std::cos(t), vJ2_DES = std::sin(3*t);

      // setup gains
      const double KP = 475.0, KV = 70.0, KI = 0.30;

      // output current and desired state
      _output_current << _j1->GetAngle(0).Radian() << " " << _j2->GetAngle(0).Radian() << std::endl;
      _output_des << J1_DES << " " << J2_DES << std::endl;

    // get current positions and velocities
      double theta1 = _j1->GetAngle(0).Radian();  
      double dtheta1 = _j1->GetVelocity(0);  
      double theta2 = _j2->GetAngle(0).Radian();  
      double dtheta2 = _j2->GetVelocity(0);
    
      // TODO: setup position and velocity errors
      const double perr1 = J1_DES - theta1;
      const double derr1 = vJ1_DES - dtheta1; 
      const double perr2 = J2_DES - theta2;
      const double derr2 = vJ2_DES - dtheta2;


      // TODO: compute torques
      double tau1 = KP*perr1 + KV*derr1 + KI*sum_p1_err;
      double tau2 = KP*perr2 + KV*derr2 + KI*sum_p2_err;

      // set torques
      this->_j1->SetForce(0, tau1);
      this->_j2->SetForce(0, tau2);

      // TODO: update p1 and p2 error sums
      sum_p1_err += perr1;
      sum_p2_err += perr2;      
    }

    // Pointer to the update event connection
    private: event::ConnectionPtr updateConnection;
  };

  // Register this plugin with the simulator
  GZ_REGISTER_MODEL_PLUGIN(PDController)
}
