# Enviroment variables
export ROS_DOMAIN_ID=30 #Turtlebot3 

# Direccionamiento a los espacios de trabajo de ROS2
source /opt/ros/humble/setup.bash
source ~/ROS2Dev/turtlebot3_ws/install/setup.bash

source /usr/share/colcon_cd/function/colcon_cd.sh
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
export _colcon_cd_root=/opt/ros/humble/

# Alias definitions
alias rosnet='__ros_network'
#alias rospath='echo $ROS_PACKAGE_PATH'
alias rosenv='__ros_print_env_vars' 


# Modelo de TurtleBot3 a emplear
export TURTLEBOT3_MODEL=waffle
# export TURTLEBOT3_MODEL=burger
