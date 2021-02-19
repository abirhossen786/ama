#include <ros/ros.h>
#include <std_msgs/Int16MultiArray.h>
#include <sensor_msgs/LaserScan.h>
#include <vector>

const char RAW_PROXIMITY_TOPIC[] = "/hospitalbot/proximity_raw";

class ProximitySensor {
private:
    sensor_msgs::LaserScan message;
    ros::Publisher publisher;
    int readingCount;

public:
    ProximitySensor(const float fieldOfView, const float minimumRange, const float maximumRange, const int readingCount, const std::string topic, const std::string frame) {
        this->message.header.frame_id = frame;
        this->message.angle_min = -(fieldOfView / 2.0);
        this->message.angle_max = (fieldOfView / 2.0);
        this->message.angle_increment = fieldOfView / readingCount;
        this->message.time_increment = 0;
        this->message.range_min = minimumRange;
        this->message.range_max = maximumRange;
        this->message.ranges.resize(readingCount);

        this->readingCount = readingCount;

        ros::NodeHandle n;
        this->publisher = n.advertise<sensor_msgs::LaserScan>(topic, 10);
    }

    void publish(ros::Time time, float range) {
        this->message.header.stamp = time;

        range = range > this->message.range_max ? this->message.range_max : (range < this->message.range_min ? this->message.range_min : range);
        
        for(int i = 0; i < this->readingCount; i++) {
            this->message.ranges[i] = range;
        }

        this->publisher.publish(this->message);
    }
};

class ProximitySensorArray {
private:
    std::vector< ProximitySensor > proximitySensorArray;
public:
    void registerProximitySensor(const float fieldOfView, const float minimumRange, const float maximumRange, const int readingCount, const std::string topic, const std::string frame) {
        this->proximitySensorArray.push_back(ProximitySensor(fieldOfView, minimumRange, maximumRange, readingCount, topic, frame));
    }

    void process(int index, ros::Time time, float range) {
        if(range >= 0) {
            this->proximitySensorArray[index].publish(time, range);
        }
    }

    int getProximitySensorCount() {
        return this->proximitySensorArray.size();
    }
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "proximity_publisher");
    
    ros::NodeHandle n("~");

    ProximitySensorArray proximitySensorArray;
    proximitySensorArray.registerProximitySensor(0.436332, 0.03, 0.90, 100, "/hospitalbot/proximity/front/left/four", "proximity_front_left_four_link");
    proximitySensorArray.registerProximitySensor(0.436332, 0.03, 0.90, 100, "/hospitalbot/proximity/front/left/three", "proximity_front_left_three_link");
    proximitySensorArray.registerProximitySensor(0.436332, 0.03, 0.90, 100, "/hospitalbot/proximity/front/left/two", "proximity_front_left_two_link");
    proximitySensorArray.registerProximitySensor(0.436332, 0.03, 0.90, 100, "/hospitalbot/proximity/front/left/one", "proximity_front_left_one_link");
    proximitySensorArray.registerProximitySensor(0.436332, 0.03, 0.90, 100, "/hospitalbot/proximity/front/middle", "proximity_front_middle_link");
    proximitySensorArray.registerProximitySensor(0.436332, 0.03, 0.90, 100, "/hospitalbot/proximity/front/right/one", "proximity_front_right_one_link");
    proximitySensorArray.registerProximitySensor(0.436332, 0.03, 0.90, 100, "/hospitalbot/proximity/front/right/two", "proximity_front_right_two_link");
    proximitySensorArray.registerProximitySensor(0.436332, 0.03, 0.90, 100, "/hospitalbot/proximity/front/right/three", "proximity_front_right_three_link");
    proximitySensorArray.registerProximitySensor(0.436332, 0.03, 0.90, 100, "/hospitalbot/proximity/front/right/four", "proximity_front_right_four_link");
    proximitySensorArray.registerProximitySensor(0.436332, 0.03, 0.90, 100, "/hospitalbot/proximity/rear/middle", "proximity_rear_middle_link");

    ros::Subscriber rawProximitySubscriber = n.subscribe(RAW_PROXIMITY_TOPIC, 1000, 
        static_cast<boost::function<void(const std_msgs::Int16MultiArray::ConstPtr&)>>([&](const std_msgs::Int16MultiArray::ConstPtr& rawProximityArray) {
            for(int i = 0; i < proximitySensorArray.getProximitySensorCount(); i++) {
                proximitySensorArray.process(i, ros::Time::now(), (float)rawProximityArray->data[i] / 1000.0);
            }
        })
    );

    ros::Rate rate(5.0);
    while(n.ok()) {
        ros::spinOnce();
        rate.sleep();
    }
    
    return 0;
}