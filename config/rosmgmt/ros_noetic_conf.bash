# Direccionamiento a los espacios de trabajo de ROS
source /opt/ros/noetic/setup.bash
source ~/ROSDev/robot_ws/devel/setup.bash
source ~/ROSDev/simulation_ws/devel/setup.bash
# source ~/ROSDev/catkin_ws/devel/setup.bash

# Alias definitions
alias rosnet='__ros_network'
alias rospath='echo $ROS_PACKAGE_PATH'
alias rosenv='__ros_print_env_vars'

# Export enviroment variable for default TurtleBot3 model 
export TURTLEBOT3_MODEL=waffle

